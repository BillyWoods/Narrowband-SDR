// compile with `gcc transpose_speed_test.c -o transpose_speed_test`

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <string.h>

#define DEBUG_PRINT

const int num_samples = 96000000; // 3 million samples per second from the ADC

// number of channels is 8, which fits nicely into an 8-bit packet
// 16 BYTES per simulataneous sample from the 8 ADCs
uint8_t packets[16] = {
  0x00,                   // a zero byte which the ADCs will give us to start
  0x10, 0xCC, 0x0F, 0xF0,
  0x10, 0xCC, 0x0F, 0xF0,
  0x10, 0xCC, 0x0F, 0xF0,
  0x00, 0x00, 0x00        // zeroes to end, which we'll get from ADC
};
// Each sample on each channel is 12 bits (although the ADCs clock out 16 bits)
// so 16 bit int is the nearest fit
int16_t channels[8];

// predefs
void basic_transpose(uint8_t in[16], uint16_t out[8]);
void fast_transpose(uint8_t in[16], uint16_t out[8]);
void debug_print(uint8_t dat[16], int row_width, int print_bits);

#ifndef DEBUG_PRINT
int main(void) {

  clock_t cpu_t = clock();
  time_t start_t;
  time(&start_t);

  // we'll do it a bunch of times to get an accurate time measurement
  for (int i = 0; i < num_samples; i++) {
    fast_transpose(packets, channels);
  }

  cpu_t = clock() - cpu_t;
  time_t end_t; time(&end_t);
  double cpu_time = ((double) cpu_t) / CLOCKS_PER_SEC;
  double real_time = difftime(end_t, start_t);
  double bits_xferred = 16.f * 8.f * num_samples;
  double bitrate = bits_xferred / (real_time > cpu_time ? real_time : cpu_time);
  printf("Bits processed: %.0f\nProcessor time: %.1f\nReal time: %.1f\nBitrate: %.2f bits/s\n",
    bits_xferred,
    cpu_time,
    real_time,
    bitrate
  );

  return 0;

}

#else
int main(void) {

  fast_transpose(packets, channels);

  return 0;

}
#endif

/* -------------------------------------------------------------------------
 * The methods for doing a transposition from 16 x 8 to an 8 x 16 bit matrix
 *
 * See https://books.google.com.au/books?id=iBNKMspIlqEC&lpg=PP1&pg=RA1-SL20-PA8&redir_esc=y&hl=en#v=onepage&q&f=false
 * for details/approach used by fast_transpose. Note that our MSByte of data is at the lowest
 * address of in[] (big endian), but the system is little endian, so that has to be kept in mind
 * when casting from byte arrays to 64-bit ints. This means our shifting and masks look a little
 * different than in the referenced book. 
 * ------------------------------------------------------------------------- */
const uint8_t BIT_MASKS[8] = { 1, 2, 4, 8, 16, 32, 64, 128 };

inline void basic_transpose(uint8_t in[16], uint16_t out[8]) {
  for (int j = 0; j < 16; j++) {
    for (int k = 0; k < 8; k++) {
      out[k] = (out[k] << 1) | ((in[j] & BIT_MASKS[k]) != 0);
    }
  }
}

inline void fast_transpose(uint8_t in[16], uint16_t out[8]) {
  // we'll work in-place on the output variable
  memcpy(out, in, 16);
  // use as much 64-bit math as possible
  uint64_t* out_64 = (uint64_t*) out;
  uint64_t t, t1;

#ifdef DEBUG_PRINT
  printf("\nThe input data we're operating on:\n");
  debug_print((uint8_t*) out, 8, 1);
#endif

  // stage 1: 2x2 transposes
  t = (out_64[0] ^ (out_64[0] << 9)) & 0xAA00AA00AA00AA00;
  out_64[0] = out_64[0] ^ t ^ (t >> 9);
  t = (out_64[1] ^ (out_64[1] << 9)) & 0xAA00AA00AA00AA00;
  out_64[1] = out_64[1] ^ t ^ (t >> 9);
#ifdef DEBUG_PRINT
  printf("\nAfter 2x2 transposes:\n");
  debug_print((uint8_t*) out, 8, 1);
#endif
  
  // stage 2: 2x2 transposes of 2x2 transposes
  t = (out_64[0] ^ (out_64[0] << 18)) & 0xCCCC0000CCCC0000;
  out_64[0] = out_64[0] ^ t ^ (t >> 18);
  t = (out_64[1] ^ (out_64[1] << 18)) & 0xCCCC0000CCCC0000;
  out_64[1] = out_64[1] ^ t ^ (t >> 18);
#ifdef DEBUG_PRINT
  printf("\nAfter 2x2 transposes of 2x2 transposes (4x4 transposes):\n");
  debug_print((uint8_t*) out, 8, 1);
#endif

  // stage 3: 2x2 transposes of 2x2 transposes of 2x2 transposes
  t = (out_64[0] ^ (out_64[0] << 36)) & 0xF0F0F0F000000000;
  out_64[0] = out_64[0] ^ t ^ (t >> 36);
  t = (out_64[1] ^ (out_64[1] << 36)) & 0xF0F0F0F000000000;
  out_64[1] = out_64[1] ^ t ^ (t >> 36);
#ifdef DEBUG_PRINT
  printf("\nAfter 2x2 transposes of 2x2 transposes of 2x2 transposes (8x8 transposes):\n");
  debug_print((uint8_t*) out, 8, 1);
  debug_print((uint8_t*) out, 8, 0);
#endif

  // stage 4: interleave the low bytes in amongst the high bytes
  // stage 4.1
  // current channel ordering: LSB {0h, 1h, 2h, 3h, 4h, 5h, 6h, 7h, 0l, 1l, 2l, 3l, 4l, 5l, 6l, 7l} MSB
  t = out_64[0] & 0xFF00FF00FF00FF00;
  t1 = out_64[1] & 0x00FF00FF00FF00FF;
  out_64[0] = ((out_64[0] ^ t) << 8) ^ t1;
  out_64[1] = ((out_64[1] ^ t1) >> 8) ^ t;
  // the uint16_ts are assembled into channels which make sense, but channel
  // ordering is wrong, so we'll do some bigger group shuffles now
  // current channel ordering: LSB {0, 2, 4, 6, 1, 3, 5, 7} MSB
  // stage 4.2
  t = out_64[0] & 0xFFFF0000FFFF0000;
  t1 = out_64[1] & 0x0000FFFF0000FFFF;
  out_64[0] = (out_64[0] ^ t) ^ (t1 << 16);
  out_64[1] = (out_64[1] ^ t1) ^ (t >> 16);
  // current channel ordering: LSB {0, 1, 4, 5, 2, 3, 6, 7} MSB
  // stage 4.3
  t = out_64[0] & 0xFFFFFFFF00000000;
  t1 = out_64[1] & 0x00000000FFFFFFFF;
  out_64[0] = (out_64[0] ^ t) ^ (t1 << 32);
  out_64[1] = (out_64[1] ^ t1) ^ (t >> 32);
  // current channel ordering: LSB {0, 1, 2, 3, 4, 5, 6, 7} MSB
#ifdef DEBUG_PRINT
  printf("\nAfter interleaving the LSBytes in:\n");
  debug_print((uint8_t*) out, 16, 0);
#endif


}

// https://stackoverflow.com/a/3208376
#define BYTE_TO_BINARY_PATTERN "%c %c %c %c %c %c %c %c "
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0') 

void debug_print(uint8_t dat[16], int row_width, int print_bits) {
  for (int i = 0; i < 16; i++) {
    if (print_bits)
      printf(BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(dat[i]));
    else
      printf("%02x", dat[i]);

    if (row_width == 16) {
      if (i % 2 == 1)
        printf("\n");
    } else {
      printf("\n");
    }
  }
}

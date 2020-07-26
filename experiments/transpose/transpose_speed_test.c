// compile with `gcc transpose_speed_test.c -o transpose_speed_test`

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <string.h>

#define DEBUG_PRINT

const int num_samples = 12000000; // 12 million is 4 seconds worth of sampling

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
void debug_print(uint8_t dat[16]);

/*
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
  int bits_xferred = 12 * num_samples;
  double bitrate = bits_xferred / (real_time > cpu_time ? real_time : cpu_time);
  printf("Bits processed: %d\nProcessor time: %.1f\nReal time: %.1f\nBitrate: %.2f bits/s\n",
    bits_xferred,
    cpu_time,
    real_time,
    bitrate
  );

  return 0;

}
*/

int main(void) {

  fast_transpose(packets, channels);

  return 0;

}

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
  memcpy(out, in, 16*8);
  // use as much 64-bit math as possible
  uint64_t* in_64 = (uint64_t*) in;
  uint64_t* out_64 = (uint64_t*) out;
  uint64_t t = 0;

#ifdef DEBUG_PRINT
  printf("\nThe input data we're operating on:\n");
  debug_print((uint8_t*) out);
#endif

  // stage 1: 2x2 transposes
  for (int i = 0; i < 2; i++) {
    t = (out_64[i] ^ (out_64[i] << 9)) & 0xAA00AA00AA00AA00;
    out_64[i] = out_64[i] ^ t ^ (t >> 9);
  }
#ifdef DEBUG_PRINT
  printf("\nAfter 2x2 transposes:\n");
  debug_print((uint8_t*) out);
#endif
  
  // stage 2: 2x2 transposes of 2x2 transposes
  for (int i = 0; i < 2; i++) {
    t = (out_64[i] ^ (out_64[i] << 18)) & 0xCCCC0000CCCC0000;
    out_64[i] = out_64[i] ^ t ^ (t >> 18);
  }
#ifdef DEBUG_PRINT
  printf("\nAfter 2x2 transposes of 2x2 transposes (4x4 transposes):\n");
  debug_print((uint8_t*) out);
#endif

  // stage 3: 2x2 transposes of 2x2 transposes of 2x2 transposes
  for (int i = 0; i < 2; i++) {
    // TODO: complete this for 64 bits and correct for endianness
    t = (out_64[i] ^ (out_64[i] << 36)) & 0xF0F0F0F000000000;
    out_64[i] = out_64[i] ^ t ^ (t >> 36);
  }
#ifdef DEBUG_PRINT
  printf("\nAfter 2x2 transposes of 2x2 transposes of 2x2 transposes (8x8 transposes):\n");
  debug_print((uint8_t*) out);
#endif

  // stage 4: interleave the low bytes in amongst the high bytes


}

// https://stackoverflow.com/a/3208376
#define BYTE_TO_BINARY_PATTERN "%c %c %c %c %c %c %c %c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0') 

void debug_print(uint8_t dat[16]) {
  for (int i = 0; i < 16; i++) {
    printf(BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(dat[i]));
    //if (i % 2 == 1)
      printf("\n");
  }
}

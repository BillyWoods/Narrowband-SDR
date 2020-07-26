// compile with `gcc -fopenmp transpose_speed_test.c -o transpose_speed_test`

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <string.h>

const int num_samples = 48000000; // 48 million is 16 seconds worth of sampling

// volatile type so as not to be optimised out *hopefully*
// number of channels is 8, which fits nicely into an 8-bit packet
volatile uint8_t packet = 0xCC;
// each sample on each channel is 12 bits, so 16 bit int is the nearest fit
int16_t channels[8];

const uint8_t BIT_MASKS[8] = { 1, 2, 4, 8, 16, 32, 64, 128 };

int main(void) {
	clock_t cpu_t = clock();
	time_t start_t;
	time(&start_t);
	for (int i = 0; i < num_samples; i++) {
		memset((void*) channels, 0, 8*sizeof(uint16_t));
		for (int j = 0; j < 12; j++) {
			// try out parallelising this inner loop
			#pragma omp parallel for
			for (int k = 0; k < 8; k++) {
				channels[k] = (channels[k] << 1) | ((packet & BIT_MASKS[k]) != 0);
			}
		}
	}
	cpu_t = clock() - cpu_t;
	double cpu_time = ((double) cpu_t) / CLOCKS_PER_SEC;
	time_t end_t;
	time(&end_t);
	double real_time = difftime(end_t, start_t);
	int bits_xferred = 12 * num_samples;
	double bitrate = bits_xferred / real_time;
	printf("Bits processed: %d\nProcessor time: %.1f\nReal time: %.1f\nBitrate: %.2f bits/s\n",
		bits_xferred,
		cpu_time,
		real_time,
		bitrate
	);
	return 0;
}

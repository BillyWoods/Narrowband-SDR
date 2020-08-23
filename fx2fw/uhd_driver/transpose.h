#ifndef _TRANSPOSE_H
#define _TRANSPOSE_H

//#define DEBUG_PRINT

inline void fast_transpose(uint16_t out[8]);

// transposes a set of 8 (because 8 channels) 12-bit samples
void transpose_ADC_reading(uint8_t in[12], uint16_t out[8], bool sign_extend);

#endif

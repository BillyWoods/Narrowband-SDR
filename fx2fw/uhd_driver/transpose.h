#ifndef _TRANSPOSE_H
#define _TRANSPOSE_H

//#define DEBUG_PRINT
#define FLIP_CHANNEL_ORDER

inline void fast_transpose(uint16_t out[8]);

// transposes a set of 8 (because 8 channels) 12-bit samples
// this one needs to copy over into a space with more memory (as the input space isn't large enough)
void transpose_ADC_reading_12(uint8_t in[12], uint16_t out[8], bool sign_extend);
// this one can work in-place
void transpose_ADC_reading_16(uint8_t inplace[16]);

#endif

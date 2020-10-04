#include <fx2regs.h>

#ifndef __SPI_H__
#define __SPI_H__

#define SPI_MOSI        PD0
#define SPI_CH_SEL_1    PD1
#define SPI_CH_SEL_2    PD2
#define SPI_CH_SEL_3    PD3
#define SPI_CH_SEL_4    PD4
#define SPI_CLK         PD5

#define bmSPI_CPOL (1 << 1)
#define bmSPI_CPHA (1 << 0)

void SPI_init(BYTE mode);
void SPI_bit_bang(BYTE mode, BYTE channel, BYTE length, BYTE* data);

#endif


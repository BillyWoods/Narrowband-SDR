#include "spi.h"

void SPI_init(BYTE mode) {
  // set all SPI lines (which are on port D) as outputs
  OED = 0xFF;
  // set all nCS pins high
  SPI_CH_SEL_1 = 1;
  SPI_CH_SEL_2 = 1;
  SPI_CH_SEL_3 = 1;
  SPI_CH_SEL_4 = 1;
  // if clock should be high in idle state, set it as such
  SPI_CLK = (mode & bmSPI_CPOL) && 1;
  SPI_MOSI = 1;
}

// from Cypress AN14558:  https://www.cypress.com/file/125791/download
inline void SPI_byte_write(BYTE mode, BYTE b) {
  // TODO: allow for different modes? Although this is going to get correct data read
  // regardless of falling or rising edge

  SPI_CLK = 0; // whether this first clock change is included or not will depend on mode

  if (b & 0x80) SPI_MOSI = 1; else SPI_MOSI = 0;
  SPI_CLK = 1; SPI_CLK = 0;
  if (b & 0x40) SPI_MOSI = 1; else SPI_MOSI = 0;
  SPI_CLK = 1; SPI_CLK = 0;
  if (b & 0x20) SPI_MOSI = 1; else SPI_MOSI = 0;
  SPI_CLK = 1; SPI_CLK = 0;
  if (b & 0x10) SPI_MOSI = 1; else SPI_MOSI = 0;
  SPI_CLK = 1; SPI_CLK = 0;
  if (b & 0x08) SPI_MOSI = 1; else SPI_MOSI = 0;
  SPI_CLK = 1; SPI_CLK = 0;
  if (b & 0x04) SPI_MOSI = 1; else SPI_MOSI = 0;
  SPI_CLK = 1; SPI_CLK = 0;
  if (b & 0x02) SPI_MOSI = 1; else SPI_MOSI = 0;
  SPI_CLK = 1; SPI_CLK = 0;
  if (b & 0x01) SPI_MOSI = 1; else SPI_MOSI = 0;
  SPI_CLK = 1;

  SPI_CLK = 0; // whether this first clock change is included or not will depend on mode
}

void SPI_bit_bang(BYTE mode, BYTE channel, BYTE length, BYTE* data) {
  BYTE data_index = 0;

  // select correct chips
  SPI_CH_SEL_1 = !(channel & 0x01);
  SPI_CH_SEL_2 = !(channel & 0x02);
  SPI_CH_SEL_3 = !(channel & 0x04);
  SPI_CH_SEL_4 = !(channel & 0x08);

  for (data_index = 0; data_index < length; data_index++) {
    SPI_byte_write(mode, data[data_index]);
  }

  // if clock should be high in idle state, set it as such
  SPI_CLK = (mode & bmSPI_CPOL) && 1;

  // put the chip select lines high again
  SPI_CH_SEL_1 = 1;
  SPI_CH_SEL_2 = 1;
  SPI_CH_SEL_3 = 1;
  SPI_CH_SEL_4 = 1;
}

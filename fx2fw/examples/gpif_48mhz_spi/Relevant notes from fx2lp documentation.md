What we need to do here:
	* Generate a 48MHz clock for the SPI bus (see the IFCLK)
	* Generate an nCS signal compliant with the MAX19777's usage of the CS line (see the CTL lines)
	* Capture 8 data input lines, read on every rising edge of the 48MHz clock (see the FD lines)
	
	
Notes below pulled from datasheet "AN66806 - Getting Started With EZ-USB FX2LP GPIF". Emphasis added.

IFCLK (interface clock) is the reference clock for all GPIF operations. It can be an input or **output signal**;you can
select edge, rising, or falling as the active edge. As an input signal, it can be driven using an external clock in the
5 MHz to 48 MHz range. **As an output signal, IFCLK can be driven by FX2LP‘s internal clock at either 30 MHz or
48 MHz.**

CTL[5:0] (output only)
Control outputs provide signals required by the external peripheral such as **read/write strobes, enables,** and divided
clock

FD[15:0] (bidirectional)
The data bus is the conduit for payload data transferred between FX2LP endpoint FIFOs and the external peripheral.
It can be configured to operate as an **8-bit** or 16-bit interface and can be tristated if the system requires it. In 16-bit
mode, FD[7:0] represents the first byte in the endpoint FIFO and FD[15:8] represents the second byte. 


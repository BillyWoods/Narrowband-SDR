/*
From the MAX11131 datasheet:

	"The MAX11129–MAX11132 feature a serial interface
	compatible with SPI/QSPI and MICROWIRE devices. For
	SPI/QSPI, ensure the CPU serial interface runs in master
	mode to generate the serial clock signal. Select the SCLK
	frequency of 48MHz or less, and set clock polarity (CPOL)
	and phase (CPHA) in the FP control registers to the same
	value. The MAX11129–MAX11132 operate with SCLK
	idling high, and thus operate with CPOL = CPHA = 1.
	Set CS low to latch input data at DIN on the rising edge
	of SCLK. Output data at DOUT is updated on the falling
	edge of SCLK. A high-to-low transition on CS samples
	the analog inputs and initiates a new frame. A frame is
	defined as the time between two falling edges of CS.
	There is a minimum of 16 bits per frame. The serial data
	input, DIN, carries data into the control registers clocked
	in by the rising edge of SCLK. The serial data output,
	DOUT, delivers the conversion results and is clocked out
	by the falling edge of SCLK. DOUT is a 16-bit data word
	containing a 4-bit channel address, followed by a 12-bit
	conversion result led by the MSB when CHAN_ID is set
	to 1 in the ADC Mode Control register (Figure 2a). In
	this mode, keep the clock high for at least one full SCLK
	period before the CS falling edge to ensure best performance
	(Figure 2b). When CHAN_ID is set to 0 (external
	clock mode only), the 16-bit data word includes a leading
	zero and the 12-bit conversion result is followed by
	3 trailing zeros (Figure 2c). In the 10-bit ADC, the last 2
	LSBs are set to 0."

We're simulating the behaviour when CHAN_ID = 1.
*/

module SPI_slave(nCS, SCLK, DIN, DOUT);
	input nCS;
	input SCLK;
	input DIN;
	output reg DOUT;
	
	reg [3:0] 	channel_addr = 0;
	reg [11:0] 	sample = 0;
	assign 		word_out = {channel_addr, sample};
	reg [15:0] 	word_in = 0;
	
	/*
	"A high-to-low transition on CS samples
	 the analog inputs and initiates a new frame."
	 
	 We'll increment our 12-bit counter to simulate a new sample being taken.
	*/
	always @(negedge nCS)
		begin
			if (sample < 12'b111111111111)
				begin
					sample <= sample + 1;
				end
			else
				begin
					sample <= 0;
				end
		end
	
	/*
	"The serial data input, DIN, carries data into the control 
	registers clocked in by the rising edge of SCLK."
	*/
	always @(posedge SCLK)
		begin
			// TODO: shift in data from DIN
			
			// TODO: some kind of state machine based on data
			// being written to us?
			// This is more work than we need though I think.
			
		end
		
	/*
	"The serial data output, DOUT, delivers the conversion results 
	and is clocked out by the falling edge of SCLK."
	*/
	always @(negedge SCLK)
		begin
			if (nCS == 0)
				begin
					DOUT <= ~DOUT;
				end
		end
endmodule 
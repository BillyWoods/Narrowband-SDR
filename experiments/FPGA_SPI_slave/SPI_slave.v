/*
From the MAX19777 datasheet:

	"... The 3Msps device is capable of sampling at full
	rate when driven by a 48MHz clock.
	The conversion result appears at DOUT, MSB first, with a
	leading zero followed by the 12-bit result. A 12-bit result is
	followed by two trailing zeros. See Figure 1 and Figure 5...
	
	The device features a 3-wire serial interface that directly
	connects to SPI, QSPI, and MICROWIRE device without
	external logic. Figure 1 and Figure 5 show the interface
	signals for a single conversion frame to achieve maximum
	throughput.
	The falling-edge of CS defines the sampling instant.
	Once CS transitions low, the external clock signal (SCLK)
	controls the conversion.
	The SAR core successively extracts binary-weighted
	bits in every clock cycle. The MSB appears on the data
	bus during the 2nd clock cycle with a delay outlined in
	the timing specifications. All extracted data bits appear
	successively on the data bus with the LSB appearing
	during the 13th clock cycle for 12-bit operation. The serial
	data stream of conversion bits is preceded by a leading
	“zero” and succeeded by trailing “zeros.” The data output
	(DOUT) goes into high-impedance state during the 16th
	clock cycle.
	To sustain the maximum sample rate, the device has to be
	resampled immediately after the 16th clock cycle. For lower
	sample rates, the CS falling edge can be delayed leaving
	DOUT in a high-impedance condition. Pull CS high after the
	10th SCLK falling edge (see the Operating Modes section)."
*/

module SPI_slave(nRST, nCS, SCLK, DOUT);
	input nRST;
	input nCS;
	input SCLK;
	output DOUT;
	
	reg [3:0] 	channel_addr = 0;
	reg [11:0] 	sample = 0;
	reg [11:0]	sample_next;
	wire [15:0]	word_out = {1'b0, sample, 1'b0, 1'b0, 1'bz};
	reg [3:0]	bit_ptr = 0; // an index in word_out
	reg [3:0]	bit_ptr_next;
	reg [3:0]	sample_hold_counter = 0;
	
	parameter increment = 1;
	parameter sample_hold = 3; // number of read cycles to hold a sample for (slows the incrementing of the sample value)
	
	/*
	From the ADC datasheet: "A high-to-low transition on CS samples
	 the analog inputs and initiates a new frame."
	 */
	always @(negedge nCS) begin
		if (sample_hold_counter < sample_hold && nRST) begin
			sample_hold_counter = sample_hold_counter + 1;
		end
		else begin
			sample = sample_next;
			sample_hold_counter = 1;
		end
		
	end
	
	/*
	combinational logic for determining the next value of sample
	*/
	always @(*) begin
		// We'll increment our 12-bit counter to simulate a new sample being taken.
		if ((sample < 12'b111111111111 - increment) && nRST) begin
			sample_next = sample + increment;
		end
		else begin
			sample_next = 0;
		end
	end
		
	/*
	"The serial data output, DOUT, delivers the conversion results 
	and is clocked out by the falling edge of SCLK."
	*/
	always @(negedge SCLK) begin
		bit_ptr <= bit_ptr_next;
	end
	mux_16to1 bit_select(word_out, DOUT, bit_ptr);
	
	/*
	combinational logic for determining the next value of bit_ptr
	*/
	always @(*) begin
		if (nCS == 1 && bit_ptr < 4'b1111 && bit_ptr > 4'b0110) begin
			// special condition for off/'low power mode'
			bit_ptr_next = 4'b0000;
		end
		else if (bit_ptr > 4'b0000 || nCS == 0) begin
			// usually decrement, but only allow 0000 -> 1111 when nCS is low
			bit_ptr_next = bit_ptr - 1;
		end
		else begin
			bit_ptr_next = bit_ptr;
		end
	end
endmodule

// this testbench is meant to simulate Figure 5 from the datasheet for the MAX11131
module tb_SPI_slave;
	reg nCS;
	reg nRST;
	reg SCLK;
	wire DOUT;
	integer i;
	integer j = 0;
	parameter T = 20; // clock period
	
	initial begin
		nCS = 1;
		nRST = 1;
		SCLK = 1;
		
		// leave both high for a bit
		#(T/4);
		nCS = 0; // select chip (and instruct it to sample)
		#(T/4);
		
		forever begin
			nRST = ~(j%10 == 5); // reset once every 10 cycles, on the 6th run.
		
			// Starting i at 1 so numbering of posedges matches Figure 2b
			for (i = 1; i <= 16; i = i + 1) begin
				if (i == 14) begin
					SCLK = 0;
					#(T/4);
					nCS = 1;
					#(T/4);
					SCLK = 1;
					#(T/2);
				end
				else if (i == 16) begin
					SCLK = 0;
					#(T/2);
					SCLK = 1;
					#(T/4);
					nCS = 0; // select chip (and instruct it to sample)
					#(T/4);
				end
				else begin
					SCLK = 0;
					#(T/2);
					SCLK = 1;
					#(T/2);
				end
			end
			
			j = j + 1;
		end
	end
	
	SPI_slave test_module(nRST, nCS, SCLK, DOUT);
endmodule 
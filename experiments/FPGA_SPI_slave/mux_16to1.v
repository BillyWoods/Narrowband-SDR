module mux_16to1(in, out, sel);

	input [15:0] in;
	input [3:0] sel;
	output reg out;
	
	always @(*)
		begin
			case (sel)
				4'b0000: out = in[0];
				4'b0001: out = in[1];
				4'b0010: out = in[2];
				4'b0011: out = in[3];
				4'b0100: out = in[4];
				4'b0101: out = in[5];
				4'b0110: out = in[6];
				4'b0111: out = in[7];
				4'b1000: out = in[8];
				4'b1001: out = in[9];
				4'b1010: out = in[10];
				4'b1011: out = in[11];
				4'b1100: out = in[12];
				4'b1101: out = in[13];
				4'b1110: out = in[14];
				4'b1111: out = in[15];
			endcase
		end

endmodule 

// testbench for mux_16to1
`timescale 1ns / 1ns

module tb_mux_16to1();
	reg [15:0] in;
	wire out;
	reg [3:0] sel;
	integer i;
	
	mux_16to1 m(in, out, sel);
	
	initial
		begin
			in = 16'b0101000001011111;
			sel = 0;
			// scan through all the input bits
			for (i = 0; i < 15; i=i+1)
				begin
					#20 sel = sel + 1;
				end
			// see what happens when sel is kept the same, but input bit changes
			#20 sel = 2;
			#20 in = 16'b0101000001011011;
		end
	
endmodule 
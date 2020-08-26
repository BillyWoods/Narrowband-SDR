/* This is the top-level module.
 *
 * It connects multiple SPI slave modules up to external pins.
 *
 * It also provides a divided clock output for help with debugging;
 * it can be physically jumpered in as the clock signals.
 */
module FPGA_SPI_slave(nRST, nCS, SCLK, DOUT,
							 sys_clk, dbg_nCS, dbg_SCLK);
	input nCS;				// shared by all ADCs
	input nRST;				// shared by all ADCs
	input SCLK;				// shared by all ADCs
	output [7:0] DOUT; 	// one bit for each ADC's DOUT pin
	input sys_clk; 		// the system's 50 MHz clock
	output reg dbg_nCS;	// for letting the FPGA test itself; generated by the FPGA and can be internally or externally looped back
	output reg dbg_SCLK;	// for letting the FPGA test itself; generated by the FPGA and can be internally or externally looped back
	
	// internally connects dbg_nCS and dbg_SCLK up to the SPI modules
	parameter internal_loopback = 0;
	
	// ----------------------------------
	// Wire up some of these SPI modules
	// ----------------------------------
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin : simulated_ADCs
			if (internal_loopback == 1) begin
				SPI_slave simulated_ADC(.nRST(nRST), .nCS(dbg_nCS), .SCLK(dbg_SCLK), .DOUT(DOUT[i]));
				defparam simulated_ADC.increment = i + 1;
			end
			else begin
				SPI_slave simulated_ADC(.nRST(nRST), .nCS(nCS), .SCLK(SCLK), .DOUT(DOUT[i]));
				defparam simulated_ADC.increment = i + 1;
			end
		end
	endgenerate
	
	
	// --------------------------------
	// For generating the debug clock
	// --------------------------------
	parameter divisor = 25;	// actual division ratio is 2 * divisor
	reg [4:0] cnt;  			// 4-bit counter for clock division
	initial begin
		cnt = 4'b1111;
		dbg_SCLK = 1;
	end
	always @(posedge sys_clk) begin
		cnt = cnt + 1;

		if (cnt == divisor) begin
			cnt = 0;
			dbg_SCLK <= ~dbg_SCLK;
		end
	end
	
	// ---------------------------------
	// For generating the debug nCS
	// ---------------------------------
	reg [3:0] clk_num;
	initial begin
		clk_num <= 4'b1111;
		dbg_nCS <= 1;
	end
	always @(posedge dbg_SCLK) begin
		clk_num = clk_num + 1;
		if (clk_num == 4'b0000) begin
			dbg_nCS <= 0;
		end
		else if (clk_num == 4'd13) begin
			dbg_nCS <= 1;
		end
	end
	
endmodule 


module tb_FPGA_SPI_slave;
	reg nRST = 1;
	// we'll use the internal loopback to supply nCS, SCLK
	wire nCS = 1'b1;
	wire SCLK = 1'b1;
	wire [7:0] DOUT;
	reg sys_clk;
	wire dbg_nCS;
	wire dbg_SCLK;
	
	FPGA_SPI_slave test_module(nRST, nCS, SCLK, DOUT,
										sys_clk, dbg_nCS, dbg_SCLK);
	defparam test_module.internal_loopback = 1;
	
	initial begin
		sys_clk = 0;
		forever begin
			#1 sys_clk = ~sys_clk;
		end
	end

endmodule

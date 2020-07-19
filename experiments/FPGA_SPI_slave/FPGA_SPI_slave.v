/* This is the top-level module.
 *
 * It connects two SPI slave modules up to external pins.
 *
 * It also provides a divided clock output for help with debugging;
 * it can be physically jumpered in as the clock signals.
 */
module FPGA_SPI_slave(nCS1, SCLK1, DIN1, DOUT1,
							 nCS2, SCLK2, DIN2, DOUT2,
							 dbg_sclk, sys_clk);
	input nCS1, nCS2;
	input SCLK1, SCLK2;
	input DIN1, DIN2;
	output DOUT1, DOUT2;
	output dbg_sclk; // 
	input sys_clk; // the system's 50 MHz clock
	
	// ----------------------------------
	// Wire up some of these SPI modules
	// ----------------------------------
	SPI_slave simulated_ADC1(.nCS(nCS1), .SCLK(dbg_sclk), .DIN(DIN1), .DOUT(DOUT1));
	//SPI_slave simulated_ADC1(.nCS(nCS1), .SCLK(SCLK1), .DIN(DIN1), .DOUT(DOUT1));
	
	SPI_slave simulated_ADC2(.nCS(nCS2), .SCLK(SCLK2), .DIN(DIN2), .DOUT(DOUT2));
	
	
	// --------------------------------
	// For generating the debug clock
	// --------------------------------
	reg SPI_dbg_base_clk; // a divided clock derived from sys_clk
	parameter divisor = 5;
	reg [0:3] cnt; // 4-bit counter for clock division
	
	initial
		begin
			cnt <= 0;
		end
	
	always @(posedge sys_clk)
		begin
			if (cnt < divisor)
				begin
					cnt <= cnt + 1;
				end
			if (cnt >= divisor - 1)
				begin
					cnt <= 0;
					SPI_dbg_base_clk <= ~SPI_dbg_base_clk;
				end
		end
	
	assign dbg_sclk = SPI_dbg_base_clk;
	
endmodule 
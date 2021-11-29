`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:03:30 10/19/2021
// Design Name:   counter
// Module Name:   D:/test/room/counter_tb.v
// Project Name:  room
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_tb;

	// Inputs
	reg en;
	reg up;
	reg clr;
	reg clk;

	// Outputs
	wire [3:0] number;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.en(en), 
		.up(up), 
		.clr(clr), 
		.clk(clk), 
		.number(number)
	);
	//always @* clk = #5 ~clk;
	initial begin
	clk = 0;
	forever #5 clk = ~clk;
	end
	initial begin
		// Initialize Inputs
		en = 1;
		up = 1;
		clr = 0;
		
		#10
		clr = 1;

		// Wait 100 ns for global reset to finish
		#50
		up = 0;
      //forever #5 clk = ~clk;
		// Add stimulus here

	end
      
endmodule


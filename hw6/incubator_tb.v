`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:13:31 12/07/2021
// Design Name:   incubator
// Module Name:   D:/test/hw6/incubator/incubator_tb.v
// Project Name:  incubator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: incubator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module incubator_tb;

	// Inputs
	reg [7:0] temperature;
	reg clk;
	reg rst;

	// Outputs
	wire cooler;
	wire [3:0] fan;
	wire heater;

	// Instantiate the Unit Under Test (UUT)
	incubator uut (
		.temperature(temperature), 
		.clk(clk), 
		.rst(rst), 
		.cooler(cooler), 
		.fan(fan), 
		.heater(heater)
	);
	
	initial
	begin
		clk = 0;
		forever clk = #5 ~clk;
	end

	initial begin
		// Initialize Inputs
		temperature = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#20;
		
		rst = 1;
		
		#100
		temperature = 10;
		#100
		temperature = 50;
		#100
		temperature = 30;
		#100
		temperature = 20;
		#100
		temperature = -5;
		
		
        
		// Add stimulus here

	end
      
endmodule


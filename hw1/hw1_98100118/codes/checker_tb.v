`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:18:41 10/18/2021
// Design Name:   checker
// Module Name:   D:/checker/checker_tb.v
// Project Name:  checker
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: checker
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module checker_tb;
  reg [15:0] in;
  wire out;
  checker ins  (in, out);
  initial
  begin
    in = 16'b0000000000100010;
    # 5
    in = 16'b0000000000010000;
    # 5
    in = 16'b0000000000110011;
    # 5
    in = 16'b0000000000001001;
    # 5
    in = 16'b0000000001100110;
  end
endmodule


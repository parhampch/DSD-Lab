
module Booth_tb;

	// Inputs
	reg [4:0] a;
	reg [4:0] b;
   reg clk;
   reg rst;
	initial 
   begin
        clk = 1;
        forever #5 clk = ~clk;   
   end    

	// Outputs
	wire [9:0] out;
	wire done;

	// Instantiate the Unit Under Test (UUT)
	Booth ins (
		.a(a), 
		.b(b),
		.clk(clk),
		.rst(rst),
		.c(out),
		.done(done)
	);
	
	initial begin
		
		// Initialize Inputs
		rst = 1;
		a = 5'b00010;
		b = 5'b11110;
		rst = 0;
		#10
		rst = 1;
		

		// Wait 100 ns for global reset to finish
		#100;
		
		a = 5'b00110;
		b = 5'b01000;
		rst = 0;
		#10
		rst = 1;
		#100;
		
		a = 5'b00100;
		b = 5'b00001;
		rst = 0;
		#10
		rst = 1;
		#100;
		
		a = 5'b00101;
		b = 5'b01001;
		rst = 0;
		#10
		rst = 1;
        
		// Add stimulus here

	end
      
endmodule

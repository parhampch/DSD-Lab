
module UART_tb;

	// Inputs
	reg clk;
	reg [6:0] data;
	reg reset;
	reg send;

	// Outputs
	wire done_send;
	wire done_recieve;
	wire my_bit;
	wire [6:0] received_data;
	wire correct;

	// Instantiate the Unit Under Test (UUT)
	UART uut (
		.clk(clk), 
		.data(data), 
		.reset(reset), 
		.send(send), 
		.done(done_send), 
		.my_bit(my_bit)
	);
	
	receiver uut_r (
		.clk(clk), 
		.out(received_data),
		.correct(correct), 
		.done(done_recieve), 
		.my_bit(my_bit),
		.reset(reset)
	);
	
	initial
	begin
		clk = 0;
		forever clk = #5 ~clk;
	end
	

	initial begin
		// Initialize Inputs
		data = 0;
		reset = 0;
		send = 0;

		// Wait 100 ns for global reset to finish
		#20;
		reset = 1;
		send = 1;
		data = 7'b0001111;
		#120
		reset = 0;
		send = 0;
		#20
		reset = 1;
		send = 1;
		data = 7'b1110000;
		
		
       
		// Add stimulus here

	end
      
endmodule


module Booth(
    input [4:0] a,
    input [4:0] b,
    input clk,
    input rst,
    output [9:0] c,
	 output done);

    wire [2:0] current_state, report;

    datapath dp (a, b, rst, clk, current_state, c, report, done);
    control_unit cu (report, rst, clk, current_state);


    
endmodule

module datapath (
    input [4:0] a,
    input [4:0] b,
    input rst,
    input clk,
    input [2:0] current_state,
    output [9:0] c,
    output [2:0] report,
	 output reg done);

    parameter START = 3'b000;
    parameter CHOOSE = 3'b001;
    parameter ADD = 3'b010;
    parameter SUB = 3'b011;
    parameter SHIFT = 3'b100;

    reg [3:0] counter;
    reg signed [10:0] ACC;
    reg Q;
    wire [3:0] count_shift;
	 
    assign report = {done, ACC[1:0]};
	 assign c = done ? ACC[10:1] : c;
	 
	 always @*
		done <= counter >= 5;

    shift_count_finder SHCF (ACC, count_shift);

    always @(posedge clk or negedge rst) 
    begin
        if (!rst)
		  begin
                counter <= 0;
					 ACC <= {5'b00000, a, 1'b0};
                Q <= 0;
					 done <= 0;
		  end
        else
        begin
            case (current_state)
            START:
            begin
                counter <= 0;
					 ACC <= {5'b00000, a, 1'b0};
                Q <= 0;
					 done <= 0;
            end
            CHOOSE:
            begin
            end
            ADD:
            begin
                ACC[10:6] <= ACC[10:6] + b;
            end
            SUB:
            begin
                ACC[10:6] <= ACC[10:6] - b;
            end
            SHIFT:
            begin
                ACC <= (ACC >>> (5 - counter >= count_shift ? count_shift : 5 - counter));
                counter <= counter + count_shift;
					 
            end
            endcase
        end
    end
endmodule

module control_unit (
    input [2:0] report,
    input rst,
    input clk,
    output reg [2:0] current_state);

    parameter START = 3'b000;
    parameter CHOOSE = 3'b001;
    parameter ADD = 3'b010;
    parameter SUB = 3'b011;
    parameter SHIFT = 3'b100;
	 
	 reg [2:0] next_state;

    always @(posedge clk or negedge rst) 
    begin
        if (!rst)
            current_state <= START;
        else
            current_state <= next_state;
    end
	 
	 always @*
        begin
            case (current_state)
            START:
            begin
                next_state <= CHOOSE;
            end
            CHOOSE:
            begin
                if (report[1] == report[0])
                    next_state <= SHIFT;
                else if (report[0] == 1)
                    next_state <= ADD;
                else
                    next_state <= SUB;
            end
            ADD:
            begin
                next_state <= SHIFT;
            end
            SUB:
            begin
                next_state <= SHIFT;
            end
            SHIFT:
            begin
                if (report[2])
                    next_state <= START;
                else
                    next_state <= CHOOSE;
            end
        endcase
        end
        
endmodule

module shift_count_finder(
    input [10:0] ACC,
    output reg [3:0] out);
	always @*
	begin
    out = 1;
    if (ACC[1] == ACC[2])
        out = 2;
    if (ACC[2] == ACC[3] && out > 1)
        out = 3;
    if (ACC[3] == ACC[4] && out > 2)
        out = 4;
    if (ACC[4] == ACC[5] && out > 3)
        out = 5;
	end
endmodule


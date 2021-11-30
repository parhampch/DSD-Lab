module Booth(
    input [4:0] a,
    input [4:0] b,
    input clk,
    input rst,
    output [9:0] c,
    output done);


    
endmodule

module datapath (
    input [3:0] a,
    input [3:0] b,
    input rstN,
    input clk,
    input [2:0] A_shft_amt,
    input [2:0] B_shft_amt,
    input op,
    input done,
    output reg [7:0] ACC,
    output reg [3:0] B);


endmodule

module control_unit (
    input [2:0] reprot,
    input rst,
    input clk,
    output reg [2:0] operand);

    parameter START = 3'b000;
    parameter CHOOSE = 3'b001;
    parameter ADD = 3'b010;
    parameter SUB = 3'b011;
    parameter SHIFT = 3'b100;

    always @(posedge clk or negedge rst) 
    begin
        if (!rst)
            current_state <= START;
        else
        begin
            current_state <= next_state;
            case (state)
            START:
            begin
                next_state <= CHOOSE;
            end
            CHOOSE:
            begin
                if (report[1] ~^ report[0])
                    next_state <= SHIFT;
                else if (report[0])
                    next_state <= SUB;
                else
                    next_state <= ADD;
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
                if (done)
                    next_state <= START;
                else
                    next_state <= CHOOSE;
            end
        endcase
        end
        
    end



endmodule
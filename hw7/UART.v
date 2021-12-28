module UART (
    input clk,
    input [6:0] data,
    input reset,
    input send,
    output reg done,
    output bit);

    localparam IDLE = 4'b000;
    localparam START = 4'b001;
    localparam PARITY = 4'b010;
    localparam BUSY = 4'b011;
    localparam STOP = 4'b100;

    reg [2:0] current_state;
    reg [2:0] next_state;
    reg [2:0] index;

    always @(posedge clk or negedge reset) 
    begin
        if (!reset)
        begin
            current_state <= IDLE;
            bit <= 0;
            done <= 0;
            index = 0;
        end
        else 
            current_state <= next_state;
    end

    always @* 
    begin
        done = 0;
        case (current_state)
        IDLE:
        begin
            bit = 0;
            index = 0;
            if (send)
                next_state = START;
            else
                next_state = IDLE;
        end
        START:
        begin
            bit = 1;
            next_state = PARITY;            
        end
        PARTITY:
        begin
            bit = ^data;
            next_state = BUSY;
        end
        BUSY:
        begin
            bit = data[index];
            index = index + 1;
            if (index == 7):
                next_state = STOP;
            else
                next_state = BUSY;
        end
        STOP:
        begin
            bit = 0;
            done = 1;
            next_state = IDLE;
        end
            
        endcase    
    end

    
endmodule
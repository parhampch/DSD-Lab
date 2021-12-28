module UART (
    input clk,
    input [6:0] data,
    input reset,
    input send,
    output reg done,
    output reg bit);

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

module receiver (
    input clk;
    input bit,
    output reg [6:0] out,
    output reg correct,
    output reg done);

    localparam START = 4'b00;
    localparam PARITY = 4'b01;
    localparam BUSY = 4'b10;
    localparam STOP = 4'b11;

    reg [1:0] current_state = START;
    reg [1:0] next_state;
    reg [2:0] index;
    reg [6:0] data;
    reg parity;

    always @(posedge clk) 
    begin
        current_state <= next_state;
    end

    always @* 
    begin
        done = 0;
        correct = 0;
        case (current_state)
            START:
            begin
                index = 0;
                if (bit)
                    next_state = PARITY;    
                else
                    next_state = START; 
            end
            PARITY:
            begin
                next_state = BUSY;
                parity = bit;
            end
            BUSY:
            begin
                data[index] = bit;
                index = index + 1;
                if (index == 7)
                    next_state = STOP;
                else
                    next_state = BUSY;
            end
            STOP:
            begin
                done = 1;
                correct = parity == (^data);
                out = data;
                next_state = START;
            end
        endcase    
    end

    
endmodule
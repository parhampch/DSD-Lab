module UART (
    input clk,
    input [6:0] data,
    input reset,
    input send,
    output reg done,
    output reg my_bit);

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
            my_bit <= 0;
            done <= 0;
            index = 0;
        end
		  else
		  begin
        done = 0;
        case (current_state)
        IDLE:
        begin
            my_bit = 0;
            index = 0;
            if (send)
                current_state = START;
            else
                current_state = IDLE;
        end
        START:
        begin
            my_bit = 1;
            current_state = PARITY;            
        end
        PARITY:
        begin
            my_bit = ^data;
            current_state = BUSY;
        end
        BUSY:
        begin
            my_bit = data[index];
            index = index + 1;
            if (index == 7)
                current_state = STOP;
            else
                current_state = BUSY;
        end
        STOP:
        begin
            my_bit = 0;
            done = 1;
            current_state = IDLE;
        end
            
        endcase    
    end
		  
    end
    
endmodule

module receiver (
    input clk,
    input my_bit,
	 input reset,
    output reg [6:0] out,
    output reg correct,
    output reg done);

    localparam START = 4'b00;
    localparam PARITY = 4'b01;
    localparam BUSY = 4'b10;
    localparam STOP = 4'b11;

    reg [1:0] current_state = START;
    reg [2:0] index;
    reg [6:0] data;
    reg parity;

    always @(posedge clk or negedge reset)
	 if (!reset)
	 begin
		current_state = START;
		index = 0;
		done = 0;
		correct = 0;
	 end
	 else
    begin
        done = 0;
        correct = 0;
        case (current_state)
            START:
            begin
                index = 0;
                if (my_bit)
                    current_state = PARITY;    
                else
                    current_state = START; 
            end
            PARITY:
            begin
                current_state = BUSY;
                parity = my_bit;
            end
            BUSY:
            begin
                data[index] = my_bit;
                index = index + 1;
                if (index == 7)
                    current_state = STOP;
                else
                    current_state = BUSY;
            end
            STOP:
            begin
                done = 1;
                correct = parity == (^data);
                out = data;
                current_state = START;
            end
        endcase    
    end

    
endmodule

module incubator(
    input signed [7:0] temperature ,
    input clk,
    input rst,
    output cooler,
    output [3:0] fan,
    output heater);
    
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    localparam S1_fan = 2'b00;
    localparam S2_fan = 2'b01;
    localparam S3_fan = 2'b10;
    localparam out_fan = 2'b11;

    reg [1:0] state = S1;
    
    reg [1:0] next_state;

    reg [1:0] fan_state = out_fan;

    reg [1:0] next_fan_state;

    always @(posedge clk or negedge rst) 
    begin
        if (~rst)
        begin
            fan_state <= out_fan;
            state<= S1;
        end
        else 
        begin
           state <= next_state; 
           fan_state <= next_fan_state;
        end
    end

    always @(*)
    begin
        case (state)
        S1:
        begin
            if (temperature > 35)
                next_state = S2;
            else if (temperature < 15)
                next_state = S3;
        end
        S2:
        begin
            if (temperature < 25)
                next_state = S1;
        end
        S3:
        begin
            if (temperature > 30)
                next_state = S1;
        end
        endcase
    end

    always @(*) 
    begin
        if (cooler)
        begin
           case (fan_state)
           S1_fan:
           begin
               if (temperature > 40)
                next_fan_state = S2_fan;
            else if (temperature < 25)
                next_fan_state = out_fan;
           end
           S2_fan:
           begin
               if (temperature > 45)
                next_fan_state = S3_fan;
            else if (temperature < 35)
                next_fan_state = S1_fan;
           end
           S3_fan:
           begin
               if (temperature < 40)
                next_fan_state = S2_fan;
           end
           out_fan:
           begin
               if (temperature > 35)
                next_fan_state = S1_fan;
           end
           endcase 
        end
		  else
			next_fan_state = out_fan;
        
    end

    assign heater = state == S3;
    assign cooler = state == S2;
    assign fan = fan_state == out_fan ? 0 : fan_state == S1_fan ? 4 : fan_state == S2_fan ? 6 : 8;
    
endmodule
module incubator(
    input signed [7:0] temperature ;
    input clk;
    input rst;
    output reg cooler;
    output reg [3:0] fan;
    output reg heater);
    
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = s'b11;

    localparam S1_fan = 2'b00;
    localparam S2_fan = 2'b01;
    localparam S3_fan = s'b10;
    localparam out_fan = s'b11;

    reg [1:0] state = S1;
    
    reg [1:0] next_state;

    reg [1:0] fan_state = out_fan;

    reg [1:0] next_fan_state;

    always @(posedge cl or negedge rst) 
    begin
        if (~rst)
        begin
            fan_state <= out_fan
            state <= S1;
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
        S2:
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
           S2_fan
           begin
               if (temperature > 45)
                next_fan_state = S3_fan;
            else if (temperature < 35)
                next_fan_state = S1_fan;
           end
           S3_fan
           begin
               if (temperature < 40)
                next_fan_state = S2_fan;
           end
           out_fan
           begin
               if (temperature > 35)
                next_fan_state = S1_fan;
           end
           endcase 
        end
        
    end

    assign heater = state == S3;
    assign cooler = state == S2;
    assign fan = out_fan ? 0 : S1_fan ? 4 : S2_fan ? 6 : 8;
    
endmodule
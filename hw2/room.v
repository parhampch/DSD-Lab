module room (
    input in,
    input out,
    input ent,
    input T,
    input clk,
    input clr,
    output reg open,
    output reg close,
    output [3:0] number);

    reg en, up;

    counter people (en , up, clr, clk, number);

    always @(posedge clk) 
    begin
        if (T && in && ent && number < 15 ) 
        begin
            if (out)
            begin
                en <= 0;
                open <= 0;
            end
            else
            begin
                en <= 1;
                up <= 1;
                open <= 1;
            end
            close <= 0;
        end
        else if (out) 
        begin
            en <= 1;
            up <= 0;
            if (number == 0)
                close <= 1;
            else
                close <= 0;
            open <= 0;
        end    
        else
        begin
           en <= 0;
           close <= 0; 
           open <= 0;
        end
    end

    
endmodule
module counter (
    input en,
    input up,
    input clr,
    input clk,
    output reg [3:0] number);

    always @(posedge clk or negedge clr) 
    begin

        if (!clr) 
            number <= 0;
        else
        begin
            if (!en)
                number <= number;
            else
            begin
                if (up)
                    number <= number + 1;
                else
                    number <= number - 1;
            end
        end 
    end
endmodule
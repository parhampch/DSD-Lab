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
    always @*
    begin
        up = T & in & ent & (number < 15 );
        en = up ^ out;
    end

    always @(posedge clk)
    begin
        open <= up;
        close <= (number == 0) & (~(up & en));
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
                    if (number == 0)
                        number <= number;
                    else
                        number <= number - 1;
            end
        end 
    end
endmodule
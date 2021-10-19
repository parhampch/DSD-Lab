module room (
    input in,
    input out,
    input ent,
    input T,
    output open,
    output close);
    
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
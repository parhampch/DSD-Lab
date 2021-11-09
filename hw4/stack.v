module stack (
    input clk,
    input RstN,
    input [4:0] Data_In,
    input Push,
    input Pop,
    output [4:0] Data_Out,
    output Full,
    output Empty);

    reg [4:0] memory [9:0];
    reg [4:0] pointer;

    always @(posedge clk or negedge RstN) 
    begin
        if (!RstN)
        begin
            pointer <= 0;
            Empty <= 0;
            Full <= 0;
        end
        else 
        begin
            if(push & ~Full)
            begin
                Empty <= 1;
                Full <= ~(pointer < 9);
                memory[pointer] <= Data_in;
                pointer <= pointer + 1;
            end
            else if (Pop & Empty) 
            begin
                Full <= 0;
                Empty <= (pointer > 1)
                Data_out <= memory[pointer - 1];
                pointer = pointer - 1;
            end
            
        end
    end
    
endmodule
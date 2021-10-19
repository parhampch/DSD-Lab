module room_tb;
    reg in;
    reg ent;
    reg out;
    reg T;
    reg clk;
    reg clr;
    wire open;
    wire close;
    wire number;

    room ins (in, out, ent, T, clk, clr, open, close, number);

    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;   
    end    

    initial 
    begin
        in = 1;
        ent = 1;
        out = 0;
        T = 1;
        clr = 0;
        clr = 1;
        #20
        in = 0;
        #20
        out = 1;
        #5
        in = 1;
        ent = 1;
        #30
        T = 0;
        #10
        out = 0;        
    end

    
endmodule
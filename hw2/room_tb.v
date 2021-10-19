module room_tb;
    reg in;
    reg ent;
    reg out;
    reg T;
    reg clk;
    wire open;
    wire close;

    room ins (in, out, ent, T, clk, open, close);

    in = 1;
    ent = 1;
    out = 0;
    T = 1;


    forever clk = #5 ~clk;

    initial 
    begin
        #10
        ent = 0;
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
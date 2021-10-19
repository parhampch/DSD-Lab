module room_tb;
    reg in;
    reg ent;
    reg out;
    reg T;
    reg clk;
    wire open;
    wire close;

    room ins (in, out, ent, T, clk, open, close);

    

    initial 
    begin
        in = 1;
        ent = 1;
        out = 0;
        T = 1;
        clk = 0;
		  forever #10 clk = ~clk;
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
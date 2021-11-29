module room_tb;
    reg in;
    reg ent;
    reg out;
    reg T;
    reg clk;
    reg clr;
    wire open;
    wire close;
    wire [3:0] number;

    room ins (in, out, ent, T, clk, clr, open, close, number);

    initial 
    begin
        clk = 1;
        forever #5 clk = ~clk;   
    end    

    initial 
    begin
        clr = 0;
        in = 1;
        ent = 1;
        out = 0;
        T = 1;
		  #10
		  clr = 1;
        #50
        in = 0;
        #50
        out = 1;
        #100
        in = 1;
        ent = 1;
		  out = 0;
        #50
		  out = 1;
		  #50
        T = 0;
        #50
        out = 0;        
    end

    
endmodule
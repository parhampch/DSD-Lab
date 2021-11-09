module serial_comparator_tb ;
    reg a;
    reg b;
    reg clk;
    reg resrt;
    wire g;
    wire e;
    wire l;

    serial comparator ins (
        .a(a),
        .b(b),
        .clk(clk),
        .reset(reset),
        .g(g),
        .e(e),
        .l(l)
    );

    initial 
    begin
        clk = 1;
        forever #5 clk = ~clk;   
    end    

    initial begin
        reset = 1;
        # 10
        reset = 0;
        a = 1;
        b = 1;
        # 10
        a = 1;
        b = 0;
        # 10
        a = 1;
        b = 1;
        # 10
        a = 0;
        b = 1;
    end

    
endmodule
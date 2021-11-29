module comparator_tb ;
    reg [3:0] a;
    reg [3:0] b;
    reg g_in;
    reg e_in;
    reg l_in;
    wire g_out;
    wire e_out;
    wire l_out;

    comparator ins (
        .a(a),
        .b(b),
        .g_in(g_in),
        .e_in(e_in),
        .l_in(l_in),
        .g_out(g_out),
        .e_out(e_out),
        .l_out(l_out)
    );

    initial begin
        g_in = 0;
        e_in = 1;
        l_in = 0;
        a = 4'b1000;
        b = 4'b0001;
        # 5
        a = 4'b0000;
        b = 4'b0001;
        # 5
        a = 4'b0001;
        b = 4'b0001;
        # 5
        a = 4'b0101;
        b = 4'b0101;
        # 5
        a = 4'b0000;
        b = 4'b0001;
    end

endmodule

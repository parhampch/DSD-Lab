module one_bit_comparator_tb ;
    reg a;
    reg b;
    reg g_in;
    reg e_in;
    reg l_in;
    wire g_out;
    wire e_out;
    wire l_out;

    one_bit_comparator ins (
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
        a = 0;
        b = 1;
        # 5
        a = 1;
        b = 1;
        # 5
        a = 1;
        b = 0;
        # 5
        g_in = 1;
		  e_in = 0;
        a = 0;
        b = 1;
    end

endmodule
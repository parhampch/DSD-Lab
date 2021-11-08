module comparator_tb ;
    reg a[3:0];
    reg b[3:0];
    reg g_in;
    reg e_in;
    reg l_in;
    reg g_out;
    reg e_out,;
    reg l_out;

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
        e_in = 0;
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
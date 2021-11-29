module comparator #(parameter number_of_bits=4) (
    input [number_of_bits - 1:0] a,
    input [number_of_bits - 1:0] b,
    input g_in,
    input e_in,
    input l_in,
    output g_out,
    output e_out,
    output l_out);

    wire [number_of_bits :0] temp_g;
    wire [number_of_bits :0] temp_e;
    wire [number_of_bits :0] temp_l;

    assign temp_g[number_of_bits] = g_in;
    assign temp_e[number_of_bits] = e_in;
    assign temp_l[number_of_bits] = l_in;

    assign g_out = temp_g[0];
    assign e_out = temp_e[0];
    assign l_out = temp_l[0];

    genvar i ;

    generate
        for (i = number_of_bits - 1; i > -1; i = i - 1) 
        begin
            one_bit_comparator copm (a[i], b[i], temp_g[i + 1], temp_e[i + 1], temp_l[i + 1], temp_g[i], temp_e[i], temp_l[i]);
        end    
    endgenerate
endmodule

module one_bit_comparator (
    input a,
    input b,
    input g_in,
    input e_in,
    input l_in,
    output g_out,
    output e_out,
    output l_out);

    assign g_out = g_in | (e_in & a & ~b);
    assign e_out = e_in & (a ~^ b);
    assign l_out = l_in | (e_in & ~a & b);
endmodule
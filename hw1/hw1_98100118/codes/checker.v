module checker(
    input [15:0] a,
    output c);

    wire bool1;
    bcd_3_checker three_ch(a, bool1);
    
    wire bool2;
    bcd_11_checker elevem_ch (a, bool2);

    and last_and(c, bool1, bool2);

endmodule

module bcd_11_checker (
    input [15:0] a, 
    output c);

    wire [3:0] s1;
    wire c_out1;
    four_bit_adder fba1 (a[11:8], a[3:0], c_out1, s1);

    wire [3:0] s2;
    wire c_out2;
    four_bit_adder fba2 (a[15:12], a[7:4], c_out2, s2);

    wire tempComp1;
    five_bit_comprator fcc1 ({c_out1, s1}, {c_out2, s2}, tempComp1);

    wire [3:0] s3;
    wire c_out3;
    four_bit_adder fba3 (s1, 4'b1011, c_out3, s3);

    wire tempComp2;
    five_bit_comprator fcc2 ({c_out3, s3}, {c_out2, s2}, tempComp2);

    wire [3:0] s4;
    wire c_out4;
    four_bit_adder fba4 (s2, 4'b1011, c_out4, s4);

    wire tempComp3;
    five_bit_comprator fcc3 ({c_out1, s1}, {c_out4, s4}, tempComp3);
    
    or res_or (c, tempComp1, tempComp2, tempComp3);
endmodule

module bcd_3_checker (
    input [15:0] a,
    output c);

    wire [3:0] temp1;
    one_bcd_3_checker check1 (a[15:12], temp1);
    
    wire [3:0] temp2;
    one_bcd_3_checker check2 (a[11:8], temp2);
    
    wire [3:0] temp3;
    one_bcd_3_checker check3 (a[7:4], temp3);
    
    wire [3:0] temp4;
    one_bcd_3_checker check4 (a[3:0], temp4);

    wire [3:0] addTemp1;
    wire c1;
    four_bit_adder adder1 (temp1, temp2, c1, addTemp1);

    wire [3:0] addTemp2;
    wire c2;
    four_bit_adder adder2 (addTemp1, temp3, c2, addTemp2);

    wire [3:0] addTemp3;
    wire c3;
    four_bit_adder adder3 (addTemp2, temp4, c3, addTemp3);

    wire [3:0] fin;
    one_bcd_3_checker fin_check (addTemp3, fin);

    wire tempOr;
    or fin_or (tempOr, fin[1], fin[0]);
    not fin_not (c, tempOr);
endmodule

module one_bcd_3_checker (
    input [3:0] in,
    output [3:0] out);

    assign out[2] = 0;
    assign out[3] = 0;

    wire y0_bar;
    not not01 (y0_bar, in[0]);

    wire y1_bar;
    not not11 (y1_bar, in[1]);

    wire y2_bar;
    not not21 (y2_bar, in[2]);

    wire y3_bar;
    not not31 (y3_bar, in[3]);

    wire temp11;
    and and11 (temp11, y1_bar, y0_bar, in[3]);

    wire temp21;
    and and21 (temp21, y1_bar, in[0], in[2]);

    wire temp31;
    and and31 (temp31, in[1], y0_bar, y2_bar);

    or or11 (out[1], temp31, temp21, temp11);

    wire temp51;
    and and41 (temp51, in[2], y1_bar, y0_bar);

    wire temp61;
    and and51 (temp61, in[2], in[1], in[0]);

    wire temp71;
    and and61 (temp71, y3_bar, y2_bar, y1_bar, in[0]);
    
    or or21 (out[0], temp51, temp61, temp71);
endmodule

module four_bit_adder(
	input [3:0] a,
	input [3:0] b,
	output c_out,
	output [3:0] s);

    wire [3:0] tempC;
	xor xor1 (s[0], a[0], b[0]);
    and and0 (tempC[0], a[0], b[0]);

    wire temp1;
    xor xor2 (temp1, a[1], b[1]);
    xor xor3 (s[1], temp1, tempC[0]);
    wire andTemp1;
    and and1 (andTemp1, a[1], b[1]);
    wire andTemp2;
    and and2 (andTemp2, temp1, tempC[0]);
    or or1 (tempC[1], andTemp1, andTemp2);

    wire temp2;
    xor xor4 (temp2, a[2], b[2]);
    xor xor5 (s[2], temp2, tempC[1]);
    wire andTemp3;
    and and3 (andTemp3, a[2], b[2]);
    wire andTemp4;
    and and4 (andTemp4, temp2, tempC[1]);
    or or2 (tempC[2], andTemp3, andTemp4);
    
    wire temp3;
    xor xor6 (temp3, a[3], b[3]);
    xor xor7 (s[3], temp3, tempC[2]);
    wire andTemp5;
    and and5 (andTemp5, a[3], b[3]);
    wire andTemp6;
    and and6 (andTemp6, temp3, tempC[2]);
    or or3 (tempC[3], andTemp5, andTemp6);

    assign c_out = tempC[3];
endmodule

module five_bit_comprator (
  input [4:0] a,
	input [4:0] b,
	output r);

  wire yXNOR1;
  xnor xnor1 (yXNOR1, a[0], b[0]);
  
  wire yXNOR2;
  xnor xnor2 (yXNOR2, a[1], b[1]);
  
  wire yXNOR3;
  xnor xnor3 (yXNOR3, a[2], b[2]);
  
  wire yXNOR4;
  xnor xnor4 (yXNOR4, a[3], b[3]);
  
  wire yXNOR5;
  xnor xnor5 (yXNOR5, a[4], b[4]);

  and fin_and (r, yXNOR1, yXNOR2, yXNOR3, yXNOR4, yXNOR5);
endmodule

`include "checker.v"
module my_tb3();
  reg [3:0] in;
  wire [3:0] out;
  one_bcd_3_checker ins  (in, out);
  
  initial
  begin
    in = 4'b0010;
    # 5
    in = 16'b0110;
    # 5
    in = 16'b1001;
  end
endmodule

module my_tb2 ();
  reg [3:0] in1;
  reg [3:0] in2;
  wire c_out;
  wire [3:0] out;
  four_bit_adder ins  (in1, in2, c_out, out);
  
  initial
  begin
    in1 = 4'b0010;
    in2 = 4'b0011;
    # 5
    in1 = 4'b0000;
    in2 = 4'b0101;
    # 5
    in1 = 4'b0100;
    in2 = 4'b0011;
  end
endmodule

module my_tb();
  reg [15:0] in;
  wire out;
  bcd_3_checker ins  (in, out);
  initial
  begin
    in = 16'b0000000000010010;
    # 5
    in = 16'b0000000000010000;
    # 5
    in = 16'b0000000000100010;
    # 5
    in = 16'b0000000000100001;
  end
endmodule

module my_tb4();
  reg [15:0] in;
  wire out;
  bcd_11_checker ins  (in, out);
  initial
  begin
    in = 16'b0000000000100010;
    # 5
    in = 16'b0000000000010000;
    # 5
    in = 16'b0000000000110011;
    # 5
    in = 16'b0000000000001001;
  end
endmodule

module my_tb5();
  reg [15:0] in;
  wire out;
  checker ins  (in, out);
  initial
  begin
    in = 16'b0000000000100010;
    # 5
    in = 16'b0000000000010000;
    # 5
    in = 16'b0000000000110011;
    # 5
    in = 16'b0000000000001001;
    # 5
    in = 16'b0000000001100110;
  end
endmodule

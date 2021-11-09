module serial_comparator (
    input a,
    input b,
    input clk,
    input reset,
    output g,
    output e,
    output l);

    DFF register ()
    
endmodule

module DFF (
    input D,
    input clk,
    input reset,
    output Q,
    output Q_bar);

    assign nand1 = D ~& clk;
    assign nand2 = (~D) ~& clk;
    assign Q = nand1 ~& Q_bar & reset;
    assign Q_bar = nand2 ~& Q & reset;

    
endmodule
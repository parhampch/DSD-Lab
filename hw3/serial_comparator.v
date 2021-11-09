module serial_comparator (
    input a,
    input b,
    input clk,
    input reset,
    output g,
    output e,
    output l);


    wire next_g, nand_g1, nand_g2, not_g;
    wire next_e, nand_e1, nand_e2, not_e;
    wire next_l, nand_l1, nand_l2, not_l;

    assign next_g = ~reset & ((a & ~b) | ((a ~^ b) & g));
    assign next_e = ~reset & e & (a ~^ b);
    assign next_l = ~resest & ((~a & b) | ((a ~^ b) & l)));

    assign nand_g1 = next_g ~& clk;
    assign nand_g2 = (~next_g) ~& clk;
    assign g = nand_g1 ~& not_g;
    assign not_g = nand_g2 ~& g;
    
    assign nand_e1 = next_e ~& clk;
    assign nand_e2 = (~next_e) ~& clk;
    assign e = nand_e1 ~& not_e;
    assign not_e = nand_e2 ~& e;

    assign nand_l1 = next_l ~& clk;
    assign nand_l2 = (~next_l) ~& clk;
    assign l = nand_l1 ~& not_l;
    assign not_l = nand_l2 ~& l;
    
endmodule

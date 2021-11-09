module stack_tb ;

    reg clk;
    reg RstN;
    reg [4:0] Data_In;
    reg Push;
    reg Pop;
    wire [4:0] Data_Out;
    wire Full;
    wire Empty;

    stack ins (
        .clk(clk),
        .RstN(RstN),
        .Data_In(Data_In),
        .Push(Push),
        .Pop(Pop),
        .Data_Out(Data_Out),
        .Full(Full),
        .Empty(Empty)
    );

    initial 
    begin
        clk = 1;
        forever #5 clk = ~clk;   
    end    

    initial begin
        reset = 0;
        Pop = 0
        # 10
        Push = 1;
        Data_In = 5'b10101;
        # 10
        Push = 1;
        Data_In = 5'b11111;
        # 10
        Push = 0;
        Pop = 1;
    end
    
endmodule
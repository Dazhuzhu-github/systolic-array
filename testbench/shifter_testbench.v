`timescale 1ns / 1ps

module shifter_testbench();
    reg RESET = 0;
    reg CLK = 0;
    reg [4:0]A ;
    reg [127:0]D;
    reg WEN;
    reg CEN;
    reg RETN;
    wire [127:0] Q;
    integer count;
    reg [127:0] shifter1[4:0];
    
    shift_buffer shifter(
        .CLK(CLK),
        .CEN(CEN),
        .WEN(WEN),
        .A(A),
        .D(D),
        .RETN(RETN),
        .Q(Q),
        .RESET(RESET)
    );
    initial begin
        #50
        $readmemb("E:/code/digital_design/lab2/shifter.txt", shifter1);
        WEN = 0;
        RETN = 1;
        CEN = 1;
        RESET = 1;
        #100 RESET = 0;
        for (count = 0; count<2'd3 ; count = count+1'd1) begin
            #(100) D <= shifter1[0];A<=count;
        end
    end
    always #50 CLK = ~CLK;
endmodule
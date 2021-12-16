`timescale 1ns / 1ps

module test_pe_array();
    parameter num1 = 2;
    parameter num2 = 2;
    reg RESET;
    reg CLK;

    reg EN;                          // enable signal for the accelerator; high for active
    reg SELECTOR;                    // weight select read or use
    reg W_EN;                         // enable weight to flow
    reg [num1*8-1:0]active_left;
    reg [num2*16-1:0]in_sum;
    reg [num2*8-1:0]in_weight_above;
    wire [num2*16-1:0]out_sum;
    //wire [7:0]active_right;
    wire [num2*8-1:0]out_weight_below;
    PE_array #(.num1(num1),.num2(num2))PE_array(
        .CLK(CLK),
        .RESET(RESET),
        .EN(EN),
        .SELECTOR(SELECTOR),
        .W_EN(W_EN),
        // .....
        .active_left(active_left),
        //.in_sum(in_sum),
        .out_sum_final(out_sum),
        .in_weight_above(in_weight_above),
        .out_weight_final(out_weight_below)
    );
    initial begin
        RESET = 1;
        CLK = 1;
        EN = 1;
        SELECTOR = 1;
        W_EN = 1;
        in_sum = 0;
        #100 RESET = 0;
        //权重初始化
        #50 
        in_weight_above[7:0]<=3;
        in_weight_above[15:8]<=4;
        // in_weight_above[23:16]<=5;
        // in_weight_above[31:24]<=6;
        #100
        in_weight_above[7:0]<=1;
        in_weight_above[15:8]<=2;
        #100
        SELECTOR=0;
        in_weight_above[7:0]<=5;
        in_weight_above[15:8]<=6;
        // in_sum[15:0]<=1;
        // in_sum[31:16]<=2;
        // in_sum[47:32]<=3;
        // in_sum[63:48]<=4;
        active_left[7:0]<=1;
        #100
        active_left[7:0]<=2;
        active_left[15:8]<=3;
        in_weight_above[7:0]<=7;
        in_weight_above[15:8]<=8;
        #100
        W_EN = 0;
        active_left[7:0]<=0;
        active_left[15:8]<=4;
        #100
        active_left[15:8]<=0;
        // active_left[23:16]<=5;
        // active_left[31:24]<=6;
        // #100
        // active_left[7:0]<=4;
        // active_left[15:8]<=5;
        // active_left[23:16]<=6;
        // active_left[31:24]<=7;
        // #100
        // active_left[7:0]<=5;
        // active_left[15:8]<=6;
        // active_left[23:16]<=7;
        // active_left[31:24]<=8;
        // #100
        // active_left[7:0]<=6;
        // active_left[15:8]<=7;
        // active_left[23:16]<=8;
        // active_left[31:24]<=9;
    end

    always #50 CLK = ~CLK;
endmodule
`timescale 1ns / 1ps

module test_pe_row();
    parameter num = 16;
    reg RESET;
    reg CLK;

    reg EN;                          // enable signal for the accelerator; high for active
    reg SELECTOR;                    // weight select read or use
    reg W_EN;                         // enable weight to flow
    reg [7:0]active_left;
    reg [num*8-1:0]in_sum;
    reg [num*8-1:0]in_weight_above;
    wire [num*16-1:0]out_sum;
    //wire [7:0]active_right;
    wire [127:0]out_weight_below;
    PE_row #(.num(num))PE_row(
        .CLK(CLK),
        .RESET(RESET),
        .EN(EN),
        .SELECTOR(SELECTOR),
        .W_EN(W_EN),
        // .....
        .active_left(active_left),
        //.active_right(active_right),
        .in_sum(in_sum),
        .out_sum(out_sum),
        .in_weight_above(in_weight_above),
        .out_weight_below(out_weight_below)
    );
    initial begin
        RESET = 1;
        CLK = 1;
        EN = 1;
        SELECTOR = 1;
        W_EN = 1;
        in_sum = 0;
        #100 RESET = 0;
        #50 
        in_weight_above[7:0]=3;
        in_weight_above[15:8]=4;
        in_weight_above[23:16]=5;
        in_weight_above[31:24]=6;
        #100
        SELECTOR = 0;
        in_weight_above[7:0]=3;
        in_weight_above[15:8]=4;
        in_weight_above[23:16]=5;
        in_weight_above[31:24]=6;
        #100
        in_sum[15:0]<=1;
        in_sum[31:16]<=2;
        in_sum[47:32]<=3;
        in_sum[63:48]<=4;
        active_left<=3;
        #100
        active_left<=4;
        #100
        active_left<=5;
        #100
        active_left<=6;
    end

    always #50 CLK = ~CLK;
endmodule
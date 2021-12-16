`timescale 1ns / 1ps

module test_pe();

    reg reset;
    reg clk;

    reg EN;                          // enable signal for the accelerator; high for active
    reg SELECTOR;                    // weight select read or use
    reg W_EN;                         // enable weight to flow
    reg [15:0]active_left[7:0];
    reg [15:0]in_sum[15:0];
    reg [15:0]in_weight_above[15:0];
    wire [15:0]out_sum[15:0];
    wire [15:0]active_right[7:0];
    wire [15:0]out_weight_below[7:0];
    PE PE(
        clk,
        reset,
        EN,
        SELECTOR,
        W_EN,
        active_left,
        active_right,
        in_sum,
        out_sum,
        in_weight_above,
        out_weight_below
        );

    initial begin
        reset = 1;
        clk = 1;
        EN = 1;
        SELECTOR = 1;
        W_EN = 1;
        in_sum = 0;
        #100 reset = 0;
        #50 
        in_weight_above = 1;
        active_left = 6;
        #100 
        SELECTOR = 0;
        in_weight_above = 1;
        active_left = 6;
        #100 
        SELECTOR = 0;
        in_weight_above = 2;
        active_left = 6;
        #100 
        SELECTOR = 0;
        in_weight_above = 2;
        active_left = 7;
    end

    always #50 clk = ~clk;
endmodule
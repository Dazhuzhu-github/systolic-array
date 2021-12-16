`timescale 1ns / 1ps

module pe_all_testbench();

    reg [127:0] weight[8191:0];
    reg [127:0] activate[8191:0];
    $readmemh("./weight.txt", weight);
    $readmemh("./activate.txt", activate);
    

endmodule
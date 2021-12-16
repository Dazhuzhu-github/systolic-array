`timescale 1ns / 1ps

module mem_testbench();

reg [7:0] weight[255:0];
reg [7:0] activate[255:0];
initial
begin
    $readmemb("E:/code/digital_design/lab2/weight.txt",weight);
    $readmemb("E:/code/digital_design/lab2/activate.txt", activate);
    //$display("%d",weight[1]);
    
end
endmodule
`timescale 1ns / 1ps

module test_controller();
    reg RESET = 1;
    reg CLK;
    reg EN  = 1;
    wire [5:0] STATE;
    wire W_EN;
    wire SELECTOR;
    wire share_wen;
    wire share_ren;
    wire share_cen;
    reg [127:0] data[15:0];
    reg [127:0] activate[15:0];
    reg [127:0] input_data;
    integer count;
    reg [12:0] IADDR = 0 ;               // input address for shared SRAM
    reg [12:0] WADDR = 16  ;              // weight address for shared SRAM
    reg [12:0] OADDR = 31 ;               // output address for shared SRAM
    //$readmemh("./activate.txt", activate);
    // controller controller(
    //     .CLK(CLK),
    //     .RESET(RESET),
    //     .EN(EN),
    //     .STATE(STATE),
    //     .W_EN(W_EN),
    //     .SELECTOR(SELECTOR),
    //     .share_wen(share_wen),
    //     .share_ren(share_ren),
    //     .share_cen(share_cen),
    //     .input_data(input_data)
    // );
    Accelerator Accelerator(
        .CLK(CLK),
        .RESET(RESET),
        .EN(EN),
        .STATE(STATE),
        //.W_EN(W_EN),
        // .SELECTOR(SELECTOR),
        // .share_wen(share_wen),
        // .share_ren(share_ren),
        // .share_cen(share_cen),
        .IADDR(IADDR),
        .WADDR(WADDR),
        .OADDR(OADDR),
        .input_data(input_data)
    );
    initial begin
        #50 
        $readmemb("E:/code/digital_design/lab2/data.txt", data);
        CLK <= 1;
        RESET <= 0;
        #100
        RESET <=1;
        EN <= 1;
        for (count = 0; count< 16 ; count = count+1'd1) begin
            #(100) input_data <= data[count];
        end
        #100
        for (count = 0; count< 16 ; count = count+1'd1) begin
            #(100) input_data <= data[count];
        end
    end
    always #50 CLK = ~CLK;
endmodule
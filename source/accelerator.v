module Accelerator(
    // interface to system
    input wire CLK,                         // CLK = 200MHz
    input wire RESET,                       // RESET, Negedge is active
    input wire EN,                          // enable signal for the accelerator, high for active
    // parameters giving by testbench (in real implementation should be given by instructions)
    // input wire [9:0] NIN,                   // input channel number
    // input wire [9:0] NOUT,                  // output channel number
    // input wire [15:0] ISIZE,                // input size (8bit for height, 8bit for width, 0 for height=1...)
    // input wire [5:0] IPADDING,              // input padding (3bit for height, 3bit for width, 0 for padding=0...)
    // input wire [7:0] WSIZE,                 // conv kernel size (4bit for height, 4bit for width, 0 for height=1...)
    // input wire [3:0] WSTRIDE,               // conv stride (2bit for height, 2bit for width, 0 for stride=1...)
    // input wire [5:0] OSHIFT,                // right shift bit of the data. 0 for shift=0...
    input wire [12:0] IADDR,                // input address for shared SRAM
    input wire [12:0] WADDR,                // weight address for shared SRAM
    input wire [12:0] OADDR,                // output address for shared SRAM
    output wire [5:0] STATE,                 // output state for the tb to check the runtime...
    input wire [127:0] input_data
    );

// always @(posedge CLK or negedge RESET) begin
//     if(~RESET) begin
//         // reset
        
//     end else if (EN) begin
//         // logic
        
//     end
// end

// controller
wire [12:0] share_addr;
//wire [5:0] STATE;
wire W_EN;
wire SELECTOR;
wire share_wen;
wire share_ren;
wire share_cen;
wire weight_ren;
wire weight_cen;
wire weight_wen;
wire [12:0] weight_addr;
wire input_ren;
wire input_cen;
wire input_wen;
wire [12:0] input_addr;
wire output_ren;
wire output_cen;
wire output_wen;
wire [12:0] output_addr;
controller controller(
        .CLK(CLK),
        .RESET(RESET),
        .EN(EN),
        .STATE(STATE),
        .W_EN(W_EN),
        .SELECTOR(SELECTOR),
        .share_wen(share_wen),
        .share_ren(share_ren),
        .share_cen(share_cen),
        .share_addr(share_addr),
        .weight_wen(weight_wen),
        .weight_ren(weight_ren),
        .weight_cen(weight_cen),
        .weight_addr(weight_addr),
        .activate_wen(input_wen),
        .activate_ren(input_ren),
        .activate_cen(input_cen),
        .activate_addr(input_addr),
        .output_wen(output_wen),
        .output_ren(output_ren),
        .output_cen(output_cen),
        .output_addr(output_addr),
        .IADDR(IADDR),
        .WADDR(WADDR),
        .OADDR(OADDR)
        //OUT PUT ADDR
        //.input_data(input_data)
    );

// // shared buffer
wire [127:0] share_out;
shared_buffer share_buffer(
    .Q(share_out),
    .CLK(CLK),
    .CEN(share_cen),
    .WEN(share_wen),
    .A(share_addr),
    .D(input_data),
    .RETN(share_ren)
);
// input buffer
wire [127:0] input_out;
input_buffer input_buffer(
    .Q(input_out),
    .CLK(CLK),
    .CEN(input_cen),
    .WEN(input_wen),
    .A(input_addr),
    .D(share_out),
    .RETN(input_ren),
    .RESET(RESET)
);
// // weight buffer
wire [127:0] weight_out;
weight_buffer weight_buffer(
    .Q(weight_out),
    .CLK(CLK),
    .CEN(weight_cen),
    .WEN(weight_wen),
    .A(weight_addr),
    .D(share_out),
    .RETN(weight_ren)
);
// PE array
parameter num1 = 16;
parameter num2 = 16;
wire [num2*16-1:0]out_sum;
PE_array #(.num1(num1),.num2(num2))PE_array(
        .CLK(CLK),
        .RESET(RESET),
        .EN(EN),
        .SELECTOR(SELECTOR),
        .W_EN(W_EN),
        // .....
        .active_left(input_out),
        .out_sum_final(out_sum),
        .in_weight_above(weight_out),
        .out_weight_final(out_weight_below)
    );
// output buffer
wire [num2*16-1:0]output_out;
output_buffer output_buffer(
    .Q(output_out),
    .CLK(CLK),
    .CEN(output_cen),
    .WEN(output_wen),
    .A(output_addr),
    .D(out_sum),
    .RETN(output_ren)
    //.RESET(RESET)
);

endmodule

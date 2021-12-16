// weight buffer, ref: shared_buffer
// input buffer, ref: shared_buffer\
//10kb
module weight_buffer(
    output reg  [127:0] Q,
    input  wire         CLK,
    input  wire         CEN,
    input  wire         WEN,
    input  wire [12:0]  A,

    input  wire [127:0] D,
    input  wire         RETN
    );

reg [127:0] mem [15:0];
always @(posedge CLK)
begin
    if(~WEN & RETN) begin
        Q <= 128'd0;
        mem[A] <= D;
    end else if(~CEN & RETN) begin
        Q <= mem[A];
    end else begin
        Q <= 128'd0;
    end
end

endmodule
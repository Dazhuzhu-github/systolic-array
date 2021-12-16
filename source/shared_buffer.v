// shared buffer (128kB)
module shared_buffer(
    output reg  [127:0] Q,
    input  wire         CLK,
    input  wire         CEN,    //chip enable
    input  wire         WEN,    //写信�?
    input  wire [12:0]  A,
    input  wire [127:0] D,      //read data
    input  wire         RETN    //读信�?
    );

reg [127:0] mem [31:0];
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


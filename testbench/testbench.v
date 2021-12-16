`timescale 1ns/1ns

// testbench
module tb();

reg CLK, RESET, EN;
reg [9:0] NIN;
reg [9:0] NOUT;
reg [15:0] ISIZE;
reg [5:0] IPADDING;
reg [7:0] WSIZE;
reg [3:0] WSTRIDE;
reg [5:0] OSHIFT;
reg [12:0] IADDR;
reg [12:0] WADDR;
reg [12:0] OADDR;
wire [5:0] STATE;


Accelerator accelerator(
	.CLK(CLK),
	.RESET(RESET),
	.EN(EN),
	.NIN(NIN),
	.NOUT(NOUT),
	.ISIZE(ISIZE),
	.IPADDING(IPADDING),
	.WSIZE(WSIZE),
	.WSTRIDE(WSTRIDE),
	.OSHIFT(OSHIFT),
	.IADDR(IADDR),
	.WADDR(WADDR),
	.OADDR(OADDR),
	.STATE(STATE)
	);


// clock generate
initial begin
	CLK = 1'd1;
	always # //.........

end

// reset generate
initial begin

end

// other input generation
initial begin
	// signals...

	// write the data ($writememh).....

end

// monitering accelerator state
always @(posedge CLK) begin

	if (STATE == ...) begin
		// readout the data ($readmemh).....

	end
end


endmodule

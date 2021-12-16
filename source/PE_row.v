module PE_row #(parameter  num = 16)
	(
	// interface to system
    input wire CLK,                         // CLK = 200MHz
    input wire RESET,                       // RESET, Negedge is active
    input wire EN,                          // enable signal for the accelerator, high for active
	input wire W_EN,
	input wire SELECTOR,
	// interface to PE array .....
	input wire signed[7:0] active_left,
	input wire [num*8-1:0] in_weight_above,
	output wire [num*8-1:0]out_weight_below,

	input wire [num*16-1:0] in_sum,
	output wire [num*16-1:0]out_sum
	);

wire [num*8-1:0] active_right;
// generate of every PE
genvar gi;
generate
    for(gi = 0; gi < num; gi = gi + 1)   //16 PE
    begin:label
    	// some reg/wire variables for each PE
    	// .......
		if(gi == 0)begin
			PE PE_unit(
    		.CLK(CLK),
    		.RESET(RESET),
    		.EN(EN),
			.SELECTOR(SELECTOR),
			.W_EN(W_EN),
    		// .....
			.active_left(active_left),
			.active_right(active_right[7:0]),
			.in_sum(in_sum[15:0]),
			.out_sum(out_sum[15:0]),
			.in_weight_above(in_weight_above[7:0]),
			.out_weight_below(out_weight_below[7:0])
    		);
		end
		else begin
			PE PE_unit(
    		.CLK(CLK),
    		.RESET(RESET),
    		.EN(EN),
			.SELECTOR(SELECTOR),
			.W_EN(W_EN),
    		// .....
			.active_left(active_right[gi*8-1:(gi-1)*8]),
			.active_right(active_right[(gi+1)*8-1:gi*8]),
			.in_sum(in_sum[(gi+1)*16-1:gi*16]),
			.out_sum(out_sum[(gi+1)*16-1:gi*16]),
			.in_weight_above(in_weight_above[(gi+1)*8-1:gi*8]),
			.out_weight_below(out_weight_below[(gi+1)*8-1:gi*8])
    		);
		end
    	
	end
endgenerate

endmodule
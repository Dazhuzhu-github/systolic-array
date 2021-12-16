//num2: number of pe in pe_row,num1 :number of pe_row
module PE_array#(parameter num1 = 16, parameter num2 = 16)
	(
	// interface to system
    input wire CLK,                         // CLK = 200MHz
    input wire RESET,                       // RESET, Negedge is active
    input wire EN,                          // enable signal for the accelerator, high for active
	input wire SELECTOR,                    // weight select read or use
    input wire W_EN,                         // enable weight to flow
	// ...
	input wire [num1*8-1:0] active_left,
	input wire [num2*8-1:0] in_weight_above,
	output wire [num2*8-1:0] out_weight_final,
	//input wire [num2*16-1:0] in_sum,
	output wire [num2*16-1:0]out_sum_final
	);
//wire [num1*8*num2-1:0] in_weight_above;
wire [num1*8*num2-1:0]out_weight_below;
//wire [num1*16*num2-1:0] in_sum;
wire [num1*16*num2-1:0]out_sum;

reg [255:0]zero = 255'd0;
// generate of every PE row
genvar gi;
generate
    for(gi = 0; gi < num1; gi = gi + 1)   //16 row
    begin:label
    	// some reg/wire variables for each row
    	// .......
		if(gi == 0)begin
			PE_row #(.num(num2))PE_row_unit(
    		.CLK(CLK),
    		.RESET(RESET),
    		.EN(EN),
			.SELECTOR(SELECTOR),
			.W_EN(W_EN),
    		// .....
			.active_left(active_left[7:0]),
			.in_sum(zero),
			.out_sum(out_sum[num2*16-1:0]),
			.in_weight_above(in_weight_above),
			.out_weight_below(out_weight_below[num2*8-1:0])
    		);
		end
		else begin
			PE_row #(.num(num2))PE_row_unit(
    		.CLK(CLK),
    		.RESET(RESET),
    		.EN(EN),
			.SELECTOR(SELECTOR),
			.W_EN(W_EN),
    		// .....
			.active_left(active_left[(gi+1)*8-1:gi*8]),
			.in_sum(out_sum[num2*16*gi-1:num2*16*(gi-1)]),
			.out_sum(out_sum[num2*16*(gi+1)-1:num2*16*gi]),
			.in_weight_above(out_weight_below[num2*8*gi-1:num2*8*(gi-1)]),
			.out_weight_below(out_weight_below[num2*8*(gi+1)-1:num2*8*gi])
    		);
		end
    	
	end
endgenerate

// genvar i;
// generate
// for (i=0;i<16;i = i+1)begin: label2
// 	out_sum_final[(i+1)*8-1:i*8] = out_sum[(num1-1)*16*num2+16*(i+1)-1:(num1-1)*16*num2+16*i+8];
// end
// endgenerate
assign out_sum_final = out_sum[num1*16*num2:(num1-1)*16*num2];
assign out_weight_final = out_weight_below[num1*8*num2-1:(num1-1)*8*num2];
endmodule
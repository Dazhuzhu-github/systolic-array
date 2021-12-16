module PE(
	// interface to system
    input wire CLK,                         // CLK = 200MHz
    input wire RESET,                       // RESET, Negedge is active
    input wire EN,                          // enable signal for the accelerator, high for active
    input wire SELECTOR,                    // weight select read or use
    input wire W_EN,                         // enable weight to flow
    // interface to PE row .....
    input wire signed[7:0]active_left,
    output reg signed[7:0]active_right,

    input wire signed[15:0]in_sum,
    output reg signed[15:0]out_sum,

    input wire signed[7:0]in_weight_above,
    output wire signed[7:0]out_weight_below
	);
    reg signed[7:0] weight_1; 
    reg signed[7:0] weight_2;

    // multiplier
    // accumulator (here use register to calculate and accumulate in one cycle)
    // registers for systolic dataflow
    always @(negedge RESET or posedge CLK )begin
        if(~RESET)
        begin
            out_sum <= 0;
            active_right <= 0;
            //out_weight_below <= 0;
            weight_1 <= 0;
            weight_2 <= 0;
        end
        else
        begin
            if(EN)
            begin
                active_right <= active_left;              
                if(SELECTOR)
                begin                                       
                    out_sum <= weight_2*active_left+in_sum;
                    if(W_EN)
                    begin
                        weight_1 = in_weight_above;
                        //out_weight_below = weight_1;
                    end
                end  
                else
                begin
                    out_sum <= weight_1*active_left+in_sum;
                    if(W_EN)
                    begin
                        weight_2 = in_weight_above;
                        //out_weight_below = weight_2;
                    end
                end             
            end
        end
    end
    assign out_weight_below = (SELECTOR)?weight_1 :weight_2;
endmodule
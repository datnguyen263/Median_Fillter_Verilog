module Transfer #(parameter n=12, parameter Datawidth=8)
		(
		input wire CLK,CLR,WE,
		input wire [Datawidth-1:0] In,
		output wire [Datawidth-1:0] Out
		);

	wire [Datawidth-1:0] save [0 : n-1];
	
	assign Out=save[n-1];
	
	genvar i;
	generate
		for(i=0; i<n; i=i+1) begin : transfer_block
			if(i==0) begin
			REG #(Datawidth) RERE(.CLK(CLK),.CLR(CLR),.DATA(In),.WE(WE),.DATA_OUT(save[i]));
			end else begin
			REG #(Datawidth) RERE(.CLK(CLK),.CLR(CLR),.DATA(save[i-1]),.WE(WE),.DATA_OUT(save[i]));
			end
		end
	endgenerate
		
endmodule

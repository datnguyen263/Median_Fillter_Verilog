 module REG #(parameter Datawidth=8)
	(input CLK,
	input CLR,
	input [Datawidth-1:0] DATA,
	input WE,
	output reg [Datawidth-1:0] DATA_OUT);

	
	always @ (posedge CLK) begin
			if(CLR) begin
				DATA_OUT <= 0;
			end else if (WE) begin
				DATA_OUT <= DATA;
			end
	end
endmodule

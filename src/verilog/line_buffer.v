module line_buffer #(parameter IMG_Width=256, parameter Datawidth=8)
	(
	output wire [Datawidth-1:0] Out0,Out1,Out2,
	input wire [Datawidth-1:0] In,
	input wire CLK, CLR, WE
	);

	wire [Datawidth-1:0] Buffer [0:IMG_Width-1];
	
	assign Out0=Buffer[IMG_Width-1];
	assign Out1=Buffer[IMG_Width-2];
	assign Out2=Buffer[IMG_Width-3];	
	genvar i;
	
	generate
		for(i=0; i<IMG_Width; i=i+1) begin : buffer_line_gen
			if(i==0) begin
			REG #(Datawidth) RERE(.CLK(CLK),.CLR(CLR),.DATA(In),.WE(WE),.DATA_OUT(Buffer[i]));
			end else begin
			REG #(Datawidth) RERE(.CLK(CLK),.CLR(CLR),.DATA(Buffer[i-1]),.WE(WE),.DATA_OUT(Buffer[i]));
			end
		end
	endgenerate
	
endmodule

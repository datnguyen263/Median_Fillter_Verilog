module line_buffer_kernel_3 #(parameter IMG_Width=256, parameter Datawidth=8, parameter Clock_Valid=IMG_Width+2)
(
	output wire [Datawidth-1:0] R00,R01,R02,R10,R11,R12,R20,R21,R22,
	output wire Valid_OUT,
	input wire [Datawidth-1:0] In,
	input wire Valid_IN, CLK, CLR
);
	REG #(Datawidth) RR22
	(
	.CLK(CLK),
	.CLR(CLR),
	.DATA(In),
	.WE(Valid_IN),
	.DATA_OUT(R22)
	);

	REG #(Datawidth) RR21
	(
	.CLK(CLK),
	.CLR(CLR),
	.DATA(R22),
	.WE(Valid_IN),
	.DATA_OUT(R21)
	);	
	
	REG #(Datawidth) RR20
	(
	.CLK(CLK),
	.CLR(CLR),
	.DATA(R21),
	.WE(Valid_IN),
	.DATA_OUT(R20)
	);
	
	line_buffer #(.IMG_Width(IMG_Width), .Datawidth(Datawidth)) Line2
	(
	.Out0(R10),.Out1(R11),.Out2(R12),
	.In(R20),
	.CLK(CLK), .CLR(CLR), .WE(Valid_IN)
	);	
	
	line_buffer #(.IMG_Width(IMG_Width), .Datawidth(Datawidth)) Line3
	(
	.Out0(R00),.Out1(R01),.Out2(R02),
	.In(R10),
	.CLK(CLK), .CLR(CLR), .WE(Valid_IN)
	);

	ValidInOut #(.n(Clock_Valid)) rere
	(
	.CLK(CLK),.CLR(CLR),.Valid_IN(Valid_IN),
	.Valid_OUT(Valid_OUT)
	);
endmodule

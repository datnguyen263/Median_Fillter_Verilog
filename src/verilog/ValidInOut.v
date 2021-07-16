module ValidInOut #(parameter n=12)
		(
		input wire CLK,CLR,Valid_IN,
		output wire Valid_OUT
		);

		Transfer #(.n(n),.Datawidth(1)) Trans
		(
		.CLK(CLK),.CLR(CLR),.WE(Valid_IN),
		.In(Valid_IN),
		.Out(Valid_OUT)
		);

		
endmodule

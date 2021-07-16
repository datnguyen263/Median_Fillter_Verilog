module datapath #(parameter ADDR_WIDTH = 16, parameter DATA_WIDTH = 8, parameter ROW = 256, parameter COL = 256)
(
input clk,
input reset,
input en,
input push_pop1, push_pop2,
input [DATA_WIDTH-1:0] DATA_IN,
output [DATA_WIDTH-1:0] DATA_OUT,
output Valid_OUT
);
wire [DATA_WIDTH-1:0] fifo1, med;
	FIFO_256x256 FIFO_256x2561(
		.clk (clk),
		.reset(reset),
		.en (1),
		.push_pop (push_pop1),
		.DATA_IN (DATA_IN),
		.DATA_OUT (fifo1),
		.full_signal (),
		.empty_signal()
	);

	test_module test_module_inst(   .result(med),
			.Valid_OUT(Valid_OUT),
			.In(fifo1),
			.CLK(clk),
			.CLR(reset),
			.Valid_IN(1),.i()			
			);

	FIFO_256x256 FIFO_256x2562(
		.clk (clk),
		.reset(reset),
		.en (1),
		.push_pop (push_pop2),
		.DATA_IN (med),
		.DATA_OUT (DATA_OUT),
		.full_signal (),
		.empty_signal()
	);	
endmodule

module datapath #(parameter ADDR_WIDTH = 16, parameter DATA_WIDTH = 8, parameter ROW = 256, parameter COL = 256)
(
input clk,
input reset,
input push, pop,
input [DATA_WIDTH-1:0] DATA_IN,
output [DATA_WIDTH-1:0] DATA_OUT,
output Valid_OUT
);
wire [DATA_WIDTH-1:0] med;

	test_module test_module_inst(   
			.result(med),
			.Valid_OUT(Valid_OUT),
			.In(DATA_IN),
			.CLK(clk),
			.CLR(reset),
			.Valid_IN(1),.i()			
			);

	fifo fifo_inst2(
	.data_out(DATA_OUT),
	.full(),		
	.empty(),	
	
	.data_in(med),
	.clk(clk),
	.rst(reset),		
	.push(push),		
	.pop(pop)
	);
endmodule

module top
#(
parameter DATA_WIDTH = 8
)
(
input clk,
input reset,
input [DATA_WIDTH-1:0] DATA_IN,
output [DATA_WIDTH-1:0] DATA_OUT,
output Valid_OUT
);
wire ctrl_push, ctrl_pop;
datapath datapath_inst(
	.clk(clk),
	.reset(reset),
	.push(ctrl_push), .pop(ctrl_pop),
	.DATA_IN(DATA_IN),
	.DATA_OUT(DATA_OUT),
	.Valid_OUT(Valid_OUT)
	);

control control_inst
(
	.clk(clk), .reset(reset),
	.push(ctrl_push), .pop(ctrl_pop)
);

endmodule

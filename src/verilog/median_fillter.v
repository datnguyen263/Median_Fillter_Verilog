`define ROW 256
`define COL 256

module median_fillter (
	input [`ROW-1:0] row_in, // input row
	input CLK,                          // clock
	input SET,                          // set signal
	input RST,                           // reset signal

	output reg[`ROW-1:0] 	row_out  //output row fixed each clock event.		
);

endmodule

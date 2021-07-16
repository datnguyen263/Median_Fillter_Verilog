module median_filter(
result,
row_in,
CLK,
SET,
RST
);

parameter ROW = 512;
parameter COL = 512;
parameter width = 8;
output [0:ROW*width-1] result;
input  [0:ROW*width-1] row_in;
input	SET,RST,CLK;
wire [ROW*width*3-1:0] row_out;

FSM control(
row_in  , //input row each clock event. 
CLK     , //Clock.
SET	, //set 
RST     , //reset
row_out
);
med_3x512 datapath(
result,
row_out[ROW*width*3-1:1024*width],
row_out[ROW*width*2-1:512*width],
row_out[ROW*width-1:0]
);
endmodule

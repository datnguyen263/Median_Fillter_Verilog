module median_filter(result,
Valid_OUT,
In,
CLK,
CLR,
Valid_IN,i			
);


	parameter width = 8;
	output [width-1:0] result;
	output Valid_OUT;
	input  [width-1:0] In;
	input	Valid_IN, CLK, CLR;
	output reg [15:0] i;
	wire [width-1:0] R00,R01,R02,R10,R11,R12,R20,R21,R22;


line_buffer_kernel_3 linebuff (  R00,R01,R02,R10,R11,R12,R20,R21,R22,
Valid_OUT,
In,Valid_IN, CLK, CLR
);


med_9 med(
result,    
R00,R01,R02,R10,R11,R12,R20,R21,R22
);
always @(posedge CLK) begin:COUNT
	if(CLR) begin
		i = 0;
	end
	else i = i + 1;
end

endmodule

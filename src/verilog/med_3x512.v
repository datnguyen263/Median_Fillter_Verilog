module med_3x512(
median_3,
line1,
line2,
line3
);
	parameter ROW = 512;
	parameter COL = 512;
	parameter width = 8;
	output [0:ROW*width-1] median_3;
	input [0:ROW*width-1] line1;
	input [0:ROW*width-1] line2;
	input [0:ROW*width-1] line3;
	genvar i;
	generate
	for (i=0; i<COL -2 ; i=i+1) begin: geni
	med_9 out(median_3[8*i +:8], line1[8*i   +: 8], line1[8*i+8 +:8] , line1[8*i+16 +:8], line2[8*i   +: 8], 
		line2[8*i+8 +:8] , line2[8*i+16 +:8] , line3[8*i   +: 8], line3[8*i+8 +:8] , line3[8*i+16 +:8]);
	end
	endgenerate
	
endmodule

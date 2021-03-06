module med_9 (
median_2,     //9 Byte in, one median out
p11,  
p12,
p13,
p21,
p22,
p23,
p31,
p32,
p33
);
parameter width = 8;
	
output   [0:width-1] median_2;     //9 Byte in, one median out
input	 [0:width-1] p11;  
input	 [0:width-1] p12;
input	 [0:width-1] p13;
input	 [0:width-1] p21;
input	 [0:width-1] p22;
input	 [0:width-1] p23;
input	 [0:width-1] p31;
input	 [0:width-1] p32;
input	 [0:width-1] p33;
wire [0:width-1] L1;
wire [0:width-1] L2;
wire  [0:width-1] L3;

med_3 median1(L1,p11, p12, p13);
med_3 median2(L2,p21, p22, p23);
med_3 median3(L3,p31, p32, p33);
med_3 median4(median_2,L1, L2, L3);

endmodule

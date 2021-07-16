module med_3 (
  median_1,
  p_1,
  p_2,
  p_3
  );
  parameter width = 8;
  output [0:width-1 ]median_1;
  input [0:width-1]p_1;
  input [0:width-1]p_2;
  input [0:width-1]p_3;


assign median_1 = ((p_3>=p_2 && p_3<=p_1) || (p_3>=p_1 && p_3<=p_2)) ? p_3:
			((p_1>=p_3 && p_1<=p_2) || (p_1>=p_2 && p_1<=p_3)) ? p_1: p_2;
					

endmodule

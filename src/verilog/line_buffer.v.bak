`define width 8
module function1 (
output [0:`width-1]median_1;
input [0:`width-1]p_1;
input [0:`width-1]p_2;
input [0:`width-1]p_3;
);

	if(p_1>=p_3 && p_1<=p_2)  // 3 1 2
		median_1=p_1;
	else if(p_1>=p_2 && p_1<=p_3)  // 2 1 3 
		median_1=p_1;
	else if(p_2>=p_1 && p_2<=p_3)  // 1 2 3 
		median_1=p_2;
	else if(p_2>=p_3 && p_2<=p_1)  // 3 2 1 
		median_1=p_2;
	else if(p_3>=p_1 && p_3<=p_2)  // 1 3 2
		median_1=p_3;
	else if(p_3>=p_2 && p_3<=p_1)  // 2 3 1
		median_1=p_3;	
endmodule 
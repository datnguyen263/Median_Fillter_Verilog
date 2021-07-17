//0->514 start
module control
(
	input clk, reset,
	output reg push, pop
);
	reg [17:0] count_clk;

	always @(posedge clk) begin
		if(reset) begin
			count_clk <= 0;
			push <= 0;
			pop <= 0;
		end
		else begin
			count_clk <= count_clk + 1;
			if(count_clk < 18'd515) begin
				push <= 0;
				pop <= 0;
			end
			else if(count_clk > 18'd514 && count_clk < 18'd66051) begin
				push <= 1;
				pop <= 0;				
			end
			else if(count_clk > 18'd66050 && count_clk < 18'd131587) begin
				push <= 0;
				pop <= 1;				
			end
			else if(count_clk > 18'd131586) begin
				count_clk <= 0;		
			end
		end
	end
endmodule

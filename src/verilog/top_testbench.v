
`timescale 1ns / 1ps

module top_testbench();
	
parameter clk_prd = 40;
parameter DATA_WIDTH = 8;
parameter num_step = 517+256*256 + 256*256;

reg clk;
reg reset;
reg [DATA_WIDTH-1:0] DATA_IN;
wire [DATA_WIDTH-1:0] DATA_OUT;
wire Valid_OUT;
	
	
	integer pixel_data, pixel_result, i;
		
	initial begin
		pixel_data = $fopen("test_gray.txt", "r");
		pixel_result = $fopen("FIFO_Result.txt", "w");
		
		clk = 1; reset = 1; 
		#clk_prd
		reset = 0; 
		
		for(i=0; i<=num_step; i=i+1) begin
		  	$fscanf(pixel_data, "%b\n", DATA_IN);
			#clk_prd
			if(i == num_step) $finish;
		end
		
		$fclose(pixel_data);

	end
	always @(posedge clk) begin
		if (DATA_OUT != 2'hxx)
      		$fwrite(pixel_result, "%b\n" , DATA_OUT);
	end
		
	always @(clk) #(clk_prd/2) clk <= ~clk;
	
	top top_inst(
	clk,
	reset,
	DATA_IN,
	DATA_OUT,
	Valid_OUT
	);
endmodule 
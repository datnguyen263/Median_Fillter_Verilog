
`timescale 1ns / 1ps

module line_buffer_kernel_3_tb();
	
	parameter clk_prd = 40;
	parameter Datawidth = 8;
	parameter num_step = 256*256;

	wire [Datawidth-1:0] R00,R01,R02,R10,R11,R12,R20,R21,R22;
	wire Valid_OUT;
	reg [Datawidth-1:0] In;
	reg Valid_IN, CLK, CLR;
	
	
	integer pixel_data, i;
	
	initial begin
		pixel_data = $fopen("test_gray.txt", "r");
		
		CLK = 1; CLR = 1; Valid_IN = 1;
		#clk_prd
		CLR = 0; 
		
		for(i=0; i<=num_step; i=i+1) begin
		  	$fscanf(pixel_data, "%b\n", In);
			#clk_prd
			if(i == num_step) $finish;
		end
		
		$fclose(pixel_data);

	end
		
	always @(CLK) #(clk_prd/2) CLK <= ~CLK;
	
	line_buffer_kernel_3 line_buffer_kernel_3_inst(
	R00,R01,R02,R10,R11,R12,R20,R21,R22,
	Valid_OUT,
	In,
	Valid_IN, CLK, CLR
	);
endmodule
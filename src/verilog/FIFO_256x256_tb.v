`timescale 1ns / 1ps

module FIFO_256x256_tb();
	
	parameter clk_prd = 40;
	parameter DATA_WIDTH = 8;

	reg clk;
	reg reset;
	reg en;
	reg push_pop;
	reg [DATA_WIDTH-1:0] DATA_IN;
	wire [DATA_WIDTH-1:0] DATA_OUT;
	wire full_signal;
	wire empty_signal;
	
	
	integer pixel_data, pixel_result, i;
	
	initial begin
		pixel_data = $fopen("test_gray.txt", "r");
		pixel_result = $fopen("FIFO_Result.txt", "w");
		
		clk = 1; reset = 1; push_pop = 1; en = 1;
		#clk_prd
		reset = 0; 
		
		for(i=0; i<=1311072; i=i+1) begin
		  $fscanf(pixel_data, "%b\n", DATA_IN);
		  if(i<65537) begin
		    	push_pop = 1; en = 1;
		  end
     		 else if(i>65536) begin
            			en = 1;
            			push_pop = 0;
     		 end
		        
			
			#clk_prd
			if(i == 1311072) $finish;
		end
		
		$fclose(pixel_data);

	end
	always @(posedge clk) begin
      	$fdisplay(pixel_result, "%b" , DATA_OUT);
	end
		
	always @(clk) #(clk_prd/2) clk <= ~clk;
	
	FIFO_256x256 FIFO_dut(clk, reset, en, push_pop, DATA_IN, DATA_OUT, full_signal, empty_signal );
endmodule

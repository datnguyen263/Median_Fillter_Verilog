
`timescale 1ns / 1ps

module testbench();
	
	parameter clk_prd = 40;
	parameter DATA_WIDTH = 8;

reg clk;
reg reset;
reg en;
reg push_pop1, push_pop2;
reg [DATA_WIDTH-1:0] DATA_IN;
wire [DATA_WIDTH-1:0] DATA_OUT;
wire Valid_OUT;
	
	
	integer pixel_data, pixel_result, i;
	
	initial begin
		pixel_data = $fopen("test_gray.txt", "r");
		pixel_result = $fopen("FIFO_Result.txt", "w");
		
		clk = 1; reset = 1; en = 1;
		#clk_prd
		reset = 0; 
		
		for(i=0; i<=1311072; i=i+1) begin
		  $fscanf(pixel_data, "%b\n", DATA_IN);
		  if(i<65537) begin
		    	push_pop1 = 1; en = 1;
			push_pop2 = 0; 
		  end
     		 else if(i>65536) begin
            		push_pop1 = 0; en = 1;
			push_pop2 = 1;
     		 end
		else if(i>1311072) begin
            		push_pop1 = 0; en = 1;
			push_pop2 = 0;
     		 end
		        
			
			#clk_prd
			if(i == 1376608) $finish;
		end
		
		$fclose(pixel_data);

	end
	always @(posedge clk) begin
      	$fdisplay(pixel_result, "%b" , DATA_OUT);
	end
		
	always @(clk) #(clk_prd/2) clk <= ~clk;
	
	datapath datapath_inst(clk,
	reset,
	en,
	push_pop1, push_pop2,
	DATA_IN,
	DATA_OUT,
	Valid_OUT
	);
endmodule
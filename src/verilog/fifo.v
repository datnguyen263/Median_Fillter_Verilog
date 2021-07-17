module fifo #(
	parameter DATA_WIDTH = 8,
	parameter FIFO_DEPTH = 256*256
)(
	output reg [DATA_WIDTH-1:0] data_out,
	output wire full,		//1 if full
	output wire empty,	//1 if empty
	
	////debuging////
	//output reg [$clog2(DEPTH)-1:0] push_ptr,
	//output reg [$clog2(DEPTH)-1:0] pop_ptr,
	//output reg [$clog2(DEPTH):0] fifo_cnt,
	
	input [DATA_WIDTH-1:0] data_in,
	input wire clk,
	input wire rst,		//reset
	input wire push,		//write data
	input wire pop			//read data
);

	reg [DATA_WIDTH-1:0] fifo_ram [0:FIFO_DEPTH-1];	//generate ram
	
	reg [$clog2(FIFO_DEPTH)-1:0] push_ptr;	//push pointer
	reg [$clog2(FIFO_DEPTH)-1:0] pop_ptr;	//pop pointer
	reg [$clog2(FIFO_DEPTH):0] fifo_cnt;	//fifo counter
	
	assign empty = (fifo_cnt==0);
	assign full = (fifo_cnt==FIFO_DEPTH);
	
	//push data_in
	always @( posedge clk ) begin: write
		if (push && !full)
			fifo_ram[push_ptr] <= data_in;
		else if (push && pop)
			fifo_ram[push_ptr] <= data_in;
	end
	
	//pop data_out
	always @( posedge clk ) begin: read
		if (pop && !empty)
			data_out <= fifo_ram[pop_ptr];
		else if (pop && push && empty)
			data_out <= fifo_ram[pop_ptr];
	end
	
	//pointer
	always @( posedge clk ) begin: pointer
		if( rst ) begin	//reset pointer
			push_ptr <= 0;
			pop_ptr <= 0;
		end else begin
			push_ptr <= ( (push && !full) || (push && pop) ) ? push_ptr + 1 : push_ptr;
			pop_ptr <= ( (pop && !empty) || (push && pop) ) ? pop_ptr + 1 : pop_ptr;
		end
	end
	
	//counter
	always @( posedge clk ) begin: counter
		if( rst )			//reset counter
			fifo_cnt <= 0;	
		else begin
			case ( {push,pop} )
				2'b00 : fifo_cnt <= fifo_cnt;
				2'b01 : fifo_cnt <= (fifo_cnt == 0) ? 0 : fifo_cnt - 1;
				2'b10 : fifo_cnt <= (fifo_cnt == FIFO_DEPTH) ? FIFO_DEPTH : fifo_cnt + 1;
				2'b11 : fifo_cnt <= fifo_cnt;
				default: fifo_cnt <= fifo_cnt;
			endcase
		end
	end
endmodule

//Edited and improved by ANT
module FIFO_256x256

#(
	parameter ADDR_WIDTH = 16,
	parameter DATA_WIDTH = 8
)

(
	input clk,
	input reset,
	input en,
	input push_pop,
	input [DATA_WIDTH-1:0] DATA_IN,
	output [DATA_WIDTH-1:0] DATA_OUT,
	output full_signal,
	output empty_signal
);

	wire [ADDR_WIDTH:0] wptr_out, rptr_out;
	wire cs_out, we_out, re_out;
	
	
	ff_ram_256x256 ff_ram_256x256_inst(
											  .cs(cs_out),								
											  .rws(push_pop),							
											  .wptr(wptr_out[ADDR_WIDTH-1:0]),		
											  .rptr(rptr_out[ADDR_WIDTH-1:0]),	
											  .data_in(DATA_IN),
											  .data_out(DATA_OUT)
											 );

	Write_Pointer_256x256 Write_Pointer_256x256_inst(
																.clk(clk),
																.rst(reset),
																.fifo_we(we_out),
																.wptr(wptr_out)
															);
											
	Read_Pointer_256x256 Read_Pointer_256x256_inst  (
																.clk(clk),
																.rst(reset),
																.fifo_re(re_out),
																.rptr(rptr_out)
															);
											
	Status_Signal_256x256 Status_Signal_256x256_inst (
																.ff_en(en),
																.ff_push_pop(push_pop),
																.wptr(wptr_out),
																.rptr(rptr_out),
																.ff_we(we_out),
																.ff_re(re_out),
																.ff_cs(cs_out),
																.full_signal(full_signal),
																.empty_signal(empty_signal)
															);
endmodule

`define ROW 512
`define COL 512
`define width 8
`define IN_FILE_NAME  "test_gray.txt"
`define OUT_FILE_NAME "data_out.txt"

module test_median;

reg              [0:2097151] data_in;	   // all data
//reg      [`ROW*`width-1:0]data_out;	   // line out from module
integer   file_in, file_out, i, f;	   // file pointer's, loop index's

wire      [0:`ROW*`width-1]    result;
reg      [`ROW*`width-1:0]  row_in;
reg 				CLK ;
reg				SET ;
reg				RST ;
//wire     [`ROW*`width-1:0] row_out;

median_filter UUT(
.result (result),
.row_in (row_in), 
.CLK    (CLK), 
.SET	(SET), 
.RST    (RST)
);

always 
begin 
CLK = 0; 
#5; 
CLK = 1; 
#5; 
end  

initial begin
file_in  = $fopen(`IN_FILE_NAME,"rb");
file_out = $fopen(`OUT_FILE_NAME,"wb");
f = $fread(data_in , file_in);
SET = 1'b0;			//first row in with the commend SET//
row_in = data_in[0:4095];
RST = 1'b1;
#5;
SET = 1'b1;
RST = 1'b0;

row_in = data_in[4096:8191];	//second row
RST = 1'b1;
SET = 1'b1;	
for ( i=0 ; i<`ROW; i=i+1 )    //all other rows
begin
	SET =  1'b1;
	row_in = data_in[8192+4096*i +:4096];
	RST =  1'b1;
	if (result != 1024'hx) $fwrite(file_out, "%b\n" ,result);
	#10;
end
$fclose(file_in);
$fclose(file_out);
$stop;
end

endmodule 
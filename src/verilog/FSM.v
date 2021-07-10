module FSM(
row_in  , //input row each clock event.
CLK     , //Clock.
SET	, //set 
RST     , //reset
row_out,
state,next,
counter   //output row fixed each clock event.
);
parameter ROW=512, COL= 512, width=8;

input     [ROW*width-1:0] 	row_in  ; //input row each clock event.
input 			CLK     ; //Clock.
input				SET	; //set 
input				RST     ; //reset
output reg [ROW*width*3-1:0] 	row_out;
output reg [2:0] state,next;

output reg [width:0] counter;  //output row fixed each clock event.
reg       [ROW*width-1:0]	line_1  ; //up.
reg       [ROW*width-1:0]	line_2  ; //middle.
reg       [ROW*width-1:0]	line_3  ; //down.
//reg		       [2:0] state, next; //state mechine.
//reg             [width:0]   counter  ; //counter

parameter [2:0]  ROW1 = 3'b000,
                 ROW2 = 3'b001,
		 ROW3 = 3'b010,
		 ROUTINE = 3'b011,
		 ROW510 = 3'b100,
		 SLEEP = 3'b101;

//always@(posedge CLK or negedge SET) begin
//	if(SET == 1'b0)				 // wait for set 
//		begin
//		counter <= 8'b00000000; 
//		state <= ROW1; 
//		end		                 
//	else 
//		state <= next;
//end
// -----------------------------------------------------------------------------
always@(posedge CLK or negedge SET or negedge RST) begin
	if(SET == 1'b0)				 // wait for set 
		begin
		counter = 8'b00000000; 
		state = ROW1; 
		end		                 
	else 
		state = next;
		
	case(state)
		ROW1:	
			begin
			line_1 = row_in;
			next = ROW2;
			end
		ROW2:	
			begin
			line_2 = row_in;
			next = ROW3;
			end
			  ROW3:
			begin
			row_out={line_1,line_1,line_2};
			//row_out = median_3 ( line_1, line_1, line_2 );
			line_3 = row_in;
			counter = counter + 1'b1;
			next = ROUTINE;
			end
		  ROUTINE:
			begin
			row_out={line_1,line_2,line_3};
			//row_out = median_3 (line_1, line_2, line_3 );
			line_1 = line_2;
			line_2 = line_3;
			line_3 = row_in;
			counter = counter + 1'b1;
				if (counter == 9'b111111110)  //510
					next = ROW510;
				else
					next = ROUTINE;
			end
			ROW510:
			begin
			row_out={line_2,line_2,line_3};
			//row_out = median_3 (line_2, line_3, line_3 );
			next = SLEEP;                 //go sleep
			end
			 SLEEP:
			begin
				if(RST == 1'b0)       //wait for reset
					next = ROW1;
				else
					next = SLEEP; 
			end
	endcase
	end
endmodule 
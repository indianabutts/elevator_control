`timescale 1ns/1ps
module top_tb;

   logic clk;
   logic reset;
   logic request;
   logic [1:0] traffic_state;
   logic [2:0] request_floor;
   logic       request_dir;
 int 	       stim_counter = 0;
   
   top DUT (.*);

   initial
     begin
	clk=0;
	reset=1;
#10 reset = 0;
     end
always #10 clk = !clk;
   always_ff@(posedge clk)
     begin
	request<=0;

	case(stim_counter)
	  0:
	    begin
	       traffic_state<=0;
	    end
	endcase // case (stim_counter)
	

	stim_counter ++;
	
     end

endmodule // top_tb

//Elevator Queue
// This module is the queue for the elevator system
// To simplify the process of determining the destination
// Each bit represents one floor of the buidling, where 1
// means that it is in the queue and 0 means not in queue
// TO DO Write function to calculate Log2(FloorCount) 
`timescale 1ns/1ps
module elevator_queue #(parameter FLOOR_COUNT = 7)
   (
    input logic 		   clk,
    input logic 		   reset,
    input logic 		   deassert_floor,
    input logic [2:0] 		   requested_floor,
    output logic [FLOOR_COUNT-1:0] queue_status
    );
   
   logic [FLOOR_COUNT-1:0] 	   local_queue_status;

   assign queue_status<=
   
   always_ff @ (posedge clk)
     begin
	if(reset)
	  begin
	     local_queue_status<=0;
	  end
	else
	  begin
	     if(!r_nwr)
	       begin
		  if(deassert_floor)
		    begin
		     local_queue_status[requested_floor] <= 0;
		    end
		  else
		    begin
		       local_queue_status[requested_floor] <= 1;
		    end
	       end // if (!r_nwr)
	     else
	       begin
		  queue_status<=local_queue_status;
	       end // else: !if(!r_nwr)
	  end
     end
   
   

endmodule // elevator_queue

   

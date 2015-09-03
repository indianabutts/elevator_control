//Elevator Queue
// This module is the queue for the elevator system
// To simplify the process of determining the destination
// Each bit represents one floor of the buidling, where 1
// means that it is in the queue and 0 means not in queue
`timescale 1ns/1ps
module elevator_queue #(parameter FLOOR_COUNT = 8)(
		      input 		      clk,
		      input 		      reset,
		      input 		      r_nwr,
		      input 		      clear_bit,
		      inout [FLOOR_COUNT-1:0] queue_data);
   

   //Local Value Definitions
   reg [FLOOR_COUNT-1:0]   local_queue;
   
   assign queue_data = (r_nwr) ? local_queue  : 'bz;
   
   always @ (posedge clk)
     begin
	if(reset)
	  begin
	     local_queue<=0;
	  end
	else
	  begin
	     if(!r_nwr)
	       begin
		  if(clear_bit && (local_queue & queue_data === queue_data))
		    begin
		     local_queue <= local_queue^queue_data;
		    end
		  else
		    begin
		       local_queue <= local_queue | queue_data;
		    end
	       end

	     
	  end
     end
   
   

endmodule // elevator_queue

   

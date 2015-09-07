// Destination Resolver
// Looks at Queue and Figures out where to go next.


module elevator_direction_resolver(
			     input logic clk,
				input logic reset,
			     input logic       current_up_ndown,
			     input logic [6:0] queue_status,
			     input logic [2:0] current_floor,
			     output logic      queue_empty,
			     output logic      next_up_ndown
			     );

   logic 					l_up;
   logic 					l_down;
   
   ///Simplyify This to only check the direction of the queue,
   // A Simpler module will determine if the next level is part of the queue to stop the vehicle.
   // The algorithm is simple
   // Check current-floor up to the top, if there is a 1, then direction up is true,
   // check current floor to 0, if there is a 1, down is also true,
   // Then check compared to current_direction, if matches, then continue in same direction
   // Else change direction.

   assign l_down = ({queue_status,7'h00}[current_floor +:7] || 1'b0) ? 1 : 0;
   
   assign l_up = ({7'h00,queue_status}[(current_floor+7) -: 7] || 1'b0) ? 1 : 0;
   



   always_comb
     begin
	if(l_up & !l_down)
	  begin
	     next_up_ndown=1'b1;
	  end
	else if (l_down & !l_up)
	  begin
	     next_up_ndown=1'b0;	     
	  end
	else if (l_down & l_up )
	  begin
	     next_up_ndown = l_up & current_up_ndown;   
	  end
queue_empty = !(l_up | l_down);
     end
   
   

endmodule // elevator_direction_resolver

   

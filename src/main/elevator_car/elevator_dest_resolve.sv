// Destination Resolver
// Looks at Queue and Figures out where to go next.


module elevator_dest_resolver(
			     input logic 	clk,
			     input logic 	reset,
			     input logic 	up_ndown,
			     input logic [6:0] 	queue_status,
			     input logic [2:0] 	current_floor,
			     output logic 	check_done,
			     output logic [2:0] destination_floor
			     );


   //iterate over the whole Queue
   // using current_floor (n) and direction,
   // if direction is up, and n++ has a 1, then 
   // continue in the direction
   // else change direciton.
   // Destination Floor 7 doesnt exist and so is the case when no
   // Match has been found and the elevator should return to its
   // default

   logic [2:0] 					q_index;
   logic 					selected_queue_entry;
   logic 					selected_direction_up_ndown;   
   logic [2:0] 					last_match;

   assign last_match = (queue_status[q_index] & !check_done) ? q_index : 3'b111; 
   assign selected_queue_entry = queue_status[q_index];
   assign selected_direction_up_ndown = (last_match < current_floor) ? 1b0 : 1'b1; 
   
   always_ff@(posedge clk)
     begin
	if(reset)
	  begin
	     destination_floor<=3'b111;
	     q_index<=current_floor;
	     check_done<=0;    
	  end
	else
	  begin
	     if(!check_done)
	       begin
		  q_index<=current_floor;
		  
		  if(q_index<6 & up_ndown)
		    begin
		       destination_floor<=last_match;
		       q_index++;
		    end // if (q_index<=6)
		  else if(q_index>0 & !up_ndown)
		    begin
		       destination_floor<=last_match;
		       q_index--;
		    end
		  else
		    begin
		       check_done<=1'b1;
		    end
	       end // if (!check_done)
	  end // else: !if(reset)
     end // always_ff@
   

endmodule // elevator_dest_resolver

   

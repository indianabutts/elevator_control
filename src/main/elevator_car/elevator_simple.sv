// Simple Elevator

module elevator_simple();

   

   // If the elevator is stationary
   // And receives a request,
   // It will begin into move towards the floor.
   // Request Again will move it to the next floor

   
   always_ff@(posedge clk)
     begin

	if(reset)
	  begin
	  end
	else
	  begin
	     case(state)
	       2'b00:
		 begin
		    if(request)
		      begin
			 elevator_destination<=requested_floor;
			 ack<=1'b1;
		      end
		 end
	     endcase // case (state)
	     
	  end
	
     end
   

endmodule // elevator_simple

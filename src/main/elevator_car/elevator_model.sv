// Model for the Elevator Cart


module elevator_model(
		      );





   always_comb
     begin
       
     end
   
   
   always_ff@(posedge clk)
     begin
	if(reset)
	  begin
	  end
	else
	  begin
	     moving<=0;
	     i=0;
	     case(state)
	       2'b00://PARKED
		 begin
		    if(!queue_empty)
		      begin
			 state<=2'b01;
		      end
		 end
	       2'b01://PREPARE TO MOVE
		 begin
		    
		    if(moving===1'b0)
		      begin
			 (queue_status[i]==1'b1)
			i++;
			 
		      end
		    if(time_unit_counter === 5　&& moving===1'b0 )
		      begin
			 state<=2'b11;
		      end
		    else
		      begin
			 state<=2'b11; 
		      end
		 end
	       2'b11://MOVE
		 begin
		    moving<=1;
		    //IF not at the destianation, then wait 5 seconds, and
		    //change floor based on direction.
		    //If floor reached, move to disembark state.
		    if(current_floor!=destination_floor)
		      begin
			 if(time_unit_counter === 5)
			   begin
			      if(up_ndown)
				begin
				   current_floor++;
				end
			      else
				begin
				   current_floor--;
				end
			   end // if (time_unit_counter === 5)
		      end // if (current_floor!=destination_floor)
		    else
		      begin
			 state<=2'b11;
		      end
		    
		 end
	       2'b10://DISEMBARK
		 begin
		    moving<=1;
		    //After 5 seconds, close doors, and check.
		    // if queue empty, go to the park state.
		    // if queue no empty, prepare to move.
		    if(time_unit_counter === 5)
		      begin
			 if(!queue_empty)
			   begin
			      state<=2'b01;
			   end
			 else
			   begin
			      state<=2'b00;
			   end
		      end
		 end
	     endcase
	  end
     end

endmodule // elevator_model

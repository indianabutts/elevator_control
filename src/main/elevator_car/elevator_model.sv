// Model for the Elevator Cart


module elevator_model(
		      input logic 	 clk,
		      input logic 	 reset,
		      input logic 	 queue_empty,
		      input logic 	 next_up_ndown,
		      input logic [2:0]  default_floor,
		      input logic [6:0]  queue_status,
		      output logic 	 current_up_ndown, 
		      output logic [2:0] current_floor,
		      output logic 	 deassert_floor
		      );
   
   logic 				 stop_next;
   logic 				 time_unit;
   logic [19:0] 			 time_unit_divider;
   logic [1:0] 				 state;
   
   always_ff@(posedge clk or posedge reset)
     begin
	if(reset)
	  begin
	     time_unit<=0;
	     time_unit_divider<=0;
	     
	  end
	else
	  begin
	     time_unit_divider++;
	     time_unit<=0;
	     
	     if(time_unit_divider===10)
	       begin
		  time_unit<=1;
		  time_unit_divider<=0;
		  
	       end
	  end
     end
   
   always_ff@(posedge clk or posedge reset)
     begin
	if(reset)
	  begin
	     current_up_ndown<=0;
	     current_floor<=0;
	     stop_next<=0;
	     deassert_floor<=0;
	     state<=0;
	     
	  end
	else
	  begin
	     case(state)
	       2'b00://PARKED
		 begin
		 if(!queue_empty & time_unit)
		   begin
		      state<=2'b01;
		   end
		 else
		   begin
		      if(current_floor!=default_floor)
			begin
			   if(time_unit)
			     begin
				if((default_floor<current_floor))
				  begin
				     current_floor--;
				     current_up_ndown<=0;
				       end
				else
				  begin
				     current_floor++;
				     current_up_ndown<=1;
				  end
			     end
			     
			end // if (current_floor!=default_floor)
		      else
			begin
			   if(current_floor===6)
			     begin
				current_up_ndown<=0;
				
			     end
			   else
			     begin
				current_up_ndown<=1;
				
			     end
			   
			end // else: !if(current_floor!=default_floor)
		      
		   end
		 end
	       2'b01://PREPARE TO MOVE
		 begin
		    current_up_ndown<=next_up_ndown;
		    state<=2'b11;
		    
		 end
	       2'b11://MOVE
		 begin
		    if(!stop_next)
		      begin
			 
		      
			 if(current_up_ndown)
			   begin
			      if(queue_status[current_floor+1])
				begin
				   stop_next<=1;
				end
			      
			   end
			 else if(!current_up_ndown)
			   begin
			      if(queue_status[current_floor-1])
				begin
				   stop_next<=1;
				end
			   end
			 
			 
			 if(time_unit)
			   begin
			      if(current_up_ndown)
				begin
				   current_floor++;	   
				end
			      else
				begin
				   current_floor--;
				   
				end
			   end
		      end // if (!stop_next)
		    else
		      begin
			 state<=2'b10;
			 stop_next<=0;
			 
		      end // else: !if(!stop_next)
		    
		 end
	       2'b10://DISEMBARK
		 begin
		    deassert_floor<=1'b1;
		    
		    if(time_unit)
		      begin
			 if(queue_empty)
			   begin
			      state<=2'b00;
			   end
			 else
			   begin
			      state<=2'b01;
			      
			   end
		      end
		 
		 end
	     endcase
	  end
     end

endmodule // elevator_model

module elevator_direction_resolver;

   logic current_up_ndown;
   logic [6:0] queue_status;
   logic [2:0] current_floor;
   logic       queue_empty;
   logic       next_up_ndown;

   logic       clk;

   int 	       stim_counter = 0;
   
   always_ff@(posedge clk)
     begin
	case(stim_counter)
	  0:
	    begin
	       current_floor<=4;
	       
	    end
	  1:
	    begin
	       queue_status<=7'b1000010;
	    end
	endcase // case (stim_counter)
	
     end

endmodule // elevator_direction_resolver

   

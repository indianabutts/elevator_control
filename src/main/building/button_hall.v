/// Button Panel Module for Hallway Control
// Has Up and Down and Illuminates the Direction when
// Ack is received from the Building Controller
// Will also Exclude the unneccessary button in the
// case of top and bottom floor

module button_hall #(parameter BUTTON_FLOOR=0)(
		   input 	clk,
		   input 	reset,
		   input [1:0] 	button_panel,
		   output 	request_direction_up_ndown,
		   output 	request,
		   output [2:0] calling_floor
);

   logic 			l_direction;
   logic 			l_request;

   assign calling_floor = BUTTON_FLOOR;
   
   
   //Button Panel, Position 0 is Down, 1 is up 
   always_comb
     begin
	case(button_panel)
	  2'b01:
	    begin
	       if(BUTTON_FLOOR>0)
		 begin
		    l_request = 1;
		    l_direction = 0;
		 end
	    end
	  2'b10:
	    begin
	       if(BUTTON_FLOOR<6)
		 begin
		    l_request = 1;
		    l_direction =1;
		 end
	    end
	  default:
	    begin
	       l_request = 0;
	       
	    end
	endcase // case (button_panel)
     end
   
   always_ff@(posedge clk)
     begin
	if(reset)
	  begin
	     request_direction_up_ndown <= 0;
	     request <=0;
	  end
	else
	  begin
	     request_direction_up_ndown<= l_direction;
	     request <= l_request;
	     
	  end
     end

endmodule // button_hall

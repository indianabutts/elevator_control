/// Button Panel Module for Hallway Control
// Has Up and Down and Illuminates the Direction when
// Ack is received from the Building Controller
// Will also Exclude the unneccessary button in the
// case of top and bottom floor

module button_hall_ends #(parameter TOP_NBOTTOM=0)(
		   input  clk,
		   input  reset,
		   input  button,
		   input  ack,
		   output request_direction_up_ndown,
		   output request
);
     assign request_direction_up_ndown = TOP_NBOTTOM;
   always_ff@(posedge button or posedge ack)
     begin
	if(reset)
	  begin
	     
	     request <=0;
	  end
	else if (ack)
	  begin
	     reset<=1'b0;
	  end
	else
	  begin
	     request <= 1'b1;
	  end
     end

endmodule // button_hall_ends

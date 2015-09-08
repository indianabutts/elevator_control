/// Button Panel Module for Hallway Control
// Has Up and Down and Illuminates the Direction when
// Ack is received from the Building Controller
// Will also Exclude the unneccessary button in the
// case of top and bottom floor

module button_hall_mid(
		   input  clk,
		   input  reset,
		   input [1:0] button,
		   input  ack,
		   output request_direction_up_ndown,
		   output request
);

   assign request_direction_up_ndown  = (button[1])?1:0;
  
   always_ff@(posedge button or posedge ack)
     begin
	if(reset)
	  begin
	     request_direction_up_ndown <= 0;
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

endmodule // button_hall_mid

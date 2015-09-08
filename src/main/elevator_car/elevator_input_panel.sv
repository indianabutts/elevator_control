// Elevator Input Panel
// Has Floor Numbers to determine the destination
// Different to Hall Panel which only has Up or Down
// This also reads the Queue Status to illuminate the button
// ※ The button panel will not be Parameterised
`timescale 1ns/1ps
module elevator_input_panel
   (
    input logic 		   clk,
    input logic 		   reset,
    input logic [6:0]  buttons,
    output logic	r_nwr,
    output logic [2:0] 		 requested_floor		  
    );

   logic [2:0] 			   button_panel_to_binary;
   
   always_comb
     begin
	case(buttons)
	  7'h01:
	    begin
	       button_panel_to_binary = 3'b000;
	    end
	  7'h02:
	    begin
	       button_panel_to_binary = 3'b001;
	    end
	  7'h04:
	    begin
	       button_panel_to_binary = 3'b010;
	    end
	  7'h08:
	    begin
	       button_panel_to_binary = 3'b011;
	    end
	  7'h10:
	    begin
	       button_panel_to_binary = 3'b100;
	    end
	  7'h20:
	    begin
	       button_panel_to_binary = 3'b101;
	    end
	  7'h30:
	    begin
	       button_panel_to_binary = 3'b110;
	    end
	endcase // case (buttons)
     end // always_comb
   
   
   always_ff@(posedge clk or posedge reset)
     begin
	if(reset)
	  begin
	requested_floor<=0;
	r_nwr<=0;
	  end
	else
	  begin
	     //If a bitwise OR results in a 1 on a clockedge
	     //it means that a button has been pressed
             r_nwr<=1'b1;
	     if((buttons || 1'b0)=== 1'b1)
	       begin
		  requested_floor<=button_panel_to_binary;
		  r_nwr<=1'b0;
	       end
	  end
     end
   


endmodule // elevator_input_panel

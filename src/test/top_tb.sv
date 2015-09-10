`timescale 1ns/1ps
module top_tb;

   logic clk;
   logic reset;
   logic request;
   logic [1:0] traffic_state;
   logic [2:0] request_floor;
   logic       request_dir;
   int 	       stim_counter = 0;

   logic [2:0] tb_current_floor_1;
   logic [2:0] tb_current_floor_2;
   logic [1:0] tb_state_elev_1;
   logic [1:0] tb_state_elev_2;
   logic       tb_current_dir_1;
   logic       tb_current_dir_2;
   
   logic [6:0] tb_button_panel_1;
   logic [6:0] tb_button_panel_2;
   
   //Signals needed to figure out when the passenger will
   // issue a command from inside the elevator
   assign tb_current_floor_1 = DUT.current_floor_elev_1;
   assign tb_current_floor_2 = DUT.current_floor_elev_2;
   assign tb_state_elev_1 = DUT.ELEVATOR_1.MODEL.state;
   assign tb_state_elev_2 = DUT.ELEVATOR_2.MODEL.state;
   assign tb_current_dir_1 = DUT.current_dir_elev_1;
   assign tb_current_dir_2 - DUT.current_dir_elev_2;
   
   //Force the button panel to select the target destination
   force DUT.ELEVATOR_1.PANEL.buttons = tb_button_panel_1;
   force DUT.ELEVATOR_2.PANEL.buttons = tb_button_panel_2;
   
   
   
   top DUT (.*);

   initial
     begin
	clk=0;
	reset=1;
	#10 reset = 0;
     end
   always #10 clk = !clk;
   always_ff@(posedge clk)
     begin
	request<=0;

	case(stim_counter)
	  0:
	    begin
	       traffic_state<=0;
	    end
	  65:
	    begin
	       request_floor<=3;
	       request_dir<=1;
	       request<=1;
	    end
	  66:
	    begin
	       request_floor<=5;
	       request_dir<=0;
	       request<=1;
	    end
	endcase // case (stim_counter)
	

	stim_counter ++;
	
     end

endmodule // top_tb

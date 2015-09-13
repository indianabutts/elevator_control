`timescale 1ns/1ps   

module simple_top_tb;

   logic clk;
   logic reset;
   logic request;
   logic [1:0] traffic_state;
   logic [2:0] request_floor;
   logic       request_dir;
   int 	       stim_counter = 0;
   
   top DUT (.*);

 // Internal Control Signals
   logic [2:0] tb_current_floor_1;
   logic [2:0] tb_current_floor_2;
   logic [1:0] tb_state_elev_1;
   logic [1:0] tb_state_elev_2;
   logic       tb_current_dir_1;
   logic       tb_current_dir_2;
   logic [6:0] tb_button_panel_1;
   logic [6:0] tb_button_panel_2;
   logic       hallDone ;
   
   //Signals needed to figure out when the passenger will
   // issue a command from inside the elevator
   assign tb_current_floor_1 = DUT.current_floor_elev_1;
   assign tb_current_floor_2 = DUT.current_floor_elev_2;
   assign tb_state_elev_1 = DUT.ELEVATOR_1.MODEL.state;
   assign tb_state_elev_2 = DUT.ELEVATOR_2.MODEL.state;
   assign tb_time_unit_1 = DUT.ELEVATOR_1.MODEL.time_unit;
   assign tb_time_unit_2 = DUT.ELEVATOR_2.MODEL.time_unit;
   
   assign tb_current_dir_1 = DUT.current_dir_elev_1;
   assign tb_current_dir_2 = DUT.current_dir_elev_2;
   
   initial
     begin
	clk=0;
	reset=1;
	#10 reset = 0;
	traffic_state<=0;
	
     end
   always #10 clk = !clk;
   
   always_ff@(posedge clk)
     begin
	request<=0;
	force DUT.ELEVATOR_1.PANEL.buttons = 0;
	if (stim_counter>65 && stim_counter<70)
	  begin
	    if(tb_state_elev_1==0)
	      begin
		 request<=1;
		 request_floor<=2;
		 request_dir<=1;
        
	      end
	  end
	
	     if((tb_current_floor_1 == 2 && tb_state_elev_1 == 0 && tb_current_dir_1 == 1))
	       begin
	          request_floor<=3;
		  request_dir<=1;
		  request<=1;
		  
	       end     

   
	
		case(stim_counter)
	        
		  200:
		    begin
		       request_floor<=2;
		       request_dir<=1;
		       request<=1;
		    end
		  201:
		    begin
		       request_floor<=3;
		       request_dir<=1;
		       request<=1;
		    end
		  202:
		    begin
		       request_floor<=5;
		       request_dir<=0;
		       request<=1;
		    end
		  203:
		    begin
		       request_floor<=4;
		       request_dir<=0;
		       request<=1;
		    end
		endcase // case (stim_counter)
	

	stim_counter ++;
	
     end

endmodule // top_tb

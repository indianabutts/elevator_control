`timescale 1ns/1ps
import passenger::request;
import passenger::request_type;
import passenger::traffic_type;

module top_tb;

   //Control Signals
   logic clk;
   logic reset;
   logic request;
   logic [1:0] traffic_state;
   logic [2:0] request_floor;
   logic       request_dir;

   // Internal Control Signals
   logic [2:0] tb_current_floor_1;
   logic [2:0] tb_current_floor_2;
   logic [1:0] tb_state_elev_1;
   logic [1:0] tb_state_elev_2;
   logic       tb_current_dir_1;
   logic       tb_current_dir_2;
   logic [6:0] tb_button_panel_1;
   logic [6:0] tb_button_panel_2;
   
   //Simulation Parameters
   int 	       stim_counter = 0;
   int 	       request_count=100;
   int 	       traffic_type_counter;
   
   
  
   passenger::request hall_queue[$:99] = {};
   passenger::request elev_1_queue[$:99] = {} ;
   passenger::request elev_2_queue[$:99] = {};

    
   	passenger::request temp_request;
   	traffic_type traffics;
   //Signals needed to figure out when the passenger will
   // issue a command from inside the elevator
   assign tb_current_floor_1 = DUT.current_floor_elev_1;
   assign tb_current_floor_2 = DUT.current_floor_elev_2;
   assign tb_state_elev_1 = DUT.ELEVATOR_1.MODEL.state;
   assign tb_state_elev_2 = DUT.ELEVATOR_2.MODEL.state;
   assign tb_current_dir_1 = DUT.current_dir_elev_1;
   assign tb_current_dir_2 = DUT.current_dir_elev_2;
   
   //Force the button panel to select the target destination
  // force DUT.ELEVATOR_1.PANEL.buttons = tb_button_panel_1;
   //force DUT.ELEVATOR_2.PANEL.buttons = tb_button_panel_2;

   

   //http://www.asicguru.com/system-verilog/sv-classes/simple-class/90/
   
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

	if (hall_queue.size() < 10)
	  begin
	     	traffics =  traffics.first();
	     for (int i = hall_queue.size() ; i < 10; i ++) 
	       begin
		 temp_request = new(traffics);
		  temp_request.randomize();
	         temp_request.setDirection();
		 hall_queue.push_front(temp_request);
	       end
	     
	  end
	
     end

endmodule // top_tb

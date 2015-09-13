`timescale 1ns/1ps

module top_tb;
   //import passenger_pkg::*;
   import passenger_pkg::request_class;
   import passenger_pkg::request_type;
   import passenger_pkg::traffic_type;
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
   logic       tb_time_unit_1;
   logic       tb_time_unit_2;
   
   logic       tb_current_dir_1;
   logic       tb_current_dir_2;
   logic [6:0] tb_button_panel_1;
   logic [6:0] tb_button_panel_2;
   
   //Simulation Parameters
   int 	       stim_counter;
   int 	       request_count=100;
   int 	       traffic_type_counter;`timescale 1ns/1ps

     module top_tb;
   //import passenger_pkg::*;
   import passenger_pkg::request_class;
   import passenger_pkg::request_type;
   import passenger_pkg::traffic_type;
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
   
   
   

   request_class hall_queue[$:99] = {};
   request_class elev_1_queue[$:99] = {} ;
   request_class elev_2_queue[$:99] = {};

   
   request_class temp_request;
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
   request_class initial_queue[$:299] = {};
   request_class elev_1_queue[$:99] = {} ;
   request_class elev_2_queue[$:99] = {};
   request_class hall_queue[$:99]=  {};
   
   request_class current_request;
   
   request_class temp_request;
   traffic_type traffics;
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
   //http://www.asicguru.com/system-verilog/sv-classes/simple-class/90/
   
   top DUT (.*);

   initial
     begin
	clk=0;
	reset=1;
	#10 reset = 0;

	initial_queue = {};
	
	for(int j=0;j<3;j++)
	  begin
	     for (int i = 0 ; i < 100; i ++) 
	       begin
		  temp_request = new(traffics);
		  temp_request.randomize();
		  temp_request.setDirection();
		  initial_queue.push_front(temp_request);
	       end
	     traffics =  traffics.next();
	  end
     end
   always #10 clk = !clk;

   logic elev_1_ready;
   logic elev_2_ready;

   always_ff@(posedge tb_time_unit_1 or posedge tb_time_unit_2)
     begin
	request_class temp_queue [$] = {};
	
	if(initial_queue.size()>0)
	  begin	     
	     current_request = initial_queue.pop_front();
	     request<=1;
	     request_dir<=current_request.request_direction;
	     request_floor <= current_request.start_floor;
	     hall_queue.push_front(current_request);
	     $display("Request from Floor %d",request_floor);
	  end

	for(int i = 0;i<hall_queue.size();i++)
	  begin
	     elev_1_ready =(hall_queue[i].start_floor == tb_current_floor_1) & (hall_queue[i].request_direction == tb_current_dir_1
										);
	     elev_2_ready =(hall_queue[i].start_floor == tb_current_floor_2) & (hall_queue[i].request_direction == tb_current_dir_2
										);
	     if(elev_1_ready)
	       begin
		  $display("Passenger in Elevator 1 going to floor",hall_queue[i].request_floor);
		  force DUT.ELEVATOR_1.PANEL.buttons[hall_queue[i].request_floor] = 1;
		  elev_1_queue.push_front(hall_queue[i]);
		  hall_queue.delete(i);
		  
	       end
	     else if(elev_2_ready)
	       begin
		  $display("Passenger in Elevator 2 going to floor",hall_queue[i].request_floor);
		  force DUT.ELEVATOR_2.PANEL.buttons[hall_queue[i].request_floor] = 1;
		  elev_2_queue.push_front(hall_queue[i]);
		  hall_queue.delete(i);  
	       end
	  end
	if(initial_queue.size()==0)
	  $finish;
	
     end


endmodule // top_tb

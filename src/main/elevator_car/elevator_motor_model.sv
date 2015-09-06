// Elevator Motor Model
// This model simulates the motor of the Elevator as well
// containing the control logic of the motor.
// Will return to a default floor as defined by the DEFAULT field in
// the Status and Control Registers of the Elevator Car when the Queue is Empty

`timescale 1ns/1ps
module elevator_motor_model(
			    input logic 		  clk,
			    input logic 		  reset,
			    input logic [2:0] 		  default_floor,
			    input logic [FLOOR_COUNT-1:0] queue_status,
			    output logic 		  up_ndown,
			    output logic 		  moving,
			    output logic [2:0] 		  current_floor
			    );



   logic [2:0] 						  local_current_floor;
   logic 						  local_up_ndown;
   logic 						  local_moving;
   
   logic [2:0] 						  target_floor;
   logic [19:0] 					  clock_divider;
   
   logic 						  clk_1_hz;
   logic [2:0]						  motor_delay_counter;
   
   assign current_floor = local_current_floor;
   assign up_ndown = local_up_ndown;
   assign moving = local_moving;
   

   
   always_ff @ (posedge clk or posedge reset)
     begin
	if (reset)
	  begin
	     local_current_floor <= 2'b00;
	     local_up_ndown<=1'b1;
	     local_moving<=1'b0;
	  end
	else
	  begin
	     if ((queue_status || 1'b1)===1'b0)
	       begin
		  local_moving <= 1'b0;
	       end
	     else
	       begin
		  
		
	       end
	  end
     end // always_ff @


  
   always_ff @(posedge clk or posedge reset)
     begin
	if(reset)
	  begin
	     clk_divider<=20'h00000;
	     clk_1_hz<=0;
	  end
	else
	  begin
	     if(clk_divider<1000000)
	       begin
		  clk_divider++;
	       end
	     else
	       begin
		  clk_1_hz<=!clk_1_hz;
		  clk_divider<=20'h00000;
		  
	       end
	  end
     end
  
   always_ff@(posedge clock_1_hz or posedge reset)
     begin
	if(reset)
	  begin
	     motor_delay_counter<=0;
	  end
	else
	  begin
	     if(local_moving & local_up_ndown & (motor_delay_counter===4))
	       begin
		  local_current_floor++;
	       end
	     if(local_moving & !local_up_ndown & (motor_delay_counter===4))
	       begin
		  local_current_floor--;
	       end
	  end
     end
   

endmodule // elevator_motor_model

   

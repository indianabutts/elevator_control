`timescale 1ns/1ps
module elevator_queue_tb;

   parameter p_FLOOR_COUNT = 7;

   logic clk;
   logic reset;
   logic r_nwr;
   logic deassert_floor;
   logic [2:0] requested_floor;
   logic [p_FLOOR_COUNT-1:0] queue_status;
   logic [7:0] 		     button_panel_light;
   logic [7:0] 		     buttons;
   
   elevator_queue #(.FLOOR_COUNT(p_FLOOR_COUNT)) QUEUE 
     (.*);
   
   
   elevator_input_panel PANEL
     (.*);
   
   //Set the initial conditions for the testbench
   initial
     begin
	$display("Simulation Started");
	clk = 1'b0;
	reset = 1'b1;
     end
   
   always #10 clk = ~clk; // generate a clock
       
   int stim_counter=0;

   always@(posedge clk)
     begin
	r_nwr<=1'b1;
        deassert_floor<=1'b0;
	reset<=1'b0;
	case(stim_counter)
	  3:
	    begin
               r_nwr<=1'b0;
	       requested_floor<=3'b010;
	    end
	  4:
	    begin
               r_nwr<=1'b0;
	       requested_floor<=3'b011;
	    end
	  6:
	    begin
	       r_nwr<=0;
	       deassert_floor<=1'b1;
	       requested_floor<=3'b010;
	    end	  
	endcase
	stim_counter<=stim_counter+1;
     end
   
endmodule // elevator_queue_tb

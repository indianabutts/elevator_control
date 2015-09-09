`timescale 1ns/1ps

module top(
	   input logic 	     clk,
	   input logic 	     reset,
	   input logic 	     request,
	   input logic [1:0] traffic_state,
	   input logic [2:0] request_floor,
	   input logic 	     request_dir
);

   logic        current_dir_elev_1;
   logic        current_dir_elev_2;
   logic [2:0]  current_floor_elev_1;
   logic [2:0]  current_floor_elev_2;
   logic [1:0] 	dispatch_elev;
   logic [2:0] 	default_floor_1;
   logic [2:0] 	default_floor_2;
   
   logic 	r_nwr_1;
   logic 	r_nwr_2;

   always_comb
     begin
	case(traffic_state)
	  default:
	    begin //DOWNPEAK AND NORMAL
	       // Both share the same since, regardless
	       // Of the volume of people leaving,
	       // The Lobby floor has the highest probability
	       // of call, so there should alwyas be an elevator parked.
	       default_floor_1 = 0;
	       default_floor_2 = 6;
	       
	    end
	  2'b01: //UP PEAK
	    begin
	       default_floor_1 = 0;
	       default_floor_2 = 0;
	    end
	endcase // case (traffic_state)
	
     end
   
   assign r_nwr_1 = (dispatch_elev[0]===1'b1) & request===1'b1;
   assign r_nwr_2 = (dispatch_elev[1]===1'b1) & request===1'b1;
   
   building_dispatcher DISPATCH(.*);
   
   elevator_top ELEVATOR_1(
			     .clk(clk),
			     .reset(reset),
			     .hall_r_nwr(r_nwr_1),
			     .default_floor(default_floor_1),
			     .hall_request_floor(hall_request_floor),
			     .current_dir_out(current_dir_elev_1),
			     .current_floor_out(current_floor_elev_1)
			     );
   
   elevator_top ELEVATOR_2(
			     .clk(clk),
			     .reset(reset),
			     .hall_r_nwr(r_nwr_2),
			     .default_floor(default_floor_2),
			     .hall_request_floor(hall_request_floor),		
			     .current_dir_out(current_dir_elev_2),
			     .current_floor_out(current_floor_elev_2)
			     );    

endmodule // top

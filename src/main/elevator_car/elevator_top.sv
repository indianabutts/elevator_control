module elevator_top(
		    input logic       clk,
		    input logic       time_unit,
		    input logic       reset,
		    input logic       hall_r_nwr,
		    input logic [2:0] default_floor,
		    input logic [2:0] hall_request_floor,
		    output 	      queue_empty_out,
		    output [6:0]      queue_status_out
);

   logic [6:0] 			      buttons;
   logic 			      r_nwr;
   logic 			      requested_floor;
   logic 			      current_up_ndown;
   logic 			      next_up_ndown;
   logic 			      queue_empty;
   logic [6:0] 			      queue_status;
   logic [2:0] 			      current_floor;
   logic 			      deassert_floor;

   logic 			      muxed_r_nwr;
   logic [2:0] 			      muxed_req_floor;

   assign muxed_r_nwr = (hall_r_nwr != r_nwr) ? 1'b1:r_nwr;
   assign muxed_req_floor = (hall_r_nwr) ? hall_request_floor : requested_floor;
   
   assign queue_status_out = queue_status;
   assign queue_empty_out = queue_empty;
 
   
   elevator_model MODEL (.*);
   
   elevator_input_panel PANEL (.*);

   
   
   elevator_queue QUEUE (
			 .clk(clk),
			 .reset(reset),
			 .r_nwr(muxed_r_nwr),
			 .deassert_floor(deassert_floor),
			 .requested_floor(muxed_req_floor),
			 .queue_status(queue_status)
			 );
   
   elevator_direction_resolver DIR_RESOLVE (.*);
   
   

endmodule // elevator_top

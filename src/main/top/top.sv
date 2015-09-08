

module top(
	   input logic 	     clk,
	   input logic 	     reset,
	   input logic 	     request,
	   input logic [2:0] request_floor,
	   input logic 	     request_dir
);

   logic        current_dir_elev_1;
   logic        current_dir_elev_2;
   logic [2:0]  current_floor_elev_1;
   logic [2:0]  current_floor_elev_2;
   logic [1:0] 	dispatch_elev;

   logic 	r_nwr_1;
   logic 	r_nwr_2;

   assign r_nwr_1 = (dispatch_elev[0]===1'b1) & request===1'b1;
   assign r_nwr_2 = (dispatch_elev[1]===1'b1) & request===1'b1;
   
   buidling_dispatcher DISPATCH(.*);
   
   elevator_model ELEVATOR_1(
			     .clk(clk),
			     .reset(reset),
			     .hall_r_nwr(r_nwr_1),
			     .default_floor(default_floor),
			     .hall_request_floor(hall_request_floor),
			     .queue_empty_out(queue_empty),
			     .current_dir_out(current_dir_elev_1),
			     .current_floor_out(current_floor_elev_1)
			     );
   
   elevator_model ELEVATOR_2(
			     .clk(clk),
			     .reset(reset),
			     .hall_r_nwr(r_nwr_2),
			     .default_floor(default_floor),
			     .hall_request_floor(hall_request_floor),
			     .queue_empty_out(queue_empty),
			     .current_dir_out(current_dir_elev_1),
			     .current_floor_out(current_floor_elev_1)
			     );    


endmodule // top

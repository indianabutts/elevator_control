module elevator_top(
		    input logic        clk,
		    input logic        reset,
		    input logic        hall_r_nwr,
		    input logic [2:0]  default_floor,
		    input logic [2:0]  hall_request_floor,
		    output logic       current_dir_out,
		    output logic [2:0] current_floor_out
);

   logic [6:0] 			      buttons;
   logic 			      r_nwr;
   logic [2:0] 			      requested_floor;
   logic 			      current_up_ndown;
   logic 			      next_up_ndown;
   logic 			      queue_empty;
   logic [6:0] 			      queue_status;
   logic [2:0] 			      current_floor;
   logic 			      deassert_floor;

   logic 			      muxed_r_nwr;
   logic [2:0] 			      muxed_req_floor;
  
   assign current_dir_out = current_up_ndown;
   assign current_floor_out = current_floor;

    always_comb
     begin
	if(deassert_floor)
	  begin
	     muxed_r_nwr=1'b0;
	  end
	else 
	  begin
	      muxed_r_nwr = (hall_r_nwr ===1'b0) ? 1'b0:r_nwr;
	  end
     end


   //TODO CHECK INDEXING OF FLOORS AND QUEUING
   
   always_comb
     begin
	if(deassert_floor)
	  begin
	     muxed_req_floor= current_floor;
	  end
	else 
	  begin
	     muxed_req_floor = (hall_r_nwr===1'b0) ? hall_request_floor : requested_floor;
	  end
     end
   
   
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

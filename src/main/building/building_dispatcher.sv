/// Building Controller
/// Handles the inputs from the Hallway buttons
/// and determines the best of the two elevators to
/// dispatch the request to
`timescale 1ns/1ps
module building_dispatcher (
			    input logic        current_dir_elev_1,
			    input logic        current_dir_elev_2,
			    input logic [2:0]  current_floor_elev_1,
			    input logic [2:0]  current_floor_elev_2,
			    input logic [2:0]  request_floor,
			    input logic        request_dir,
			    output logic [1:0] dispatch_elev
			    );

   logic 				       relative_elev_1;
   logic 				       relative_elev_2;
   logic 				       candidate_dispatch_elev_1;
   logic 				       candidate_dispatch_elev_2;
   
   logic [3:0] 				       signed_elev_1_distance;
   logic [3:0]				       signed_elev_2_distance;
   logic [3:0] 				       abs_elev_1_distance;
   logic [3:0]				       abs_elev_2_distance;

   assign signed_elev_1_distance = request_floor-current_floor_elev_1;
   assign signed_elev_2_distance = request_floor-current_floor_elev_2;

   assign abs_elev_1_distance = (signed_elev_1_distance[3]===1'b1)? -signed_elev_1_distance:signed_elev_1_distance;

   assign abs_elev_2_distance = (signed_elev_2_distance[3]===1'b1)? -signed_elev_2_distance:signed_elev_2_distance;
   
   
   assign candidate_dispatch_elev_1 = (relative_elev_1===1 & (request_dir === current_dir_elev_1));
   assign candidate_dispatch_elev_2 = (relative_elev_2===1 & (request_dir === current_dir_elev_2)); 

   assign relative_elev_1 = ((current_floor_elev_1<request_floor) === current_dir_elev_1);
   assign relative_elev_2 = ((current_floor_elev_2<request_floor) === current_dir_elev_2);
   

	   always_comb
     begin
	if(candidate_dispatch_elev_1 === candidate_dispatch_elev_2)
	  begin
	     if(abs_elev_1_distance<abs_elev_2_distance)
	       begin
		  dispatch_elev=2'b01;
	       end
	     else
	       begin
		  dispatch_elev=2'b10;
	       end
	  end

	else
	  begin
	     dispatch_elev={candidate_dispatch_elev_2,candidate_dispatch_elev_1};
	  end
     end 
   
endmodule

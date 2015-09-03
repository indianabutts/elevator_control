/// Building Controller
/// Handles the inputs from the Hallway buttons
/// and determines the best of the two elevators to
/// dispatch the request to

module building_controller (
   //Input Names
   clk,
   reset,
   hall_request,
   car_status,
   //Output names
   request_ack
   );

   parameter ELEVATOR_COUNT = 2;
   parameter FLOOR_COUNT = 7;
   //IO Definitions
   input clk;
   input reset;
   //    Dir    Floor
   //     3     2 1 0
   // [up_ndown| | | ]
   input [0][3:0] hall_request;
   
   input car_status;
   output [0]request_ack;

   

endmodule

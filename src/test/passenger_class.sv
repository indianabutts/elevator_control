package passenger;
   typedef enum {GOING_UP,GOING_DOWN,INTEROFFICE} request_type;
}
class request;
   
   //Properties of the Passenger Class
   rand request_type type;
   rand int start_floor;
   rand int request_floor;
   rand bit request_direction;
   
   // Constraints on the Properties

   constraint c
   
   
endclass; // request


endpackage // passenger
   

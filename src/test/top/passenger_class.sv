package passenger;
   typedef enum {GOING_UP,GOING_DOWN,INTER} request_type;
   typedef enum {MORNING, LUNCH, NORMAL} traffic_type;
   
class request;
   
   //Properties of the Passenger Class
   rand int id;
   
   rand request_type req_kind;
   traffic_type traffic_kind;
   rand int start_floor;
   rand int request_floor;
   bit request_direction;
   time start_time;
   
   // Constraints on the Properties

   constraint starting_floor_constraint {
      (req_kind == GOING_UP) -> start_floor inside {0};
      (req_kind == GOING_DOWN) -> start_floor inside {1,2,3,4,5,6};
      (req_kind == INTER) -> start_floor inside {1,2,3,4,5,6};
   }
   constraint request_floor_constraint {
      (req_kind == GOING_UP) -> request_floor inside {1,2,3,4,5,6};
      (req_kind == GOING_DOWN) -> request_floor inside {0};
      (req_kind == INTER) -> start_floor inside {1,2,3,4,5,6};
   }
   constraint request_floor_not_start_constraint{
      request_floor!=start_floor;
   }
   constraint request_dist {
      (traffic_kind == MORNING) -> req_kind dist {GOING_UP :=9, GOING_DOWN :=0, INTER :=1};
      (traffic_kind == LUNCH) -> req_kind dist {GOING_UP :=2, GOING_DOWN :=7, INTER :=1};
      (traffic_kind == NORMAL) -> req_kind dist {GOING_UP :=2, GOING_DOWN := 2, INTER :=6};
   }

   function new(traffic_type kind);
      
      traffic_kind = kind;
      request_direction = (request_floor<start_floor)? 0:1;
      start_time = $time;
      
   endfunction // new
   
   function void setDirection();
      request_direction = (request_floor<start_floor)? 0:1;
      if(request_direction)
	begin
	   $display("Passenger [%d] Calling from Floor %d, Going Up to Floor %d", id, start_floor, request_floor);
	end
      else
	begin
	   $display("Passenger [%d] Calling from Floor %d, Going Down to Floor %d", id,start_floor,request_floor);
	end
   endfunction // setDirection
   
   
endclass // request


endpackage // passenger
   

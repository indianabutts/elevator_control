

module building_dispatcher_tb;


   logic        current_dir_elev_1;   
   logic        current_dir_elev_2;  
   logic [2:0] 	current_floor_elev_1;  
   logic [2:0] 	current_floor_elev_2;  
   logic [2:0] request_floor;
   logic       request_dir;
   logic       dispatch_elev_1;
   logic       dispatch_elev_2;
   
   building_dispatcher DUT (.*);

    //Set the initial conditions for the testbench
   initial
     begin
	$display("Simulation Started");
	clk = 1'b0;
     end
   
   always #10 clk = ~clk; // generate a clock

   int  rel_elev_1_diff;
   int 	rel_elev_2_diff;

   assign rel_elev_1_diff = (current_floor_elev_1<request_floor);
   assign rel_elev_2_diff = (current_floor_elev_2<request_floor);
   
   
   always_ff@(posedge clk)
     begin
	
	case(stim_counter)
	  0:
	    begin  
	       current_dir_elev_1<=0;
	       current_dir_elev_2<=0;
	       current_floor_elev_1<=0;
	       current_floor_elev_2<=0;
	       request_floor<=0;
	       request_dir<=0;
	    end
	  default:
	    begin
	       {current_floor_elev_1,current_floor_elev_2,request_floor,request_dir,current_dir_elev_1,current_dir_elev_2}++;
	       
	    end
	  endcase // case (stim_counter)
	
	stim_counter++;
	if(stim_counter==6)
	  begin
	     stim_counter<=1;
	  end	
	
     end
   

endmodule // building_dispatcher_tb

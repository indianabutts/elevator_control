module elevator_direction_resolver_tb;

   logic current_up_ndown;
   logic [6:0] queue_status;
   logic [2:0] current_floor;
   logic       queue_empty;
   logic       next_up_ndown;

   int 	       stim_counter = 0;
   
   elevator_direction_resolver DIR_DUT (.*);

   //Set the initial conditions for the testbench
   initial
     begin
	$display("Simulation Started");
	clk = 1'b0;
     end
   
   always #10 clk = ~clk; // generate a clock
   
   //8 main test cases based on the truth table
   // with | current | l_up | l_down | as the inputs
   
   always_ff@(posedge clk)
     begin
	
	case(stim_counter)
	  0:
	    begin
	       
	       queue_status<=7'b0000000;
	       current_floor<=4;
	       current_up_ndown<=0;
	    end
	  1:
	    begin
	       queue_status<=7'b0000000;
	    end
	  2:
	    begin 
	       
	       queue_status<=7'b0000011;
	    end
	  3:
	    begin 
	       queue_status<=7'b1100000;
	    end	
	  4:
	    begin 
	       queue_status<=7'b1100011;
	    end		
	  5:
	    begin 	       
	       queue_status<=7'b0000000;
	       current_up_ndown<=1;
	    end	
	endcase // case (stim_counter)
	stim_counter++;
	if(stim_counter==6)
	  begin
	     stim_counter<=1;
	  end	
	
     end
   
endmodule // elevator_direction_resolver

   

`timescale 1ns/1ps
module building_dispatcher_tb;
	logic        current_dir_elev_1;
	logic        current_dir_elev_2;  
	logic [2:0] 	current_floor_elev_1;  
	logic [2:0] 	current_floor_elev_2;  
	logic [2:0] 	request_floor;
	logic 	request_dir;
	logic [1:0] 	dispatch_elev;
	int 		expected_dispatch = 0;
	logic 	clk;
	int 		stim_counter = 0;
	building_dispatcher DUT (.*);

	//Set the initial conditions for the testbench
	initial
		begin
			$display("Simulation Started");
			clk = 1'b0;
		end    
	always #10 clk = ~clk; // generate a clock
	int pass_vectors = 0;

	always_ff@(posedge clk)
		begin
			case(stim_counter)
				1:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				2:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				3:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				4:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				5:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				6:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				7:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				8:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				9:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				10:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				11:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				12:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				13:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				14:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				15:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				16:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				17:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 3; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				18:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				19:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 3; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				20:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				21:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 3; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				22:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				23:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 3; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				24:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				25:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 3; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				26:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				27:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 3; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				28:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				29:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 3; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				30:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				31:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 6; 
 						current_floor_elev_2 <= 3; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				32:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 5; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				33:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				34:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 3; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				35:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				36:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 3; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				37:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				38:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 3; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				39:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				40:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 3; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				41:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				42:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 3; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				43:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				44:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 3; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				45:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				46:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 3; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				47:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 5; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				48:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 3; 
 						current_floor_elev_2 <= 6; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				49:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 2; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				50:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 2; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				51:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 2; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				52:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 2; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				53:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 2; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				54:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 2; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				55:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 2; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				56:
					begin
 						current_dir_elev_1 <= 0; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 2; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				57:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 2; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				58:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 2; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				59:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 2; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				60:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 0; 
 						current_floor_elev_1 <= 2; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
				61:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 2; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=2;
					end
				62:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 2; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 0; 
 						expected_dispatch<=1;
					end
				63:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 1; 
 						current_floor_elev_2 <= 2; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=2;
					end
				64:
					begin
 						current_dir_elev_1 <= 1; 
 						current_dir_elev_2 <= 1; 
 						current_floor_elev_1 <= 2; 
 						current_floor_elev_2 <= 1; 
 						request_floor<= 4; 
 						request_dir <= 1; 
 						expected_dispatch<=1;
					end
			endcase // case (stim_counter)
			if(stim_counter === 66)
				begin
					assert(stim_counter!=66) else $error("END OF SIM : "+ pass_vectors +" OF 64 Passed") ;
				end
			stim_counter++;
		end

	always_ff@(posedge clk)
		begin
			if(stim_counter>1)
				begin
					assert(dispatch_elev === expected_dispatch)
					begin
						pass_vectors++;
					end
			else
				begin
					//$warning("CASE FAILED, Expected ["+expected_dispatch+"] But Got ["+dispatch_elev+"]");
				end
			end
		end

endmodule // building_dispatcher_tb
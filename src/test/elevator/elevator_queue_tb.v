`timescale 1ns/1ps
module elevator_queue_tb;

   parameter p_FLOOR_COUNT = 7;
   
   reg clk;
   reg reset;
   reg r_nwr;
   reg clear_bit;
   wire [p_FLOOR_COUNT-1:0] queue_data;


     elevator_queue #(.FLOOR_COUNT(p_FLOOR_COUNT)) DUT (
    .clk(clk),
    .reset(reset),
    .r_nwr(r_nwr),
    .clear_bit(clear_bit),
    .queue_data(queue_data)
  );

   //Set the initial conditions for the testbench
   initial 
     begin
	$display("Simulation Started");	
	clk = 1'b0;
	reset = 1'b1;
     end

    always #10 clk = ~clk; // generate a clock


   //reg[255:0] stim_counter=0;
   
  // always@(posedge clk)
  //   begin
  //	if(stim_counter === 25)
  //	  begin
  //	     $finish;
  //	  end
  //	stim_counter<=stim_counter+1;
  //   end
  




endmodule // elevator_queue_tb

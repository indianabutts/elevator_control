import csv, sys, getopt
out_f = open('building_dispatcher_tb.sv','w')
output = "`timescale 1ns/1ps\n"
output += "module building_dispatcher_tb;\n"
output += "   logic        current_dir_elev_1;\n"
output += "   logic        current_dir_elev_2;  \n"
output += "   logic [2:0] 	current_floor_elev_1;  \n"
output += "   logic [2:0] 	current_floor_elev_2;  \n"
output += "   logic [2:0] 	request_floor;\n"
output += "   logic 	request_dir;\n"
output += "   logic [1:0] 	dispatch_elev;\n"
output += "   int 		expected_dispatch = 0;\n"
output += "   logic 	clk;\n"
output += "   int 		stim_counter = 0;\n"
output += "   building_dispatcher DUT (.*);\n\n"
output += "   //Set the initial conditions for the testbench\n"
output += "   initial\n"
output += "      begin\n"
output += "         $display(\"Simulation Started\");\n"
output += "         clk = 1'b0;\n"
output += "      end    \n"
output += "   always #10 clk = ~clk; // generate a clock\n"
output += "   int pass_vectors = 0;\n\n"
output += "   always_ff@(posedge clk)\n"
output += "      begin\n"
output += "         case(stim_counter)\n"
output += "            0:\n"
output += "               begin\n"
output += "                  current_dir_elev_1 =1'b0;\n"
output += "                  current_dir_elev_2 =1'b0;\n"
output += "                  current_floor_elev_1 =0;\n"
output += "                  current_floor_elev_2 =0;\n"
output += "                  request_floor = 4;\n"
output += "                  request_dir = 1'b0;\n"
output += "                  expected_dispatch=2;\n"
output += "               end\n"
i=1;
with open('test.csv', 'rb') as csvfile:
    testcases = csv.reader(csvfile, delimiter=',', quotechar='|')
    for row in testcases:
          #Floor 1	Floor 2	Current Floor 1 < Request Floor	Current Floor 2 < Request Floor	Current Direction 1	Current Direction 2	Request Direction	Final
       req_floor = int(4)
       floor_1 = int(row[0])
       floor_2 = int(row[1])
       dir_1 = int(row[4])
       dir_2 = int(row[5])
       r_dir = int(row[6])
       dispatch = int(row[7])

       output += ("            %i:\n               begin\n                   current_dir_elev_1 <= %i; \n                   current_dir_elev_2 <= %i; \n                   current_floor_elev_1 <= %i; \n                   current_floor_elev_2 <= %i; \n                   request_floor<= 4; \n                   request_dir <= %i; \n                   expected_dispatch<=%i;\n               end\n" % (i,dir_1,dir_2,floor_1,floor_2,r_dir,dispatch))
       i = i + 1

output +="         endcase // case (stim_counter)\n"
output +="         if(stim_counter === %i)\n"%(i)
output +="            begin\n"
output +="               assert(stim_counter!=65) else $error(\"END OF SIM : %d OF %d Passed\",pass_vectors,stim_counter-1) ;"
output +="            end\n"
output +="         stim_counter++;\n"
output +="      end\n\n"

output +="   always_ff@(posedge clk)\n"
output +="      begin\n"
output +="         if(stim_counter>1)\n"
output +="            begin\n"
output +="               assert(dispatch_elev === expected_dispatch)\n"
output +="                  begin\n"
output +="                     pass_vectors++;\n"
output +="                  end\n"
output +="               else\n"
output +="                  begin\n"
output +="                   $warning(\"CASE[%d] FAILED, Expected [%d] But Got [%d]\",stim_counter,expected_dispatch,dispatch_elev );\n"
output +="               end\n"
output +="         end\n"
output +="      end\n\n"
output +="endmodule // building_dispatcher_tb"

out_f.write(output) # python will convert \n to os.linesep
out_f.close() # y

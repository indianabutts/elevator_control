import csv, sys, getopt
with open('test.csv', 'rb') as csvfile:
     spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
     i=1;
     out_f = open('building_dispatcher_tb.sv','w')
     output = "`timescale 1ns/1ps\n"
     output += "module building_dispatcher_tb;\n"
     output += "\tlogic        current_dir_elev_1;\n"
     output += "\tlogic        current_dir_elev_2;  \n"
     output += "\tlogic [2:0] 	current_floor_elev_1;  \n"
     output += "\tlogic [2:0] 	current_floor_elev_2;  \n"
     output += "\tlogic [2:0] 	request_floor;\n"
     output += "\tlogic 	request_dir;\n"
     output += "\tlogic [1:0] 	dispatch_elev;\n"
     output += "\tint 		expected_dispatch = 0;\n"
     output += "\tlogic 	clk;\n"
     output += "\tint 		stim_counter = 0;\n"
     output += "\tbuilding_dispatcher DUT (.*);\n\n"
     output += "\t//Set the initial conditions for the testbench\n"
     output += "\tinitial\n"
     output += "\t\tbegin\n"
     output += "\t\t\t$display(\"Simulation Started\");\n"
     output += "\t\t\tclk = 1'b0;\n"
     output += "\t\tend    \n"
     output += "\talways #10 clk = ~clk; // generate a clock\n"
     output += "\tint pass_vectors = 0;\n\n"
     output += "\talways_ff@(posedge clk)\n"
     output += "\t\tbegin\n"
     output += "\t\t\tcase(stim_counter)\n"
     for row in spamreader:
          #Floor 1	Floor 2	Current Floor 1 < Request Floor	Current Floor 2 < Request Floor	Current Direction 1	Current Direction 2	Request Direction	Final
         req_floor = int(4)
         floor_1 = int(row[0])
         floor_2 = int(row[1])
         dir_1 = int(row[4])
         dir_2 = int(row[5])
         r_dir = int(row[6])
         dispatch = int(row[7])

         output += ("\t\t\t\t%i:\n\t\t\t\t\tbegin\n \t\t\t\t\t\tcurrent_dir_elev_1 <= %i; \n \t\t\t\t\t\tcurrent_dir_elev_2 <= %i; \n \t\t\t\t\t\tcurrent_floor_elev_1 <= %i; \n \t\t\t\t\t\tcurrent_floor_elev_2 <= %i; \n \t\t\t\t\t\trequest_floor<= 4; \n \t\t\t\t\t\trequest_dir <= %i; \n \t\t\t\t\t\texpected_dispatch<=%i;\n\t\t\t\t\tend\n" % (i,dir_1,dir_2,floor_1,floor_2,r_dir,dispatch))
         i = i + 1
         output +="\t\t\tendcase // case (stim_counter)\n"
         output +="\t\t\tif(stim_counter === 66)\n"
         output +="\t\t\t\tbegin\n"
         output +="\t\t\t\t\tassert(stim_counter!=66) else $error(\"END OF SIM : \"+ pass_vectors +\" OF %i Passed\") ;\n" % (i-1)
         output +="\t\t\t\tend\n"
         output +="\t\t\tstim_counter++;\n"
         output +="\t\tend\n\n"

     output +="\talways_ff@(posedge clk)\n"
     output +="\t\tbegin\n"
     output +="\t\t\tif(stim_counter>1)\n"
     output +="\t\t\t\tbegin\n"
     output +="\t\t\t\t\tassert(dispatch_elev === expected_dispatch)\n"
     output +="\t\t\t\t\tbegin\n"
     output +="\t\t\t\t\t\tpass_vectors++;\n"
     output +="\t\t\t\t\tend\n"
     output +="\t\t\telse\n"
     output +="\t\t\t\tbegin\n"
     output +="\t\t\t\t\t//$warning(\"CASE FAILED, Expected [\"+expected_dispatch+\"] But Got [\"+dispatch_elev+\"]\");\n"
     output +="\t\t\t\tend\n"
     output +="\t\t\tend\n"
     output +="\t\tend\n\n"
     output +="endmodule // building_dispatcher_tb"

out_f.write(output) # python will convert \n to os.linesep
out_f.close() # y

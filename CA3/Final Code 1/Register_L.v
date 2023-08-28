module Register_L #(parameter n=32)(clk,data_in,load,data_out);
	input clk,load;
	input [n-1:0] data_in;
	output reg [n-1:0] data_out;
    	always@(posedge clk)
        	if(load)
            		data_out <= data_in;
	initial begin 
		data_out = 32'd0;
	end
endmodule


module Register #(parameter n=32)(clk,data_in,data_out);
	input clk;
	input [n-1:0] data_in;
	output reg [n-1:0] data_out;
    	always@(posedge clk)
        	data_out <= data_in;
endmodule

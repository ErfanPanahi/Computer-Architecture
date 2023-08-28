module PC (clk , next_PC , out_PC);
	input clk;
	input [31:0] next_PC;
	output reg[31:0] out_PC;

	always@(posedge clk) begin 
		out_PC <= next_PC;
	end
endmodule
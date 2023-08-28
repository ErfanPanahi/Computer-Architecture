module PC (clk , PC_Write , in_PC , out_PC);
	input clk,PC_Write;
	input [31:0] in_PC;
	output reg[31:0] out_PC;

	initial begin 
		out_PC = 32'd0;
	end

	always@(posedge clk) begin 
		if (PC_Write == 1)
			out_PC <= in_PC;
	end
endmodule
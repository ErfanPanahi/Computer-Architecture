module Instruction_Memory(out_PC , Instruction);
	input wire [31:0]out_PC; 
	output wire [31:0]Instruction; 
	reg [31:0] mem[0:1024];
	initial begin
		$readmemh("D:/Desktop/Instructions.txt",mem);
	end
	assign Instruction = mem[out_PC>>2];
endmodule
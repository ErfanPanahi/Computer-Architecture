module MIPS(clk);
	input clk;
	wire RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc,zero;
	wire[1:0] ALUop;
	wire[2:0] ALUctrl;
	wire [5:0] OPC,Func;
	Data_Path dp(clk,RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc,ALUctrl,OPC,Func,zero);
	ALU_Control ac(ALUop,Func,ALUctrl);
	Controller cu(clk,zero,OPC,RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc,ALUop);
endmodule
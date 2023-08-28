module Data_Path(clk,RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc,ALUctrl,OPC,Func,zero);
	input clk,RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc;
	input[2:0]ALUctrl;
	output[5:0]OPC,Func;
	output zero;

	wire [31:0]  out_PC,PC4 , Jmpaddr , offset , offsetShl2 , beqAddr , nPC , n2PC , A , B , ALUResult;
	wire [4:0] ReadRegister1 , ReadRegister2;
	wire [31:0] ID , ReadData1 , ReadData2 ,  WriteData , ReadDataMem , Fdata;
	wire [5:0] RegDstOut , WriteRegister;
	reg [31:0] next_PC;
	initial begin 
		next_PC <= 32'd0;
	end
	assign OPC=ID[31:26];
	assign ReadRegister1=ID[25:21];
	assign ReadRegister2=ID[20:16];
	assign RegDstOut=RegDst ? ID[15:11] : ID[20:16];
	assign WriteRegister=Jal ? 6'd31 : RegDstOut;
	assign WriteData=Jal ? PC4 : Fdata;
	assign Jmpaddr={PC4[31:28],ID[25:0],2'd0};
	assign offset[15:0]=ID[15:0];	
	assign offset[31:16]={16{ID[15]}};
	assign nPC=PCSrc ? beqAddr : PC4;
	assign n2PC=Jmp ? Jmpaddr : nPC;
	assign next_PC=Jr ? ReadData1 : n2PC;
	assign offsetShl2={offset[29:0],2'd0};
	assign A=ReadData1;
	assign B=ALUSrc ? offset : ReadData2;
	assign Fdata=MemtoReg ? ReadDataMem : ALUResult;

	//Instantiation
	PC pc(clk,next_PC,out_PC);
	Instruction_Memory Ins_Mem(out_PC,ID);
	adder add4(32'd4,out_PC,PC4);
	RegisterFile RF(RegWrite, clk, ReadRegister1, ReadRegister2, WriteRegister, WriteData, ReadData1, ReadData2);
	adder beq_add(offsetShl2,PC4,beqAddr);
	ALU alu(A ,B,ALUctrl ,ALUResult,zero);
	Data_Memory Data_Mem(clk,MemRead,MemWrite,ALUResult,ReadData2,ReadDataMem);

	assign Func=ID[5:0];
	assign OPC=ID[31:26];
endmodule 
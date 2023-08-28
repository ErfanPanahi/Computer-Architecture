module stageIF(clk,ctrlIF,PCWrite,JmpAdr,JrAdr,BeqAdr,Inst,PC4);
	input clk,PCWrite;
	input [2:0] ctrlIF;
	input [31:0] JmpAdr,JrAdr,BeqAdr;
	output [31:0] Inst,PC4;
	wire PCSrc,Jmp,Jr;
	wire [31:0]BeqOut,JmpOut,adr;
	reg [31:0] nextPC;

	initial begin 
		nextPC <= 32'd0;
	end

	assign {PCSrc,Jmp,Jr} = ctrlIF;
	assign nextPC = Jr ? JrAdr : JmpOut;

	adder Add4(adr,32'd4,PC4);
	mux2to1 #(32) MBeq(PC4,BeqAdr,PCSrc,BeqOut);
	mux2to1 #(32) MJmp(BeqOut,JmpAdr,Jmp,JmpOut);
	PC pc(clk,PCWrite,nextPC,adr);
	Instruction_Memory InstMem(adr,Inst);
endmodule

module stageID(clk,RegWriteWB,WriteRegister,MemReadEX,RtEX,adrID,Inst,WriteData,IF_ID_Write,PCWrite,BeqAdr,JmpAdr,JrAdr,ReadData1,ReadData2,Offset,Rs,Rt,Rd,Func,ctrlWB_ID,ctrlM_ID,ctrlEX_ID,ctrlIF);
	input clk,MemReadEX,RegWriteWB;
	input [31:0] Inst,adrID,WriteData;
	input [4:0] WriteRegister,RtEX;
	output IF_ID_Write,PCWrite;
	output [2:0] ctrlWB_ID,ctrlM_ID;
	output [2:0] ctrlIF;
	output [4:0] Rs,Rt,Rd;
	output [5:0] Func,ctrlEX_ID;
	output [31:0] Offset,ReadData1,ReadData2,BeqAdr,JmpAdr,JrAdr;
	wire IF_Flush,ctrl0,EQ,RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc;
	wire [1:0] ALUop;
	wire [5:0] OPC;
	wire [4:0] Rs,Rt;
	wire [31:0] Offset,ReadData1,ReadData2;

	assign OPC = Inst[31:26];
	assign Func = Inst[5:0];
	assign {Rs,Rt,Rd} = Inst[25:11];
	assign Offset[15:0] = Inst[15:0];	
	assign Offset[31:16] = {16{Inst[15]}};
	assign JmpAdr = {adrID[31:28],Inst[25:0],2'b0};
	assign JrAdr = ReadData1;
	assign EQ = (ReadData1 == ReadData2);
	assign ctrlIF = {PCSrc,Jmp,Jr};
	//assign ctrlEX_ID = {IF_Flush,ALUSrc,Jal,RegDst,ALUop};
	//assign ctrlM_ID = {RegWrite,MemRead,MemWrite};
	//assign ctrlWB_ID = {RegWrite,Jal,MemtoReg];

	adder BeqAdder({Offset[29:0],2'd0},adrID,BeqAdr);
	HazardUnit HU(clk,Rs,Rt,RtEX,MemReadEX,PCWrite,IF_ID_Write,ctrl0);
	Controller CU(clk,EQ,OPC,RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc,IF_Flush,ALUop);
	RegisterFile RF(RegWriteWB,clk,Rs,Rt,WriteRegister,WriteData,ReadData1,ReadData2);
	mux2to1 #(12) CTRL({IF_Flush,ALUSrc,Jal,RegDst,ALUop,RegWrite,MemRead,MemWrite,RegWrite,Jal,MemtoReg},12'b0,ctrl0,{ctrlEX_ID,ctrlM_ID,ctrlWB_ID});
endmodule

module stageEX(clk,RegWriteM,RegWriteWB,ctrlEX_EX,RtEX,RsEX,RdEX,DstRegM,DstRegWB,Func,Offset_out,ReadData1_out,ReadData2_out,ALU1,MemoryAdr,DstRegEX,ALUResult,ALUB);
	input clk,RegWriteM,RegWriteWB;
	input [4:0] RtEX,RsEX,RdEX,DstRegM,DstRegWB;
	input [5:0] ctrlEX_EX,Func;
	input [31:0] Offset_out,ReadData1_out,ReadData2_out,ALU1,MemoryAdr;
	output [4:0] DstRegEX;
	output [31:0] ALUResult,ALUB;
	wire [1:0] ALUop;
	wire ALUSrc,Jal,RegDst,Z,IF_Flush;
	wire [1:0] ForwardA,ForwardB;
	wire [2:0] ALUctrl;
	wire [4:0] DstRegIn;
	wire [31:0] ALUA,ALUB,ALUBin;

	assign {IF_Flush,ALUSrc,Jal,RegDst,ALUop} = ctrlEX_EX;

	mux3to1 #(32) MA(ReadData1_out,ALU1,MemoryAdr,ForwardA,ALUA);
	mux3to1 #(32) MB(ReadData2_out,ALU1,MemoryAdr,ForwardB,ALUB);
	mux2to1 #(32) MBin(ALUB,Offset_out,ALUSrc,ALUBin);
	mux2to1 #(5) RDst1(RtEX,RdEX,RegDst,DstRegIn);
	mux2to1 #(5) RDst2(DstRegIn,5'd31,Jal,DstRegEX);
	ALU_Control ac(ALUop,Func,ALUctrl);
	ALU alu(ALUA,ALUBin,ALUctrl,ALUResult,Z);
	ForwardingUnit FU(clk,RegWriteM,RegWriteWB,RsEX,RtEX,DstRegM,DstRegWB,ForwardA,ForwardB);
endmodule

module stageMEM(clk,ctrlM_M,MemoryAdr,WriteDataMem,MemoryAdrOut,ReadDataMem);
	input clk;
	input [2:0] ctrlM_M;
	input [31:0] MemoryAdr,WriteDataMem;
	output [31:0] MemoryAdrOut,ReadDataMem;
	wire RegWrite,MemRead,MemWrite;

	assign {RegWrite,MemRead,MemWrite} = ctrlM_M;
	assign MemoryAdrOut = MemoryAdr;

	Data_Memory DM(clk,MemRead,MemWrite,MemoryAdr,WriteDataMem,ReadDataMem);
endmodule

module stageWB(ctrlWB_WB,adrWB,MemoryAdrWB,ReadDataWB,WriteData);
	input [2:0] ctrlWB_WB;
	input [31:0] adrWB,MemoryAdrWB,ReadDataWB;
	output [31:0] WriteData;
	wire [31:0] MUXin;
	wire RegWrite,Jal,MemtoReg;
	
	assign {RegWrite,Jal,MemtoReg} = ctrlWB_WB;
	
	mux2to1 #(32) M2Reg(MemoryAdrWB,ReadDataWB,MemtoReg,MUXin);
	mux2to1 #(32) Mjal(MUXin,adrWB,Jal,WriteData);
endmodule

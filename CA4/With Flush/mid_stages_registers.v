module IF_ID(clk,IF_ID_write,IF_Flush,adrIF,In_inst,adrID,Out_inst);
	input clk , IF_ID_write,IF_Flush;
	input [31:0] adrIF , In_inst;
	output reg [31:0] adrID , Out_inst;

	always @ (posedge clk) begin
		if(IF_ID_write) begin
			adrID<=adrIF;
			Out_inst<=In_inst;
		end
	end

	always @ (IF_Flush) begin
		if(IF_Flush)
			Out_inst <= 32'b1;
	end

endmodule

module ID_EX(clk,adrID,ctrlWB_ID,ctrlM_ID,ctrlEX_ID,ReadData1,ReadData2,Offset,Rt,Rd,Rs,FuncIn,adrEX,ctrlWB_EX,ctrlM_EX,ctrlEX_EX,ReadData1_out,ReadData2_out,Offset_out,RdEX,RtEX,RsEX,FuncOut);
	input clk;
	input [2:0] ctrlWB_ID,ctrlM_ID;
	input [31:0] ReadData1,ReadData2,Offset,adrID;
	input [5:0] FuncIn,ctrlEX_ID;
	input [4:0] Rt,Rd,Rs;
	output reg [31:0] adrEX,ReadData1_out,ReadData2_out,Offset_out;
	output reg [4:0] RdEX,RtEX,RsEX;
	output reg [2:0] ctrlWB_EX,ctrlM_EX;
	output reg [5:0] FuncOut,ctrlEX_EX;
	
	always @ (posedge clk) begin
		adrEX <= adrID;
		ctrlWB_EX <= ctrlWB_ID;
		ctrlM_EX <= ctrlM_ID;
		ctrlEX_EX <= ctrlEX_ID;
		ReadData1_out <= ReadData1;
		ReadData2_out <= ReadData2;
		Offset_out <= Offset;
		RtEX <= Rt;
		RdEX <= Rd;
		RsEX <= Rs;
		FuncOut <= FuncIn;
	end
endmodule

module EX_M(clk,adrEX,ctrlWB_EX,ctrlM_EX,ALUResult,ALUB,DstRegEX,adrM,ctrlWB_M,ctrlM_M,MemoryAdr,WriteDataMem,DstRegM);
	input  clk;
	input [2:0] ctrlWB_EX,ctrlM_EX;
	input [31:0] ALUResult,ALUB,adrEX;
	input [4:0] DstRegEX;
	output reg [4:0] DstRegM;
	output reg [31:0] MemoryAdr,WriteDataMem,adrM;
	output reg [2:0] ctrlWB_M,ctrlM_M;
	always @ (posedge clk) begin
		adrM <= adrEX;
		ctrlWB_M <= ctrlWB_EX;
		ctrlM_M <= ctrlM_EX;
		DstRegM <= DstRegEX;
		MemoryAdr <= ALUResult;
		WriteDataMem <= ALUB;
	end
endmodule

module M_WB(clk,adrM,ctrlWB_M,MemoryAdrOut,ReadDataM,DstRegM,adrWB,ctrlWB_WB,MemoryAdrWB,ReadDataWB,DstRegWB);
	input  clk;
	input [2:0] ctrlWB_M;
	input [31:0] MemoryAdrOut,ReadDataM,adrM;
	input [4:0] DstRegM;
	output reg [4:0] DstRegWB;
	output reg [31:0] MemoryAdrWB,ReadDataWB,adrWB;
	output reg [2:0] ctrlWB_WB;
	always @ (posedge clk) begin
		adrWB <= adrM;
		ctrlWB_WB <= ctrlWB_M;
		DstRegWB <= DstRegM;
		MemoryAdrWB <= MemoryAdrOut;
		ReadDataWB <= ReadDataM;
	end
endmodule

module Processor(clk);
	input clk;
	wire L_tr , L_br , I , E , D;
	wire[2:0] Inst;
	wire PCWrite , IorD , MemWrite , MemRead , IRWrite , RR2sel , WRsel , RegWrite , ALUsrcA , PCsrc , flag_write , ALUop;
	wire[1:0] ALUsrcB , WDsel;
	wire [2:0] OPC , ALUctrl;
	DataPath dp(clk,PCWrite,IorD,MemWrite,MemRead,IRWrite,RR2sel,WRsel,RegWrite,ALUsrcA,PCsrc,flag_write,ALUop,ALUsrcB,WDsel,ALUctrl,L_tr,L_br,I,E,D,Inst,OPC);
	ALUcontrol ac(ALUop,OPC,ALUctrl);
	Controller cu(clk,L_tr,L_br,I,E,D,Inst,PCWrite,IorD,MemWrite,MemRead,IRWrite,RR2sel,WRsel,RegWrite,ALUsrcA,PCsrc,flag_write,ALUop,ALUsrcB,WDsel);
endmodule
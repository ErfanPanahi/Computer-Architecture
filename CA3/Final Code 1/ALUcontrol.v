module ALUcontrol (ALUop,OPC,ALUctrl);
	input[2:0] OPC;
	input ALUop;
	output[2:0] ALUctrl;
	assign ALUctrl = {ALUop,ALUop,ALUop} & OPC;
endmodule
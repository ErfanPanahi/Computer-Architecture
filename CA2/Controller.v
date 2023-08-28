`define RT 6'b000000
`define ADDI 6'b000001
`define SLTI 6'b000010
`define LW 6'b000011
`define SW 6'b000100
`define BEQ 6'b000101
`define J 6'b000110
`define JR 6'b000111
`define JAL 6'b001000
module Controller(clk,zero,OPC,RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc,ALUop);
	input clk,zero;
	input[5:0]OPC;
	output reg RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc;
	output reg[1:0]ALUop;

	always@(OPC) begin 
		{RegDst,RegWrite,Jal,Jr,Jmp,MemtoReg,MemRead,MemWrite,ALUSrc,PCSrc,ALUop}<=12'd0;
		case(OPC)
			`RT: begin
				RegDst<=1;
				Jal<=0;
				RegWrite<=1;
				ALUSrc<=0;
				ALUop<=2'b00;
				MemRead<=0;
				MemWrite<=0;
				MemtoReg<=0;
				PCSrc<=0;
				Jmp<=0;
				Jr<=0;
			end
			`ADDI: begin 
				RegDst<=0;
				Jal<=0;
				RegWrite<=1;
				ALUSrc<=1;
				ALUop<=2'b01;
				MemRead<=0;
				MemWrite<=0;
				MemtoReg<=0;
				PCSrc<=0;
				Jmp<=0;
				Jr<=0;
			end
			`SLTI: begin 
				RegDst<=0;
				Jal<=0;
				RegWrite<=1;
				ALUSrc<=1;
				ALUop<=2'b10;
				MemRead<=0;
				MemWrite<=0;
				MemtoReg<=0;
				PCSrc<=0;
				Jmp<=0;
				Jr<=0;
			end
			`LW: begin 
				RegDst<=0;
				Jal<=0;
				RegWrite<=1;
				ALUSrc<=1;
				ALUop<=2'b01;
				MemRead<=1;
				MemWrite<=0;
				MemtoReg<=1;
				PCSrc<=0;
				Jmp<=0;
				Jr<=0;
			end
			`SW: begin 
				RegDst<=0;
				Jal<=0;
				RegWrite<=0;
				ALUSrc<=1;
				ALUop<=2'b01;
				MemRead<=0;
				MemWrite<=1;
				MemtoReg<=0;
				PCSrc<=0;
				Jmp<=0;
				Jr<=0;
			end
			`BEQ: begin 
				RegDst<=0;
				Jal<=0;
				RegWrite<=0;
				ALUSrc<=0;
				ALUop<=2'b11;
				MemRead<=0;
				MemWrite<=0;
				MemtoReg<=0;
				PCSrc<=zero;
				Jmp<=0;
				Jr<=0;
			end
			`J: begin 
				RegDst<=0;
				Jal<=0;
				RegWrite<=0;
				ALUSrc<=0;
				ALUop<=2'b00;
				MemRead<=0;
				MemWrite<=0;
				MemtoReg<=0;
				PCSrc<=0;
				Jmp<=1;
				Jr<=0;
			end
			`JR: begin 
				RegDst<=0;
				Jal<=0;
				RegWrite<=0;
				ALUSrc<=0;
				ALUop<=2'b00;
				MemRead<=0;
				MemWrite<=0;
				MemtoReg<=0;
				PCSrc<=0;
				Jmp<=0;
				Jr<=1;
			end
			`JAL: begin 
				RegDst<=0;
				Jal<=1;
				RegWrite<=1;
				ALUSrc<=0;
				ALUop<=2'b00;
				MemRead<=0;
				MemWrite<=0;
				MemtoReg<=0;
				PCSrc<=0;
				Jmp<=1;
				Jr<=0;
			end
		endcase
	end
endmodule
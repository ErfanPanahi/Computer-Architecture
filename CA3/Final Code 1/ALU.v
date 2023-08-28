module ALU (A , B , ALUctrl , ALUResult , zero , carry , neg , ov);
	input [31:0] A , B;
	input [2:0] ALUctrl;
	output reg [31:0] ALUResult;
	output reg zero , carry , neg , ov;
	wire[31:0] negB;

	assign negB = ~B+1;

	always@(ALUctrl or A or B or negB) begin
		case(ALUctrl)
			0: //ADD
				begin
					{carry,ALUResult} <= A+B;
					ov <= (~A[31] & ~B[31] & ALUResult[31]) | (A[31] & B[31] & ~ALUResult[31]);
				end
			1: //SUB
				begin
					{carry,ALUResult} <= A+(~B+1);
					ov <= (~A[31] & ~negB[31] & ALUResult[31]) | (A[31] & negB[31] & ~ALUResult[31]);
				end
			2: //RSB
				begin
					{carry,ALUResult} <= A+(~B+1);
					ov <= (~A[31] & ~negB[31] & ALUResult[31]) | (A[31] & negB[31] & ~ALUResult[31]);
				end
			3: //AND
				ALUResult <= A&B;
			4: //NOT
				ALUResult <= ~B+1;
			5: //TST
				ALUResult <= A&B;
			6: //CMP
				begin
					{carry,ALUResult} <= A+(~B+1);
					ov <= (~A[31] & ~negB[31] & ALUResult[31]) | (A[31] & negB[31] & ~ALUResult[31]);
				end
			7: //MOV
				ALUResult <= B;
		endcase
	end
	
	assign zero = (ALUResult == 32'd0);
	assign neg = (ALUResult[31]);

	endmodule

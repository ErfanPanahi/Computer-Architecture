module ALU (A , B , ALUctrl , ALUResult , zero);
	input [31:0] A , B;
	input [2:0] ALUctrl;
	output reg [31:0] ALUResult;
	output reg zero;

	always@(ALUctrl or A or B) begin
		case(ALUctrl)
			0: //ADD
				ALUResult <= A+B;
			1: //SUB
				ALUResult <= A+(~B+1);
			2: //AND
				ALUResult <= A&B;
			3: //OR
				ALUResult <= A|B;
			4: //SLT
				begin 				if (A[31] != B[31]) begin					if (A[31] > B[31]) begin						ALUResult <= 1;					end else begin						ALUResult <= 0;					end				end else begin					if (A < B)					begin						ALUResult <= 1;					end					else					begin						ALUResult <= 0;					end				end			end
		endcase
	end

	always @(ALUResult) begin		if (ALUResult == 0) begin			zero <= 1;		end else begin			zero <= 0;		end	end
endmodule
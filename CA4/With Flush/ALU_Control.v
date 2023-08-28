module ALU_Control(ALUop , Func , ALUctrl);
	input [1:0] ALUop;
	input [5:0] Func;
	output reg[2:0] ALUctrl;

	always@(ALUop or Func) begin
		case(ALUop)
			2'b00://add , sub , and , or , slt
				begin 
				if(Func==6'b000001) begin  
					ALUctrl <= 3'd0;  //add
				end else if(Func==6'b000010) begin
					ALUctrl <= 3'd1;  //sub
				end else if(Func==6'b000100) begin
					ALUctrl <= 3'd2;  //and
				end else if(Func==6'b001000) begin
					ALUctrl <= 3'd3;  //or
				end else if(Func==6'b010000) begin
					ALUctrl <= 3'd4;  //slt
				end
				end
				
			2'b01://addi , lw , sw
				begin 
					ALUctrl <= 3'd0;  //add
				end

			2'b10://slti 
				begin 
					ALUctrl <= 3'd4;  //slt
				end
			2'b11://beq
				begin 
					ALUctrl <= 3'd1;  //sub
				end
		endcase
	end
endmodule
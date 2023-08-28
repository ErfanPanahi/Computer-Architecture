`define IF 4'd0
`define ID 4'd1
`define CheckC 4'd2
`define DP 4'd3
`define RM 4'd4
`define ImmD 4'd5
`define TSTCMP 4'd6
`define Others 4'd7
`define DT 4'd8
`define SW 4'd9
`define LW 4'd10
`define RW 4'd11
`define BR 4'd12
`define BandL 4'd13
`define B 4'd14

module Controller (clk,L_tr,L_br,I,E,D,Inst,PCWrite,IorD,MemWrite,MemRead,IRWrite,RR2sel,WRsel,RegWrite,ALUsrcA,PCsrc,flag_write,ALUop,ALUsrcB,WDsel);
	input clk,L_tr,L_br,I,E,D;
	input[2:0] Inst;
	output reg PCWrite,IorD,MemWrite,MemRead,IRWrite,RR2sel,WRsel,RegWrite,ALUsrcA,PCsrc,flag_write,ALUop;
	output reg[1:0] ALUsrcB,WDsel;
	
	reg[3:0] ns,ps;

	initial begin 
		ps = 4'd0;
	end

   	always @(posedge clk)
		ps = ns;

	always @(ps or Inst or D) begin
		case(ps)
			`IF: ns = `ID; 
			`ID: ns = `CheckC;
			`CheckC: if(D == 1) begin
					case(Inst)
						3'b000: ns = `DP;
						3'b010: ns = `DT;
						3'b101: ns = `BR;
						default: ns = `IF;
					endcase
				 end else
					ns = `IF;
			`DP: ns = I ? `ImmD : `RM;
			`RM: ns = E ? `TSTCMP : `Others; 
			`ImmD: ns = E ? `TSTCMP : `Others;
			`TSTCMP: ns = `IF;
			`Others: ns = `IF;
			`DT: ns = L_tr ? `SW : `LW;
			`SW: ns = `IF;
			`LW: ns = `RW;
			`RW: ns = `IF;
			`BR: ns = L_br ? `BandL : `B;
			`BandL: ns = `IF;
			`B: ns = `IF;
		endcase
	end
	
	always @(ps) begin
		{PCWrite,IorD,MemWrite,MemRead,IRWrite,RR2sel,WRsel,RegWrite,ALUsrcA,PCsrc,flag_write,ALUop,ALUsrcB,WDsel} = 16'd0;
		case(ps)
			`IF: begin
				IorD = 1'b0;
				MemRead = 1'b1;
				IRWrite = 1'b1;
				PCWrite = 1'b1;
				ALUsrcA = 1'b0;
				ALUsrcB = 2'b00;
				ALUop = 1'b0;
				PCsrc = 1'b0;
			     end
			`ID: begin
				ALUsrcA = 1'b0;
				ALUsrcB = 2'b11;
				ALUop = 1'b0;
			     end
			`CheckC: ;
			`DP: RR2sel = 1'b1;
			`RM: begin
				ALUsrcA = 1'b1;
				ALUsrcB = 2'b01;
				ALUop = 1'b1;
				flag_write = 1'b1;
			     end
			`ImmD: begin
				 ALUsrcA = 1'b1;
				 ALUsrcB = 2'b10;
				 ALUop = 1'b1;
				 flag_write = 1'b1;
			       end
			`TSTCMP: begin
				    WDsel = 2'b10;
				    WRsel = 1'b0;
				    RegWrite = 1'b0;
				    flag_write = 1'b1;
				 end
			`Others: begin
				    WDsel = 2'b10;
				    WRsel = 1'b0;
				    RegWrite = 1'b1;
				 end
			`DT: begin
				 ALUsrcA = 1'b1;
				 ALUsrcB = 2'b10;
				 ALUop = 1'b0;
				 RR2sel = 1'b0;
			     end
			`SW: begin
				IorD = 1'b1;
				MemWrite = 1'b1;
			     end
			`LW: begin
				IorD = 1'b1;
				MemRead = 1'b1;
			     end
			`RW: begin
				WDsel = 1'b0;
				WRsel = 1'b0;
				RegWrite =1'b1;
			     end
			`BR: begin
				ALUsrcA = 1'b0;
				ALUsrcB = 2'b11;
				ALUop = 1'b0;
			     end
			`BandL: begin
				   WDsel = 1'b1;
				   WRsel = 1'b1;
				   RegWrite = 1'b1;
				   PCWrite = 1'b1;
				   PCsrc = 1'b1;
			        end
			`B: begin
				PCsrc = 1'b1;
				PCWrite =1'b1;
			    end
		endcase
	end	
endmodule
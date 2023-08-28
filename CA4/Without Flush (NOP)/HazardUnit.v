module HazardUnit(clk,RsID,RtID,RtEX,MemReadEX,PCWrite,IF_ID_Write,ctrl0);
	input clk,MemReadEX;
	input [4:0] RsID, RtID, RtEX;
	output reg PCWrite,IF_ID_Write,ctrl0;
	
	always @ (negedge clk) begin
		if(MemReadEX & ((RtID == RtEX) | (RsID == RtEX)))
			{PCWrite,IF_ID_Write,ctrl0} <= 3'b001;
		else
			{PCWrite,IF_ID_Write,ctrl0} <= 3'b110;
	end
endmodule

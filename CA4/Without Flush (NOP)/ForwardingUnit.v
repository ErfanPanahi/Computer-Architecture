module ForwardingUnit(clk,RegWriteM,RegWriteWB,RsEX,RtEX,RdM,RdWB,ForwardA,ForwardB);
	input clk,RegWriteM,RegWriteWB;
	input [4:0] RsEX,RtEX,RdM,RdWB;
	output reg [1:0] ForwardA,ForwardB;
	
	always @(negedge clk) begin
		if( (RegWriteM == 1) & (RdM == RsEX) & ~(RdM == 5'd0) ) begin
			ForwardA <= 2'b10;
		end else if ( (RegWriteWB == 1) &  (RdWB == RsEX) & ~(RdWB == 5'd0) ) begin
			ForwardA <= 2'b01;
		end else begin 
			ForwardA <= 2'b00;
		end
	end
	always @(negedge clk) begin
		if( (RegWriteM == 1) & (RdM == RtEX) & ~(RdM == 5'd0) ) begin
			ForwardB <= 2'b10;
		end else if ( (RegWriteWB == 1) &  (RdWB == RtEX) & ~(RdWB == 5'd0) ) begin
			ForwardB <= 2'b01;
		end else begin 
			ForwardB <= 2'b00;
		end
	end
	/*always @(posedge clk) begin
		ForwardA <= 2'b00;
		ForwardB <= 2'b00;
	end*/
endmodule

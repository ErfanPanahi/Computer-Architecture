module RegisterFile(RegWrite, clk, ReadRegister1, ReadRegister2, WriteRegister, WriteData, ReadData1, ReadData2);
	input [4:0] ReadRegister1 , ReadRegister2 , WriteRegister;
	input [31:0] WriteData;
	input RegWrite , clk;
	output reg [31:0] ReadData1 , ReadData2;
	reg [31:0] Register [0:31];
	integer i;
	initial begin 
		for (i=0; i<32; i=i+1)
			Register[i] = 32'd0;
	end
	always @(negedge clk) begin
		if (RegWrite == 1)  begin 
			Register[WriteRegister] <= WriteData;
		end
	end

	always @(ReadRegister1 or ReadRegister2) begin
		ReadData1 <= Register[ReadRegister1];
		ReadData2 <= Register[ReadRegister2];
	end
endmodule 
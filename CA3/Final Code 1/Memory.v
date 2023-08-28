module Memory(clk , MemRead , MemWrite , Address , WriteData , ReadData);
	input clk , MemRead , MemWrite;
	input[31:0] Address , WriteData , ReadData;

	reg [31:0] ram [0:4095];
	wire [11:0] ram_addr = Address[11:0];
	integer i;
	initial begin 
		$readmemh("D:/Desktop/Memory.txt",ram);
	end
	always @(negedge clk) begin
		if (MemWrite) begin
			ram[ram_addr] <= WriteData;
		end
		end
	assign ReadData = (MemRead==1'b1) ? ram[ram_addr]: 32'd0;
	always @(posedge clk) begin
		$writememh("D:/Desktop/NewMemory.txt",ram);
	end
	
endmodule
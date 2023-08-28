`timescale 1ns/1ns

module TB;
	reg clk=0 ;
	Processor UUT(clk);
	always #10 clk=~clk;
	initial begin
		#10000 $monitor("Minimum Value : Mem[2000] = %p",UUT.dp.Mem.ram[2000]);
		#10 $monitor("Index : Mem[2004] = %p",UUT.dp.Mem.ram[2004]);
		#10 $stop;
	end
endmodule

`timescale 1ns/1ns

module test;
	reg clk=0 ;
	MIPS UUT(clk);
	always #10 clk=~clk;
	initial begin
		#5000 $stop;
	end
endmodule

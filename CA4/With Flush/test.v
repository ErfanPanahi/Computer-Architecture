`timescale 1ns/1ns

module test();
	reg clk=0 ;
	Data_Path UUT(clk);
	always #5 clk=~clk;
	initial begin
		#5000 $stop;
	end
endmodule

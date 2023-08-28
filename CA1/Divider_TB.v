module Divider_TB;
    reg [9:0] data_in;
    reg rst,start,clk;
    wire [4:0] data_out;
    wire doneq,donew,DivBy0,OV;

    Divider DUT(data_in,rst,start,clk,data_out,doneq,donew,DivBy0,OV);

    initial begin 
        start=1'b0;
        rst=1'b0;
        clk=1'b0;
        #13 rst=1'b1;
        #20 rst=1'b0;
        #13 start=1'b1;
        #20 start=1'b0;
        data_in=10'd75;
        #20 data_in=5'd11;
        #1000;
	#13 rst=1'b1;
        #20 rst=1'b0;
        #13 start=1'b1;
        #20 start=1'b0;
        data_in=10'd80;
        #20 data_in=5'd9;
	#1000;
	#13 rst=1'b1;
        #20 rst=1'b0;
        #13 start=1'b1;
        #20 start=1'b0;
        data_in=10'd150;
        #20 data_in=5'd13;
        #1000;
	#13 rst=1'b1;
        #20 rst=1'b0;
        #13 start=1'b1;
        #20 start=1'b0;
        data_in=10'd100;
        #20 data_in=5'd8;
        #1000;
	#15 rst=1'b1;
        #20 rst=1'b0;
        #13 start=1'b1;
        #20 start=1'b0;
        data_in=10'd140;
        #20 data_in=5'd14;
        #1000;
	#13 rst=1'b1;
        #20 rst=1'b0;
        #13 start=1'b1;
        #20 start=1'b0;
        data_in=10'd140;
        #20 data_in=5'd0;
        #1000;
	#13 rst=1'b1;
        #20 rst=1'b0;
        #13 start=1'b1;
        #20 start=1'b0;
        data_in=10'b0011100010;
        #20 data_in=5'd5;
        #2000 $finish;
    end

    always begin
        #10 clk=~clk;
    end

endmodule
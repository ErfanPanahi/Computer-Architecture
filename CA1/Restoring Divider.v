module Divider (data_in,rst,start,clk,data_out,doneq,donew,DivBy0,OV);
    input [9:0] data_in;
    input rst,start,clk;
    output [4:0] data_out;
    output doneq,donew,DivBy0,OV;
    wire ldd,or_d,OV_not,ldw,shw,ldq,shq,q0,d_sel,w_sel,out_sel,sign;
    
    datapath dp(data_in,ldd,or_d,OV_not,ldw,shw,ldq,shq,q0,d_sel,w_sel,
                 out_sel,clk,sign,data_out);
    controller cu(start,sign,rst,clk,ldd,or_d,OV_not,ldw,shw,
                   ldq,shq,q0,d_sel,w_sel,out_sel,doneq,donew,DivBy0,OV);

endmodule
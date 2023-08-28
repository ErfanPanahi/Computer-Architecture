module datapath (data_in,ldd,or_d,OV_not,ldw,shw,ldq,shq,q0,
                  d_sel,w_sel,out_sel,clk,sign,data_out);

    input [9:0] data_in;
    input ldd,ldw,shw,ldq,shq,q0,d_sel,w_sel,out_sel,clk;
    output sign,or_d,OV_not;
    output [4:0] data_out;
    wire [4:0] d,q;
    wire [5:0] w_out,d_out,sum,w_in,dummy;

    shreg_nb #(5) d_reg(data_in[4:0],1'b0,ldd,1'b0,clk,d);//d Register with load
    mux_2_to_1 #(6) mux1({1'b0,d},~{1'b0,d},d_sel,d_out);
    adder add_6b(d_out,w_out,d_sel,sum);
    mux_2_to_1 #(6) mux2(sum,{1'b0,data_in[9:5]},w_sel,w_in);
    shreg_nb #(6) w_reg(w_in,q[4],ldw,shw,clk,w_out);
    shreg_nb #(5) q_reg(data_in[4:0],q0,ldq,shq,clk,q);
    mux_2_to_1 #(5) mux3(q,w_out[4:0],out_sel,data_out);  
    adder add_6b_OV(~{1'b0,d},w_out,1'b1,dummy);

    assign sign=w_out[5];
    assign or_d=|data_in;
    assign OV_not=dummy[5];

endmodule

module mux_2_to_1 #(parameter n=5)(i0,i1,sel,y);
    input [n-1:0] i0,i1;
    input sel;
    output [n-1:0] y;
    assign y=sel?i1:i0;
endmodule

module shreg_nb #(parameter n=6)(d,ser_in,ld,sh,clk,q);
    input [n-1:0] d;
    input ser_in,ld,sh,clk;
    output [n-1:0] q;
    reg [n-1:0] q;
    always@(posedge clk)
        if(ld)
            q<=d;
        else if(sh)
            q<={q[n-2:0],ser_in};
endmodule

module adder (a,b,ci,s);
    input [5:0] a,b;
    input ci;
    output [5:0] s;
    assign s=a+b+ci;
endmodule


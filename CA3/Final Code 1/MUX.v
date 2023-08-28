module mux2to1 #(parameter n=5)(i0,i1,sel,y);
    input [n-1:0] i0,i1;
    input sel;
    output [n-1:0] y;
    assign y = sel ? i1 : i0;
endmodule

module mux3to1 #(parameter n=5)(i0,i1,i2,sel,y);
    input [n-1:0] i0,i1,i2;
    input [1:0] sel;
    output [n-1:0] y;
    assign y = sel[1] ? i2 : (sel[0] ? i1 : i0);
endmodule

module mux4to1 #(parameter n=5)(i0,i1,i2,i3,sel,y);
    input [n-1:0] i0,i1,i2,i3;
    input [1:0] sel;
    output [n-1:0] y;
    assign y = sel[1] ? (sel[0] ? i3 : i2) : (sel[0] ? i1 : i0);
endmodule
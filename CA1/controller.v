`define S0 6'd0
`define S1 6'd1
`define S2 6'd2
`define S3 6'd3
`define S4 6'd4
`define S5 6'd5
`define S6 6'd6
`define S7 6'd7
`define S8 6'd8
`define S9 6'd9
`define S10 6'd10
`define S11 6'd11
`define S12 6'd12
`define S13 6'd13
`define S14 6'd14
`define S15 6'd15
`define S16 6'd16
`define S17 6'd17
`define S18 6'd18
`define S19 6'd19
`define S20 6'd20
`define S21 6'd21
`define S22 6'd22
`define S23 6'd23
`define S24 6'd24
`define S25 6'd25
`define S26 6'd26
`define S27 6'd27
`define S28 6'd28
`define S29 6'd29
`define DB0 6'd30
`define OVdet 6'd31
module controller (start,sign,rst,clk,ldd,or_d,OV_not,ldw,shw,
                    ldq,shq,q0,d_sel,w_sel,out_sel,doneq,donew,DivBy0,OV);
    input start,sign,or_d,OV_not,rst,clk;
    output ldd,ldw,shw,ldq,shq,q0,d_sel,w_sel,out_sel,doneq,donew,DivBy0,OV;
    reg ldd,ldw,shw,ldq,shq,q0,d_sel,w_sel,out_sel,doneq,donew,DivBy0,OV;
    reg [5:0] ps, ns;

    always @(posedge clk)
        if (rst)
            ps=`S0;
        else
            ps=ns;

    always @(ps or start or sign or or_d or OV_not) begin
        case (ps)
            `S0:ns=start?`S1:`S0;
            `S1:ns=`S2;
            `S2:ns=or_d?`S3:`DB0;
            `S3:ns=OV_not?`S4:`OVdet;
            `S4:ns=`S5;
            `S5:ns=sign?`S6:`S7;
            `S6:ns=`S8;
            `S7:ns=`S9;
            `S8:ns=`S9;
            `S9:ns=`S10;
            `S10:ns=sign?`S11:`S12;
            `S11:ns=`S13;
            `S12:ns=`S14;
            `S13:ns=`S14;
            `S14:ns=`S15;
            `S15:ns=sign?`S16:`S17;
            `S16:ns=`S18;
            `S17:ns=`S19;
            `S18:ns=`S19;
            `S19:ns=`S20;
            `S20:ns=sign?`S21:`S22;
            `S21:ns=`S23;
            `S22:ns=`S24;
            `S23:ns=`S24;
            `S24:ns=`S25;
            `S25:ns=sign?`S26:`S27;
            `S26:ns=`S28;
            `S27:ns=`S28;
            `S28:ns=`S29;
            `S29:ns=`S0;		
            `DB0:ns=`S0;
	    `OVdet:ns=`S0;
        endcase
    end

    always @(ps) begin
        {ldd,ldw,shw,ldq,shq,q0,d_sel,w_sel,out_sel,doneq,donew,DivBy0,OV}=13'b0_0000_0000_0000;
        case(ps)
            `S0: ;
            `S1:{w_sel,ldw,ldq}=3'b111;
            `S2:ldd=1'b1;
            `S3:{shw,shq}=2'b11;
            `S4:{d_sel,ldw}=2'b11;
            `S5: ;
            `S6:ldw=1'b1;
            `S7:{q0,shw,shq}=3'b111;
            `S8:{shw,shq}=2'b11;
            `S9:{d_sel,ldw}=2'b11;
            `S10: ;
            `S11:ldw=1'b1;
            `S12:{q0,shw,shq}=3'b111;
            `S13:{shw,shq}=2'b11;
            `S14:{d_sel,ldw}=2'b11;
            `S15: ;
            `S16:ldw=1'b1;
            `S17:{q0,shw,shq}=3'b111;
            `S18:{shw,shq}=3'b11;
            `S19:{d_sel,ldw}=2'b11;
            `S20: ;
            `S21:ldw=1'b1;
            `S22:{q0,shw,shq}=3'b111;
            `S23:{shw,shq}=3'b11;
            `S24:{d_sel,ldw}=2'b11;
            `S25: ;
            `S26:{ldw,shq}=2'b11;
            `S27:{shq,q0}=2'b11;
            `S28:doneq=1'b1;
            `S29:{donew,out_sel}=2'b11;
	    `DB0:DivBy0=1'b1;
	    `OVdet:OV=1'b1;
        endcase
    end

endmodule
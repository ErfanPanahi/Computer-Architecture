module TST_CMP_det(O,E);
	input [2:0] O;
	output E;
	assign E = (O[0] ^ O[1]) & O[2];
endmodule
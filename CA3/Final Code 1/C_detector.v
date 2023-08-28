module C_detector(C,Z,N,V,D);
	input [1:0] C;
	input Z,N,V;
	output D;
	assign D = (C[1] & C[0]) | (Z & ~C[1] & ~C[0]) | (C[1] & (N ^ V)) | (~Z & C[0] & ~(N ^ V)); 
endmodule 

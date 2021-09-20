module sll(a, shift_amt, out);
	input [31:0] a;
	input [4:0] shift_amt;
	output [31:0] out;
	wire [31:0] cache [0:3];

	generate
   genvar j;	
		for (j = 0; j < 1; j = j + 1) begin: f0_0
			mux m1(a[j], 0, shift_amt[0], cache[0][j]);
		end
		for (j = 1; j < 32; j = j + 1) begin: f0_1
			mux m2(a[j], a[j - 1], shift_amt[0], cache[0][j]);
		end
		for (j = 0; j < 2; j = j + 1) begin: f1_0
			mux m3(cache[0][j], 0, shift_amt[1], cache[1][j]);
			end
		for (j = 2; j < 32; j = j + 1) begin: f1_1
			mux m4(cache[0][j], cache[0][j - 2], shift_amt[1], cache[1][j]);
		end
		for (j = 0; j < 4; j = j + 1) begin: f2_0
			mux m5(cache[1][j], 0, shift_amt[2], cache[2][j]);
			end
		for (j = 4; j < 32; j = j + 1) begin: f2_1
			mux m6(cache[1][j], cache[1][j - 4], shift_amt[2], cache[2][j]);
		end
		for (j = 0; j < 8; j = j + 1) begin: f3_0
			mux m7(cache[2][j], 0, shift_amt[3], cache[3][j]);
			end
		for (j = 8; j < 32; j = j + 1) begin: f3_1
			mux m8(cache[2][j], cache[2][j - 8], shift_amt[3], cache[3][j]);
		end
		for (j = 0; j < 16; j = j + 1) begin: f4_0
			mux m9(cache[3][j], 0, shift_amt[4], out[j]);
		end
		for (j = 16; j < 32; j = j + 1) begin: f4_1
			mux m10(cache[3][j], cache[3][j - 16], shift_amt[4], out[j]);
		end
	endgenerate
endmodule

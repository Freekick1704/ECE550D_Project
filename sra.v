module sra(a, shift_amt, out);
	input [31:0] a;
	input [4:0] shift_amt;
	output [31:0] out;
	wire [127:0] connection;
	generate
		genvar i;
		for (i = 0; i < 1; i = i + 1)
			begin : gen1_1
				mux my_mux1_1(a[31 - i], a[31], shift_amt[0], connection[i]);
			end
		for (i = 1; i < 32; i = i + 1)
			begin : gen1
				mux my_mux1(a[31 - i], a[32 - i], shift_amt[0], connection[i]);
			end
		for (i = 0; i < 2; i = i + 1)
			begin : gen2_2
				mux my_mux2_2(connection[i], a[31], shift_amt[1], connection[i + 32]);
			end
		for (i = 2; i < 32; i = i + 1)
			begin : gen2
				mux my_mux2(connection[i], connection[i - 2], shift_amt[1], connection[i + 32]);
			end
		for (i = 0; i < 4; i = i + 1)
			begin : gen3_4
				mux my_mux3_4(connection[i + 32], a[31], shift_amt[2], connection[i + 64]);
			end
		for (i = 4; i < 32; i = i + 1)
			begin : gen3
				mux my_mux3(connection[i + 32], connection[i + 28], shift_amt[2], connection[i + 64]);
			end
		for (i = 0; i < 8; i = i + 1)
			begin : gen4_8
				mux my_mux4_8(connection[i + 64], a[31], shift_amt[3], connection[i + 96]);
			end
		for (i = 8; i < 32; i = i + 1)
			begin : gen4
				mux my_mux4(connection[i + 64], connection[i + 56], shift_amt[3], connection[i + 96]);
			end
		for (i = 0; i < 16; i = i + 1)
			begin : gen5_16
				mux my_mux5_16(connection[i + 96], a[31], shift_amt[4], out[31 - i]);
			end
		for (i = 16; i < 32; i = i + 1)
			begin : gen5
				mux my_mux5(connection[i + 96], connection[i + 80], shift_amt[4], out[31 - i]);
			end
	endgenerate
endmodule

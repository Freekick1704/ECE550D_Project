module rca_8(a, b, ci, co, out);
	input ci;
	input [7:0] a, b;
	output co;
	output [7:0] out;
	wire co_0, co_1, co_2, co_3, co_4, co_5, co_6;
	full_adder fa0(a[0], b[0], ci, co_0, out[0]);
	full_adder fa1(a[1], b[1], co_0, co_1, out[1]);
	full_adder fa2(a[2], b[2], co_1, co_2, out[2]);
	full_adder fa3(a[3], b[3], co_2, co_3, out[3]);
	full_adder fa4(a[4], b[4], co_3, co_4, out[4]);
	full_adder fa5(a[5], b[5], co_4, co_5, out[5]);
	full_adder fa6(a[6], b[6], co_5, co_6, out[6]);
	full_adder fa7(a[7], b[7], co_6, co, out[7]);
endmodule

module rca_8_ovf(a, b, ci, co, ovf, out);
	input ci;
	input [7:0] a, b;
	output co, ovf;
	output [7:0] out;
	wire co_0, co_1, co_2, co_3, co_4, co_5, co_6;
	full_adder fa0(a[0], b[0], ci, co_0, out[0]);
	full_adder fa1(a[1], b[1], co_0, co_1, out[1]);
	full_adder fa2(a[2], b[2], co_1, co_2, out[2]);
	full_adder fa3(a[3], b[3], co_2, co_3, out[3]);
	full_adder fa4(a[4], b[4], co_3, co_4, out[4]);
	full_adder fa5(a[5], b[5], co_4, co_5, out[5]);
	full_adder fa6(a[6], b[6], co_5, co_6, out[6]);
	full_adder fa7(a[7], b[7], co_6, co, out[7]);
	xor overflow(ovf, co_6, co);
endmodule

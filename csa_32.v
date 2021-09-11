module csa_32(a, b, ci, co, ovf, out);
	input [31:0] a, b;
	input ci;
	output co, ovf;
	output [31:0] out;
	wire [3:0] real_co;
	wire [8:0] guess_co;
	wire [1:0] real_ovf;
	wire [3:0] guess_ovf;
	wire [80:0] guess_out;
	
	
	rca_8 q0(a[7:0], b[7:0], ci, real_co[0], out[7:0]);
	rca_8 q1_ci_0(a[15:8], b[15:8], 1'b0, guess_co[0], guess_out[7:0]);
	rca_8 q1_ci_1(a[15:8], b[15:8], 1'b1, guess_co[1], guess_out[15:8]);
	mux select_co_15_0(guess_co[0], guess_co[1], real_co[0], real_co[1]);
	mux8 select_out_15_8(guess_out[7:0], guess_out[15:8], real_co[0], out[15:8]);
		
	
	rca_8 q2_ci_0(a[23:16], b[23:16], 1'b0, guess_co[2], guess_out[23:16]);
	rca_8_ovf q3_q2ci_0_q3ci_0(a[31:24], b[31:24], 1'b0, guess_co[3], guess_ovf[0], guess_out[39:32]);
	rca_8_ovf q3_q2ci_0_q3ci_1(a[31:24], b[31:24], 1'b1, guess_co[4], guess_ovf[1], guess_out[47:40]);
	mux select_co_31_16_ci_0(guess_co[3], guess_co[4], guess_co[2], real_co[2]);
	mux select_ovf_ci_0(guess_ovf[0], guess_ovf[1], guess_co[2], real_ovf[0]);
	mux8 select_out_31_16_ci_0(guess_out[39:32], guess_out[47:40], guess_co[2], guess_out[31:24]);
	
	
	rca_8 q2_ci_1(a[23:16], b[23:16], 1'b1, guess_co[5], guess_out[55:48]);
	rca_8_ovf q3_q2ci_1_q3ci_0(a[31:24], b[31:24], 1'b0, guess_co[6], guess_ovf[2], guess_out[71:64]);
	rca_8_ovf q3_q2ci_1_q3ci_1(a[31:24], b[31:24], 1'b1, guess_co[7], guess_ovf[3], guess_out[79:72]);
	mux select_co_31_16_Ci_1(guess_co[6], guess_co[7], guess_co[5], real_co[3]);
	mux select_ovf_ci_1(guess_ovf[2], guess_ovf[3], guess_co[5], real_ovf[1]);
	mux8 select_out_31_16_ci_1(guess_out[71:64], guess_out[79:72], guess_co[5], guess_out[63:56]);
	
	
	mux select_co(real_co[2], real_co[3], real_co[1], co);
	mux select_ovf(real_ovf[0], real_ovf[1], real_co[1], ovf);
	mux16 select_out_31_16(guess_out[31:16], guess_out[63:48], real_co[1], out[31:16]);
	
endmodule

	
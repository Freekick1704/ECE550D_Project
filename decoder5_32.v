module decoder5_32(t, out);
	input [4:0] t;
	output [31:0] out;
	wire [4:0] f;
	
	not not_gate0(f[0], t[0]);
	not not_gate1(f[1], t[1]);
	not not_gate2(f[2], t[2]);
	not not_gate3(f[3], t[3]);
	not not_gate4(f[4], t[4]);

	and5 my_and5_0(out[0], f[4], f[3], f[2], f[1], f[0]);
	and5 my_and5_1(out[1], f[4], f[3], f[2], f[1], t[0]);
	and5 my_and5_2(out[2], f[4], f[3], f[2], t[1], f[0]);
	and5 my_and5_3(out[3], f[4], f[3], f[2], t[1], t[0]);
	and5 my_and5_4(out[4], f[4], f[3], t[2], f[1], f[0]);
	and5 my_and5_5(out[5], f[4], f[3], t[2], f[1], t[0]);
	and5 my_and5_6(out[6], f[4], f[3], t[2], t[1], f[0]);
	and5 my_and5_7(out[7], f[4], f[3], t[2], t[1], t[0]);
	and5 my_and5_8(out[8], f[4], t[3], f[2], f[1], f[0]);
	and5 my_and5_9(out[9], f[4], t[3], f[2], f[1], t[0]);
	and5 my_and5_10(out[10], f[4], t[3], f[2], t[1], f[0]);
	and5 my_and5_11(out[11], f[4], t[3], f[2], t[1], t[0]);
	and5 my_and5_12(out[12], f[4], t[3], t[2], f[1], f[0]);
	and5 my_and5_13(out[13], f[4], t[3], t[2], f[1], t[0]);
	and5 my_and5_14(out[14], f[4], t[3], t[2], t[1], f[0]);
	and5 my_and5_15(out[15], f[4], t[3], t[2], t[1], t[0]);
	and5 my_and5_16(out[16], t[4], f[3], f[2], f[1], f[0]);
	and5 my_and5_17(out[17], t[4], f[3], f[2], f[1], t[0]);
	and5 my_and5_18(out[18], t[4], f[3], f[2], t[1], f[0]);
	and5 my_and5_19(out[19], t[4], f[3], f[2], t[1], t[0]);
	and5 my_and5_20(out[20], t[4], f[3], t[2], f[1], f[0]);
	and5 my_and5_21(out[21], t[4], f[3], t[2], f[1], t[0]);
	and5 my_and5_22(out[22], t[4], f[3], t[2], t[1], f[0]);
	and5 my_and5_23(out[23], t[4], f[3], t[2], t[1], t[0]);
	and5 my_and5_24(out[24], t[4], t[3], f[2], f[1], f[0]);
	and5 my_and5_25(out[25], t[4], t[3], f[2], f[1], t[0]);
	and5 my_and5_26(out[26], t[4], t[3], f[2], t[1], f[0]);
	and5 my_and5_27(out[27], t[4], t[3], f[2], t[1], t[0]);
	and5 my_and5_28(out[28], t[4], t[3], t[2], f[1], f[0]);
	and5 my_and5_29(out[29], t[4], t[3], t[2], f[1], t[0]);
	and5 my_and5_30(out[30], t[4], t[3], t[2], t[1], f[0]);
	and5 my_and5_31(out[31], t[4], t[3], t[2], t[1], t[0]);

endmodule
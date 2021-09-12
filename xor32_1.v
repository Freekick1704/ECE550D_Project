module xor32_1(a, b, out);
	input [31:0] a;
	input b;
	output [31:0] out;
	generate
	genvar i;
		for (i = 0; i < 32; i = i + 1)
			begin : gen1
				xor xor_gate(out[i], a[i], b);
			end
	endgenerate
endmodule

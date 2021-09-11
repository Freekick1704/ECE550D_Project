module xor32_1(a, b, out);
	input [31:0] a;
	intput b;
	output [31:0] out;
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin
			xor xor_gate(a[i], b, out[i]);
		end
	endgenerate
endmodule

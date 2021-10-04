module tristate(in, ctrl, out);
	input in, ctrl;
	output out;
	assign out = ctrl ? in : 1'bz;
endmodule

module tristate32(in, ctrl, out);
	input ctrl;
	input [31:0] in;
	output [31:0] out;
	generate
		genvar i;
		for (i = 0; i < 32; i = i + 1)
			begin : gen
				tristate my_tristate(in[i], ctrl, out[i]);
			end
	endgenerate
endmodule

module reg32(d, clk, clr, en, q);
	input [31:0] d;
	input clk, clr, en;
	output [31:0] q;
	generate
		genvar i;
		for (i = 0; i < 32; i = i + 1) begin: loop
			my_dffe ff(d[i], clk, clr, en, q[i]);
		end
	endgenerate
endmodule

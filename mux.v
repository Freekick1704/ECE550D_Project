module mux(a, b, s, out);
	input a, b, s;
	output out;
	assign out = s ? b : a;
endmodule

module mux8(a, b, s, out);
	input s;
	input [7:0] a, b;
	output [7:0] out;
	assign out = s ? b : a;
endmodule

module mux16(a, b, s, out);
	input s;
	input [15:0] a, b;
	output [15:0] out;
	assign out = s ? b : a;
endmodule

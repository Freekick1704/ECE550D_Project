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

module mux32(a, b, s, out);
	input s;
	input [31:0] a, b;
	output [31:0] out;
	assign out = s ? b : a;
endmodule

module mux32_4(a, b, c, d, s, out);
	input [1:0] s;
	input [31:0] a, b, c, d;
	output [31:0] out;
	assign out = s[1] ? (s[0] ? d : c) : (s[0] ? b : a);
endmodule

module mux32_5(a, b, c, d, e, opcode, out);
	input [4:0] opcode;
	input [31:0] a, b, c, d, e;
	output [31:0] out;
	wire [31:0] bitwise_op, shift_op;
	mux32 bitwise_mux(b, c, opcode[0], bitwise_op);
	mux32 shift_mux(d, e, opcode[0], shift_op);
	mux32_4 select_op_mux(a, bitwise_op, shift_op, 32'h00000000, opcode[2:1], out);
endmodule

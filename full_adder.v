module full_adder(in0, in1, cin, cout, sum);
	input in0, in1, cin;
	output cout, sum;
	wire e1;
	xor my_xor1(e1, in0, in1);
	xor my_xor2(sum, e1, cin);
	wire e2;
	wire e3;
	and my_and1(e2, e1, cin);
	and my_and2(e3, in0, in1);
	or my_or(cout, e2, e3);
endmodule

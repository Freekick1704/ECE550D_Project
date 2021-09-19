module is_not_zero(a, out);
	input [31:0] a;
	output out;
	wire [15:0] layer0;
	wire [7:0]  layer1;
	wire [3:0]  layer2;
	wire [1:0]  layer3;
	genvar i;
	generate
		for (i = 0; i <= 15; i = i + 1) begin: l0
			or or_gate(layer0[i], a[i + i], a[i + i + 1]);
		end
		for (i = 0; i <= 7; i = i + 1)  begin: l1
			or or_gate(layer1[i], layer0[i + i], layer0[i + i + 1]);
		end
		for (i = 0; i <= 3; i = i + 1)  begin: l2
			or or_gate(layer2[i], layer1[i + i], layer1[i + i + 1]);
		end
		for (i = 0; i <= 1; i = i + 1)  begin: l3
			or or_gate(layer3[i], layer2[i + i], layer2[i + i + 1]);
		end
	endgenerate
	
	or final_or(out, layer3[0], layer3[1]);
	
endmodule

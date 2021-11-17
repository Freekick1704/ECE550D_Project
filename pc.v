module pc(d, clk, rst, en, q, q_plus);
	input [31:0] d;
	input clk, rst, en;
	output reg [31:0] q;
	output reg [31:0] q_plus;
	initial q <= 0;
	always @(posedge clk or posedge rst) begin
		if (rst) 
			q <= 0;
		else if (en) begin
			q = d;
			q_plus = q + 1;
		end
	end
endmodule


module pc_calc(d, q, isJ, isB, bType, bI, jI, isJR, r31);
	input [31:0] d, r31;
	input isJ, isB, bType, isJR;
	input [31:0] bI;
	input [26:0] jI;
	output [31:0] q;
	wire [31:0] jI_32;
	assign jI_32[26:0] = jI;
	assign q = isJ ? (isJR ? r31 : jI_32) : ((bType && isB) ? (d + bI) : d); 
		
endmodule
	

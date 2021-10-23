module pc(clk, rst, en, q);
	input clk, rst, en;
	output reg [31:0] q;
	reg [31:0] d;
	initial d <= 0;
	always @(posedge clk or posedge rst) begin
		if (rst) 
			d <= 0;
		else if (en) begin
			q = d;
			d = d + 1;
		end
	end
endmodule

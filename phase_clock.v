module phase_clock(in_clk, phase, out_clk);
	input in_clk;
	input [2:0] phase;
	output reg out_clk;
	reg [3:0] counter;
	initial counter <= 0;
	always @(posedge in_clk) begin
		if (counter == phase)
			out_clk <= 1;
		else
			out_clk <= 0;
		counter = counter + 1;
		if (counter == 4)
			counter <= 0;
	end		
endmodule

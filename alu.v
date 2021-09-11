module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire ci, co;
	wire [31:0] data_operandB_adjusted;
	assign ci = ctrl_ALUopcode[0];
	xor32_1 adjustB(B, ci, data_operandB_adjuested);
	csa_32 compute(data_operandA, data_operandB_adjusted, ci, co, overflow, data_result);

endmodule

module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire ci, co;
	wire [31:0] data_operandB_adjusted, addsub_result, and_result, or_result, sll_result, sra_result;
	assign ci = ctrl_ALUopcode[0];
	xor32_1 adjustB(data_operandB, ci, data_operandB_adjusted);

	csa_32  compute_addsub(data_operandA, data_operandB_adjusted, ci, co, overflow, addsub_result);
	and32   compute_and32(data_operandA, data_operandB, and_result);
	or32    compute_or32(data_operandA, data_operandB, or_result);
	sll     compute_sll(data_operandA, ctrl_shiftamt, sll_result);
	sra     compute_sra(data_operandA, ctrl_shiftamt, sra_result);
	
	is_not_zero compute_isnotequal(addsub_result, isNotEqual);
	assign  isLessThan = overflow ? data_operandA[31] : addsub_result[31];
	
	mux32_5 select_output(addsub_result, and_result, or_result, sll_result, sra_result, ctrl_ALUopcode, data_result);

	
endmodule

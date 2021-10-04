module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
	wire [31:0] write_select, reg_enable, triA_enable, triB_enable;
	decoder5_32 write_dec(ctrl_writeReg, write_select);
	decoder5_32 read_decA(ctrl_readRegA, triA_enable);
	decoder5_32 read_decB(ctrl_readRegB, triB_enable);
	and and_write0(reg_enable[0], 1'b0, write_select[0]);
	generate
		genvar i;
		for (i = 1; i < 32; i = i + 1)
			begin : gen1
				and and_write(reg_enable[i], ctrl_writeEnable, write_select[i]);
			end
		for (i = 0; i < 32; i = i + 1)
			begin : gen2
				wire [31:0] reg_output;
				reg32 my_reg(data_writeReg, clock, ctrl_reset, reg_enable[i], reg_output);
				tristate32 triA(reg_output, triA_enable[i], data_readRegA);
				tristate32 triB(reg_output, triB_enable[i], data_readRegB);
			end
	endgenerate
endmodule

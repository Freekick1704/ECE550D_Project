# ECE550D_Project

## Group Members

| Name | NetID |
| :----: | :----: |
| Zian Wang | zw142 |
| Jichen Zhang | jz367 |

## Checkpoint 1: Simple ALU

### Design Implementation

We created our 32-bit Carry Select Adder / Subtractor by following the implementation procedures below:

1. Built the base modules: full adder and 2:1 multiplexers (8-bit and 16-bit).
    - Corresponding files: full_adder.v, mux.v
2. Built the 8-bit Ripple Carry Adder (RCA) by connecting 8 full adder blocks in series. We created two types of 8-bit RCA: one containing an overflow bit and the other one not. The overflow bit was obtained from the output of an XOR gate whose input was the carry out of the last full adder and that of the second-to-last full adder. The RCA containing the overflow bit was only used for the addition / subtraction of the highest 8 bits in the 32-bit operands.
    - Corresponding file: rca_8.v
3. Built the 16-bit Carry Select Adder (which was not explicitly defined as a separate module, but was implicitly included as a layer in the implementation of the 32-bit CSA) by making three 8-bit RCAs working in parallel, and using the carry out bit of the RCA for adding the lower 8 bits to select the output sum and carry out of the higher 8 bits through 8-bit 2:1 multiplexers.
4. Built the 32-bit CSA by making three 16-bit CSAs working in parallel, and using the carry out bit of the 16-bit CSA for adding the lower 16 bits to select the output sum, carry out, and overflow bit of the higher 16 bits through 16-bit 2:1 multiplexers.
    - Corresponding file: csa_32.v
5. Added the 32-bit CSA into our ALU. Let each bit of operand B go through an XOR gate, with the other input of each XOR gate being the least significant bit of the ALU opcode (0 for addition and 1 for subtraction) in order to make the 32-bit CSA able to calculate both addition and subtraction. Also let the least significant bit of the ALU opcode connect to the carry in of the 32-bit CSA.
    - Corresponding files: xor32_1.v, alu.v

### Bugs or Issues

Our implementation could successfully pass the testbench through RTL Simulation. By applying Gate Level Simulation, our implementation could successfully pass the testbench when applying "Fast-M 1.2V 0 Model". However, when applying "Slow-7 1.2V 85 Model" or "Slow-7 1.2V 0 Model" in Gate Level Simulation, the running time of our implementation on one of the test cases would exceed 20ns. We are not sure whether this issue matters.

## Checkpoint 2: Full ALU

### Design Implementation

Bitwise AND, OR:

* We implemented bitwise AND / OR by using 32 basic and / or gates. These 32 gates work in parallel. The two inputs of each gate are the corresponding bit of operand A and that of operand B. The output of each gate is one of the 32 bits of the result.
* Corresponding files: and32.v, or32.v

SLL and SRA:

* We implemented SLL and SRA by two-dimensional mux arrays. There are 5 layers of muxes, with each layer consisting of 32 muxes.
* The select bit of each mux in layer n (starts from 1) is bit (n - 1) of ctrl_shiftamt.
* Layer n (starts from 1) shifts the sequence by 0 or 2^(n - 1).
* For SLL, bit 31 - 0 of operand A are connected to the inputs of the muxes in the first layer in a top-down order, and the two inputs of the mux at the bottom of first layer are bit 0 of operand A and a constant 0, as SLL brings in 0s at right when shifting the sequence (logical left shift).
* For SRA, bit 31 - 0 of operand A are connected to the inputs of the muxes in the first layer in a bottom-up order, and the two inputs of the mux at the bottom of first layer are both bit 0 of operand A, as SRA brings in the sign bit at left when shifting the sequence (arithmetic right shift).
* For SLL, bit 31 - 0 of the output is in a top-down order.
* For SRA, bit 31-0 of the output is in a bottom-up order.
* Corresponding files: sll.v, sra.v

Addition / Subtraction:

* Already implemented and illustrated in checkpoint 1. Please refer to checkpoint 1 for details.

Overflow:

* Already implemented and illustrated in checkpoint 1. Please refer to checkpoint 1 for details.

isNotEqual:

* Examine whether the output of the subtraction operation is 0 (32'h00000000).
    - If it is, then isNotEqual is 0.
    - If it is not, then isNotEqual is 1.
* We applied divide-and-conquer strategy in examining whether the output of the subtraction operation is 0.
* Corresponding file: is_not_zero.v

isLessThan:

* First, examine whether there is an overflow for the subtraction operation:
    - If there is an overflow, then isLessThan equals to the highest bit (sign bit) of operand A.
    - If there isn't an overflow, then isLessThan equals to the highest bit (sign bit) of the subtraction result.
* Corresponding file: alu.v

Auxiliaries:

* Added some new mux modules to support selection of more operations based on ctrl_ALUopcode.
* Corresponding file: mux.v

### Bugs or Issues

No bugs or issues are discovered at this moment.

## Checkpoint 3: Regfile

### Design Implementation

Regfile:

* Connected 32 reg32 modules in parallel.
* Used decoder5_32 to get the control bit(w, r1, r2).
* Anded the write control bit with the write enabled bit together as reg32 only takes in one parameter to decide whether it should be overwritten.
* Connected each reading output to the 2 tristate32 modules with r1 and r2 as the read control bit respectively and linked the output wire to the two different reading output.
* Permanently set the write enabled input of register $0 to 0 so as to guarantee the data inside is always 0.
* Corresponding files: regfile.v

decoder5_32:

* Implemented 5-32 decoder based on the bit pattern of the input.
* 5-bit input has 32 different bit patterns, so we first not_gated the input and then enumerated all possible patterns based on (intput, !input) combination by a 5-element and_gate.
* As each 5-bit input is unique, only one bit will be turned on among all the 32 bits in the output.
* Corresponding files: decoder5_32.v

tristate:

* Implemented tristate buffer using ternery operator, if the control input is 1, pass the input through, else return high impedence.
* Connected 32 tristate buffer modules in parallel to form tristate32.
* Corresponding files: tristate.v

my_dffe:

* Followed the design in dffe_ref.v.
* Corresponding files: my_dffe.v

reg32:

* Connected 32 my_dffe modules in parallel.
* Corresponding file: reg32.v

### Bugs or Issues

No bugs or issues are discovered at this moment.

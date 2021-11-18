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

## Checkpoint 3: Register File

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

### Speed

Tested using the "Fast-M 1.2V 0 Model" in Gate Level Simulation, the estimated maximum frequency that our register file can be clocked is about 83.333 MHz (Clock cycle = 12ns).

### Bugs or Issues

No bugs or issues are discovered at this moment.

## Checkpoint 4: Simple Processor

### Design Implementation

skeleton:

* Represents the whole datapath.
* Wraps different components required in a datapath. Links the processor module with instruction memory, data memory, and register file.
* Generates clocks for the processor, instruction memory, data memory, and register file by activating them at different stages of the phase_clock.
* Corresponding file: skeleton.v

processor:

* Parses various instructions read from the instruction memory and executes them.
* Mainly consists of PC and ALU
* Some auxiliaries like multiplexers and the sign extension unit are also included.
* Corresponding file: processor.v

phase_clock:

* Used to generate clocks for the processor, instruction memory, data memory, and register file.
* Separates the input clock cycle into 4 stages. The phase_clock is only asserted during one of the stages, determined by the input parameter.
* Activates the processor at the first stage, the instruction memory at the second stage, and the data memory at the fourth stage (Leaves the third stage unused to reserve enough time for instruction reading and parsing, register file reading, and ALU operations). Let the clock of the register file be the same as the processor clock (both are activated at the first stage) to let the processor execute the next instruction at the same time when the register file is still writing (let these two components work on different instructions in parallel) to increase efficiency.
* Corresponding file: phase_clock.v

pc:

* This module is the program counter.
* Implemented by a 32-bit register.
* Corresponding file: pc.v

sx_17_32:

* This module is the sign extension unit.
* Extends a 17-bit binary sequence to 32 bits by filling the 15 most significant bits of the new 32-bit sequence with the value same as the value of the most significant bit (sign bit) of the original sequence.
* Corresponding file: sx_17_32.v

dmem:

* Data memory generated using syncram
* Corresponding file: dmem.v

imem:

* Instruction memory generated using syncram
* Corresponding file: imem.v

### Bugs or Issues

No bugs or issues are discovered at this moment.


## Checkpoint 5: Full Processor

### Design Implementation

pc:

* Added pc_calc module to support branch and jump.
* Used mux to decide what type of jump/branch to perform and whether to take the jump/branch.
* Moved pc increment logic back to pc register module to resolve the "booting" problem.
* Corresponding file: pc.v

processor:

* Added full opcode parsing for branch/jump.
* Wired ALU ouput(isNotEqual/isLessThan) with pc_calc to support branch.
* Adjusted reading register number and ALUop to tailor for branching.
* Used mux to support instructions related to r30 and r31 read/write.
* Corresponding file: processor.v

### Bugs or Issues

No bugs or issues are discovered at this moment.


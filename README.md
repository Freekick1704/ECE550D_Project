# ECE550D_Project

## Checkpoint 1: addsub-base

### Group Members

| Name | NetID |
| :----: | :----: |
| Zian Wang | zw142 |
| Jichen Zhang | jz367 |

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

Our implementation could successfully pass the testbench through RTL Simulation. By applying Gate Level Simulation, our implementation could successfully pass the testbench when applying "Fast-M 1.2V 0 Model". However, when applying "Slow-7 1.2V 85 Model" or "Slow-7 1.2V 0 Model", the running time of our implementation on one of the test cases would exceed 20ns. We are not sure whether this issue matters.


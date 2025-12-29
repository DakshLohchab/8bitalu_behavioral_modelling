Project Documentation: 8-Bit Signed ALU
1. Abstract
This project involves the design, implementation, and verification of a general-purpose 8-bit Arithmetic Logic Unit (ALU) using Verilog HDL. The design targets industry-standard FPGA architectures (Xilinx Artix-7/Vivado) and supports 14 distinct operations, including signed arithmetic, bitwise logic, and barrel shifts. A key feature of this design is the robust generation of status flags (Zero, Sign, Carry, Overflow) compliant with Two's Complement signed arithmetic rules.
2. Technical Specifications
•	Hardware Description Language: Verilog (IEEE 1364-2005)
•	Target Device: FPGA (General Purpose)
•	Data Width: 8-Bit
•	Architecture: Combinational Logic with Behavioral Modeling
•	Latency: Single-Cycle Execution
3. Features
The ALU serves as the execution core for a simple processor, providing:
•	Arithmetic: ADD, SUB (with full carry/borrow logic).
•	Logic: AND, OR, XOR, NOT, NAND, NOR.
•	Shifting: Logical Left/Right, Arithmetic Right (sign-preserving), and Rotations.
•	Comparison: Signed 'Set Less Than' (SLT) for conditional branching.
•	Status Flags: Z (Zero), S (Sign), C (Carry), V (Overflow).
4. Port Definitions
Port Name	Direction	Width	Description
A	Input	[7:0]	Primary Operand
B	Input	[7:0]	Secondary Operand
Opcode	Input	[3:0]	Operation Selector
Result	Output	[7:0]	Computed Output
Z	Output	1-bit	Zero Flag
S	Output	1-bit	Sign Flag
C	Output	1-bit	Carry Flag
V	Output	1-bit	Overflow Flag
5. Instruction Set Architecture (ISA)
Opcode	Mnemonic	Operation	Description
0000	ADD	A + B	Signed/Unsigned Addition
0001	SUB	A - B	Signed/Unsigned Subtraction
0010	AND	A & B	Bitwise AND
0011	OR	A | B	Bitwise OR
0100	XOR	A ^ B	Bitwise XOR
0101	NOR	~(A | B)	Bitwise NOR
0110	NAND	~(A & B)	Bitwise NAND
0111	NOT	~A	Bitwise NOT
1000	SLT	(A < B)	Set Less Than (Signed Comparison)
1001	SLL	A << 1	Shift Left Logical
1010	SRL	A >> 1	Shift Right Logical
1011	SRA	A >>> 1	Shift Right Arithmetic (Sign Extension)
1100	ROL	Rotate L	Rotate bits left (MSB to LSB)
1101	ROR	Rotate R	Rotate bits right (LSB to MSB)
6. Design Implementation Details
6.1 Flag Logic Strategy
To prevent latch inference and ensure reliable timing, the design utilizes a 'Default-Update Strategy'. All output variables are set to logical 0 at the start of the execution block. The Z and S flags are recalculated at the very end of the block based on the final Result, ensuring they are valid for all 14 operations.
6.2 Overflow (V) Calculation
The Overflow flag is critical for signed arithmetic to detect when a result exceeds the 8-bit signed range (-128 to +127). It is calculated using the formula: V = ~(A[7] ^ B[7]) & (A[7] ^ Result[7]). This logic detects if two operands of the same sign produce a result of the opposite sign.
6.3 Arithmetic Shift Right (SRA)
Unlike a logical shift which fills with zeros, the SRA operation preserves the sign bit to maintain the mathematical validity of dividing negative numbers by 2. Implementation: Result = {A[7], A[7:1]}.
7. Verification Results
The design was verified using Xilinx Vivado Simulator. Key test vectors passed include:
•	Signed Overflow: 127 + 1 = -128 (V flag triggered High).
•	Zero Detection: 5 - 5 = 0 (Z flag triggered High).
•	Signed Comparison: -5 < 5 (Result = 1).
•	Shift Carry: 128 << 1 (Result = 0, C flag triggered High).
8. Conclusion
The 8-bit ALU successfully meets all design requirements. It provides a complete set of integer operations suitable for microcontroller datapaths and has been verified to correctly handle edge cases in signed arithmetic.

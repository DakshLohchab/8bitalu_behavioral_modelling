`timescale 1ns / 1ps
module alultb(

    );
    reg [7:0] A,B;
    reg [3:0] opcode;
    wire [7:0] Result;
    wire Z,S,C,V;
    
    alu dut(A,B,opcode,Result,Z,S,C,V);
    
    initial begin
         $monitor("Time=%0t | opcode=%b  | A=%d |B=%d | Result = %d | Flags[ZSCV]=%b%b%b%b",$time,opcode,A,B,Result,Z,S,C,V);
        {A,B,opcode}=0;
        #10
        // --- TEST 1: ADD (10 + 5) ---
        opcode = 4'b0000; A = 10; B = 5;
        #10; 

        // --- TEST 2: OVERFLOW (127 + 1) ---
        opcode = 4'b0000; A = 127; B = 1;
        #10;

        // --- TEST 3: SUBTRACT (20 - 5) ---
        opcode = 4'b0001; A = 20; B = 5;
        #10;

        // --- TEST 4: BITWISE AND (12 & 10) ---
        opcode = 4'b0010; A = 12; B = 10;
        #10;

        // --- TEST 5: SHIFT LEFT (128 << 1) ---
        opcode = 4'b1011; A = 8'b10000000; B = 0; // B is unused in Shift
        #10;

        // --- TEST 6: SHIFT RIGHT ARITHMETIC (-4 >> 1) ---
        opcode = 4'b1101; A = 8'b11111100; // -4
        #10;

        // --- TEST 7: SET LESS THAN (-5 < 5) ---
        opcode = 4'b1000; A = -5; B = 5;
        #10;

        $finish;
        end
   
endmodule

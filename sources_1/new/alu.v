`timescale 1ns / 1ps
module alu(
    input [7:0]A,B,input [3:0]opcode,output reg [7:0]Result,output reg Z,S,C,V
    );
    reg [8:0] temp;
    
    always @(*) begin
        temp = 9'b0;
        V = 0;C=0;S=0;Z=0;
        case(opcode)
            4'b0000: begin //ADD 
                    temp ={1'b0, A}+{1'b0,B};
                    Result = temp[7:0];
                    C = temp[8];
                    V = ~(A[7]^B[7])&(A[7]^temp[7]);
                    end 
            4'b0001: begin //SUB
                    temp = {1'b0,A}-{1'b0,B};
                    Result = temp[7:0];
                    C = temp[8];
                    V = (A[7]^B[7])&(A[7]^temp[7]);
                    end
                    //Bitwise Operation
            4'b0010: Result = A&B ;//AND operation
            4'b0011: Result = A|B ;//OR operation
            4'b0100: Result = A^B; //XOR operation
            4'b0101: Result = ~(A|B);//NOR operation
            4'b0110: Result = ~(A&B);//NAND operation
            4'b0111: Result = ~A; //NOT operation
            
                   // Comparison Operation
            4'b1000: Result = ($signed(A)<$signed(B)) ? 8'b1:8'b0; //SLT operation
                   // Shift Operation
            4'b1001:  begin   //SLL
                            Result =  A <<1;
                            C = A[7];
                      end
            4'b1010: begin //SLR
                            Result = A>>1;
                            C = A[0];
                     end
            4'b1011: begin //SRA
                            Result = {A[7],A[7:1]};
                            C = A[0];
                     end
            4'b1100: Result = {A[6:0],A[7]}; //ROL
            4'b1101: Result = {A[0],A[7:1]}; //ROR   
             endcase 
      Z = (Result==8'b0);
      S = Result[7];
      end       
endmodule

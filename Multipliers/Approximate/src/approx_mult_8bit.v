`timescale 1ns / 1ps

module approx_mult_8bit #(
    parameter ADDER_SEL = 0
)(
    input  wire [7:0]  A,
    input  wire [7:0]  B,
    output wire [15:0] Z
);

    wire [7:0] K,L,M,N;

    approx_mult_4bit #(.ADDER_SEL(ADDER_SEL)) U0(A[3:0],B[3:0],K);
    approx_mult_4bit #(.ADDER_SEL(ADDER_SEL)) U1(A[7:4],B[3:0],L);
    approx_mult_4bit #(.ADDER_SEL(ADDER_SEL)) U2(A[3:0],B[7:4],M);
    approx_mult_4bit #(.ADDER_SEL(ADDER_SEL)) U3(A[7:4],B[7:4],N);

    assign Z =
        {8'b0,K} +
        {4'b0,L,4'b0} +
        {4'b0,M,4'b0} +
        {N,8'b0};

endmodule



module approx_mult_4bit #(
    parameter ADDER_SEL = 0   // 0=RCA,1=CSA,2=CSLA,3=COSA
)(
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [7:0] Y
);

    wire P0  = A[0]&B[0];
    wire P1  = A[1]&B[0];
    wire P2  = A[2]&B[0];
    wire P3  = A[3]&B[0];

    wire P4  = A[0]&B[1];
    wire P5  = A[1]&B[1];
    wire P6  = A[2]&B[1];
    wire P7  = A[3]&B[1];

    wire P8  = A[0]&B[2];
    wire P9  = A[1]&B[2];
    wire P10 = A[2]&B[2];
    wire P11 = A[3]&B[2];

    wire P12 = A[0]&B[3];
    wire P13 = A[1]&B[3];
    wire P14 = A[2]&B[3];
    wire P15 = A[3]&B[3];

    // Approximate LSBs
    assign Y[0] = P0;
    assign Y[1] = P1 ^ P4;
    assign Y[2] = P2 ^ P5 ^ P8;

    wire s1,c1,s2,c2,s3,c3;

    generate
        if (ADDER_SEL == 0 || ADDER_SEL == 2) begin
            exact_fa FA1(P10,P11,P6,s2,c2);
            exact_fa FA2(P13,P9,P12,s3,c3);
            exact_fa FA3(P14,P15,1'b0,s1,c1);
        end
        else if (ADDER_SEL == 1) begin
            csa_fa FA1(P10,P11,P6,s2,c2);
            csa_fa FA2(P13,P9,P12,s3,c3);
            csa_fa FA3(P14,P15,1'b0,s1,c1);
        end
        else begin
            approx_fa FA1(P10,P11,P6,s2,c2);
            approx_fa FA2(P13,P9,P12,s3,c3);
            approx_fa FA3(P14,P15,1'b0,s1,c1);
        end
    endgenerate

    wire [4:0] S =
        {1'b0,c1,c2,c3,P3} +
        {1'b0,s1,s2,s3,P7};

    assign Y[6:3] = S[3:0];
    assign Y[7]   = S[4];

endmodule



module exact_fa(input a,b,cin, output sum,carry);
    assign sum   = a ^ b ^ cin;
    assign carry = (a & b) | (a & cin) | (b & cin);
endmodule

module csa_fa(input a,b,cin, output sum,carry);
    assign sum   = a ^ b ^ cin;
    assign carry = (a & b) | (a & cin) | (b & cin);
endmodule

module approx_fa(input a,b,cin, output sum,carry);
    assign sum   = a ^ b;      // approximation
    assign carry = a & b;
endmodule


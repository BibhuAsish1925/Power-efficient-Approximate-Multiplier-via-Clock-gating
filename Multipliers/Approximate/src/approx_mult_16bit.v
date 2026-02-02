`timescale 1ns / 1ps


module approx_mult_16bit #(
    parameter ADDER_SEL = 0   // propagated to lower levels
)(
    input  wire [15:0] A,
    input  wire [15:0] B,
    output wire [31:0] Z
);

    // -----------------------------------
    // Split inputs
    // -----------------------------------
    wire [7:0] A_lo = A[7:0];
    wire [7:0] A_hi = A[15:8];
    wire [7:0] B_lo = B[7:0];
    wire [7:0] B_hi = B[15:8];

    // -----------------------------------
    // 8-bit Approximate Multipliers
    // -----------------------------------
    wire [15:0] K;  // A_lo × B_lo
    wire [15:0] L;  // A_hi × B_lo
    wire [15:0] M;  // A_lo × B_hi
    wire [15:0] N;  // A_hi × B_hi

    approx_mult_8bit #(.ADDER_SEL(ADDER_SEL)) U0 (
        .A(A_lo), .B(B_lo), .Z(K)
    );

    approx_mult_8bit #(.ADDER_SEL(ADDER_SEL)) U1 (
        .A(A_hi), .B(B_lo), .Z(L)
    );

    approx_mult_8bit #(.ADDER_SEL(ADDER_SEL)) U2 (
        .A(A_lo), .B(B_hi), .Z(M)
    );

    approx_mult_8bit #(.ADDER_SEL(ADDER_SEL)) U3 (
        .A(A_hi), .B(B_hi), .Z(N)
    );

    // -----------------------------------
    // Shifted partial sums
    // -----------------------------------
    wire [31:0] K_ext = {16'b0, K};
    wire [31:0] L_ext = {8'b0,  L, 8'b0};
    wire [31:0] M_ext = {8'b0,  M, 8'b0};
    wire [31:0] N_ext = {N, 16'b0};

    // -----------------------------------
    // Final accumulation (exact)
    // -----------------------------------
    assign Z = K_ext + L_ext + M_ext + N_ext;

endmodule


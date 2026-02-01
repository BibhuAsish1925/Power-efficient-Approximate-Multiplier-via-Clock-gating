`timescale 1ns / 1ps

module clock_gated_approx_mult_4bit (
    input  wire        clk,
    input  wire        rst,
    input  wire        en,   // CLOCK ENABLE
    input  wire [3:0]  A,
    input  wire [3:0]  B,
    output reg  [7:0]  Y
);

    wire [7:0] Y_comb;

    approx_mult_4bit U1 (
        .A(A),
        .B(B),
        .Y(Y_comb)
    );

    always @(negedge clk) begin
        if (rst)
            Y <= 8'd0;
        else if (en)
            Y <= Y_comb;   // gated update
    end

endmodule



module approx_mult_4bit (
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [7:0] Y
);

    wire P0  = A[0] & B[0];
    wire P1  = A[1] & B[0];
    wire P2  = A[2] & B[0];
    wire P3  = A[3] & B[0];

    wire P4  = A[0] & B[1];
    wire P5  = A[1] & B[1];
    wire P6  = A[2] & B[1];
    wire P7  = A[3] & B[1];

    wire P8  = A[0] & B[2];
    wire P9  = A[1] & B[2];
    wire P10 = A[2] & B[2];
    wire P11 = A[3] & B[2];

    wire P12 = A[0] & B[3];
    wire P13 = A[1] & B[3];
    wire P14 = A[2] & B[3];
    wire P15 = A[3] & B[3];

    assign Y[0] = P0;
    assign Y[1] = P1 ^ P4;
    assign Y[2] = P2 ^ P5 ^ P8;

    wire s1,c1,s2,c2,s3,c3;

    approximate_half_adder HA  (P14, P15, s1, c1);
    approximate_full_adder FA1 (P10, P11, P6,  s2, c2);
    approximate_full_adder FA2 (P13, P9,  P12, s3, c3);

    wire [3:0] X = {c1, c2, c3, P3};
    wire [3:0] Y1= {s1, s2, s3, P7};

    wire [4:0] S = X + Y1;

    assign Y[6:3] = S[3:0];
    assign Y[7]   = S[4];

endmodule


module approximate_full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire carry
);
    assign sum   = a ^ b;   // cin ignored (approximation)
    assign carry = a & b;
endmodule



module approximate_half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule


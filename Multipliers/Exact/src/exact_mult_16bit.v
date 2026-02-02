`timescale 1ns / 1ps

module exact_mult_16bit (
    input  wire [15:0] A,
    input  wire [15:0] B,
    output wire [31:0] Y
);

    wire [7:0] AL = A[7:0];
    wire [7:0] AH = A[15:8];
    wire [7:0] BL = B[7:0];
    wire [7:0] BH = B[15:8];

    wire [15:0] P0, P1, P2, P3;

    exact_mult_8bit M0 (AL, BL, P0);
    exact_mult_8bit M1 (AH, BL, P1);
    exact_mult_8bit M2 (AL, BH, P2);
    exact_mult_8bit M3 (AH, BH, P3);

    assign Y =
          {16'b0, P0}
        + ({8'b0,  P1, 8'b0})
        + ({8'b0,  P2, 8'b0})
        + ({P3, 16'b0});

endmodule


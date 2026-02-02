`timescale 1ns / 1ps

module exact_mult_8bit (
    input  wire [7:0] A,
    input  wire [7:0] B,
    output wire [15:0] Y
);

    wire [3:0] AL = A[3:0];
    wire [3:0] AH = A[7:4];
    wire [3:0] BL = B[3:0];
    wire [3:0] BH = B[7:4];

    wire [7:0] P0, P1, P2, P3;

    exact_mult_4bit M0 (AL, BL, P0);
    exact_mult_4bit M1 (AH, BL, P1);
    exact_mult_4bit M2 (AL, BH, P2);
    exact_mult_4bit M3 (AH, BH, P3);

    assign Y =
          {8'b0, P0}
        + ({4'b0, P1, 4'b0})
        + ({4'b0, P2, 4'b0})
        + ({P3, 8'b0});

endmodule


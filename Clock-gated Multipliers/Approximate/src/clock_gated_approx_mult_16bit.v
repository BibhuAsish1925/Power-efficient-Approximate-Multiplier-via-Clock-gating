`timescale 1ns / 1ps

module clock_gated_approx_mult_16bit (
    input  wire         clk,
    input  wire         rst,
    input  wire         en,       // clock enable
    input  wire [15:0]  A,
    input  wire [15:0]  B,
    output reg  [31:0]  Y
);

    wire [7:0] AL = A[7:0];
    wire [7:0] AH = A[15:8];
    wire [7:0] BL = B[7:0];
    wire [7:0] BH = B[15:8];

    wire [15:0] P0, P1, P2, P3;

    clock_gated_approx_mult_8bit M0 (clk, rst, en, AL, BL, P0);
    clock_gated_approx_mult_8bit M1 (clk, rst, en, AH, BL, P1);
    clock_gated_approx_mult_8bit M2 (clk, rst, en, AL, BH, P2);
    clock_gated_approx_mult_8bit M3 (clk, rst, en, AH, BH, P3);

    wire [31:0] Y_comb;
    assign Y_comb =
          {16'b0, P0}
        + ({8'b0,  P1, 8'b0})
        + ({8'b0,  P2, 8'b0})
        + ({P3, 16'b0});

    always @(negedge clk) begin
        if (rst)
            Y <= 32'd0;
        else if (en)
            Y <= Y_comb;
    end

endmodule

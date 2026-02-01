`timescale 1ns / 1ps

module clock_gated_exact_mult_4bit (
    input  wire        clk,
    input  wire        rst,
    input  wire        en,      // clock enable
    input  wire [3:0]  A,
    input  wire [3:0]  B,
    output reg  [7:0]  Y
);

    wire [7:0] pp0, pp1, pp2, pp3;
    wire [7:0] Y_comb;

    assign pp0 = B[0] ? {4'b0, A}       : 8'b0;
    assign pp1 = B[1] ? {3'b0, A, 1'b0} : 8'b0;
    assign pp2 = B[2] ? {2'b0, A, 2'b0} : 8'b0;
    assign pp3 = B[3] ? {1'b0, A, 3'b0} : 8'b0;

    assign Y_comb = pp0 + pp1 + pp2 + pp3;

    always @(negedge clk) begin
        if (rst)
            Y <= 8'd0;
        else if (en)
            Y <= Y_comb;
    end

endmodule


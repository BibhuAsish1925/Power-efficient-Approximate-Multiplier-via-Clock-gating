`timescale 1ns / 1ps

module exact_mult_4bit (
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [7:0] Y
);

    wire [7:0] pp [3:0];

    assign pp[0] = B[0] ? {4'b0, A}       : 8'b0;
    assign pp[1] = B[1] ? {3'b0, A, 1'b0} : 8'b0;
    assign pp[2] = B[2] ? {2'b0, A, 2'b0} : 8'b0;
    assign pp[3] = B[3] ? {1'b0, A, 3'b0} : 8'b0;

    assign Y = pp[0] + pp[1] + pp[2] + pp[3];

endmodule


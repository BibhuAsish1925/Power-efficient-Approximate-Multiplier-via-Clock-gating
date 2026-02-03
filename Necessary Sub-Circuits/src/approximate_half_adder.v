`timescale 1ns / 1ps

module approximate_half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);

assign sum   = a | b;    // approximated sum
assign carry = a & b;

endmodule


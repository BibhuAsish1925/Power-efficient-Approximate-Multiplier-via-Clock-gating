`timescale 1ns / 1ps

module approximate_full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);

assign sum  = a ^ b ^ cin;
assign cout = a | b;      // simplified carry

endmodule


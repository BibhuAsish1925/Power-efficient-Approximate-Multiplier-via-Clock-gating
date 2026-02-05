`timescale 1ns / 1ps

module approximate_full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);

assign cout  = (a & b) | (b & cin) | (a & cin);
assign sum = ~cout;      // simplified carry

endmodule


`timescale 1ns / 1ps

//Parameterized Carry Select Adder (CSLA) using param_half_adder and param_full_adder

module param_csla #(
    parameter WIDTH = 8,
    parameter APPROX = 0
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             cin,
    output wire [WIDTH-1:0] sum,
    output wire             cout
);

wire [WIDTH-1:0] sum0, sum1;
wire cout0, cout1;

// RCA assuming carry-in = 0
param_rca #(
    .WIDTH(WIDTH),
    .APPROX(APPROX)
) rca0 (
    .a(a),
    .b(b),
    .cin(1'b0),
    .sum(sum0),
    .cout(cout0)
);

// RCA assuming carry-in = 1
param_rca #(
    .WIDTH(WIDTH),
    .APPROX(APPROX)
) rca1 (
    .a(a),
    .b(b),
    .cin(1'b1),
    .sum(sum1),
    .cout(cout1)
);

// Multiplexer logic to select correct result
assign sum  = (cin == 1'b0) ? sum0  : sum1;
assign cout = (cin == 1'b0) ? cout0 : cout1;

endmodule


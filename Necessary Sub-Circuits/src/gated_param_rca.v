`timescale 1ns / 1ps

module gated_param_rca #(
    parameter WIDTH = 8,
    parameter APPROX = 0
)(
    input  wire clk,
    input  wire rst,
    input  wire enable,
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire cin,
    output wire [WIDTH-1:0] sum,
    output wire cout
);

wire gated_clk;

// Instantiate clock gating
clock_gating_cell CG (
    .clk(clk),
    .enable(enable),
    .rst(rst),
    .gated_clk(gated_clk)
);

// RCA works on gated clock
param_rca #(
    .WIDTH(WIDTH),
    .APPROX(APPROX)
) RCA (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

endmodule


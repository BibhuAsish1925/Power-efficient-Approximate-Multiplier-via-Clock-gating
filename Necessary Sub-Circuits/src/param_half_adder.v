`timescale 1ns / 1ps

module param_half_adder #(
    parameter APPROX = 0
)(
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);

generate
    if (APPROX == 0) begin
        assign sum   = a ^ b;   // exact
        assign carry = a & b;
    end
    else begin
        assign sum   = a | b;   // approximate
        assign carry = a & b;
    end
endgenerate

endmodule

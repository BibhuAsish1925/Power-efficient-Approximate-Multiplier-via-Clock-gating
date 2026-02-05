`timescale 1ns / 1ps

module param_full_adder #(
    parameter APPROX = 1   //0=exact, 1=full
)(
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);

generate
    if (APPROX == 0) begin
        assign sum  = a ^ b ^ cin;
        assign cout = (a & b) | (b & cin) | (a & cin);
    end
    else begin
        assign sum = ~cout;
        assign cout = (a & b) | (b & cin) | (cin & a);
    end
endgenerate

endmodule


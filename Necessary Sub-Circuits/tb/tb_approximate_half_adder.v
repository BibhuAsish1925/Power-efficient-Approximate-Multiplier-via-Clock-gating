`timescale 1ns / 1ps

module tb_approximate_half_adder;

reg a, b;
wire sum, carry;

approximate_half_adder uut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

initial begin
    $display("A B | SUM CARRY");

    a=0; b=0; #10;
    $display("%b %b |  %b   %b", a,b,sum,carry);

    a=0; b=1; #10;
    $display("%b %b |  %b   %b", a,b,sum,carry);

    a=1; b=0; #10;
    $display("%b %b |  %b   %b", a,b,sum,carry);

    a=1; b=1; #10;
    $display("%b %b |  %b   %b", a,b,sum,carry);

    $finish;
end

endmodule


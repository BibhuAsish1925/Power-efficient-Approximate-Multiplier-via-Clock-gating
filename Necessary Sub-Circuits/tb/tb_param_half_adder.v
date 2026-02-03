`timescale 1ns / 1ps

module tb_param_half_adder;

reg a, b;
wire sum_exact, sum_approx;
wire carry_exact, carry_approx;

param_half_adder #(.APPROX(0)) HA_exact (
    .a(a), .b(b),
    .sum(sum_exact),
    .carry(carry_exact)
);

param_half_adder #(.APPROX(1)) HA_approx (
    .a(a), .b(b),
    .sum(sum_approx),
    .carry(carry_approx)
);

initial begin
    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
end

endmodule


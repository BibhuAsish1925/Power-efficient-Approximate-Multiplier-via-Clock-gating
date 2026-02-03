`timescale 1ns / 1ps

module tb_param_full_adder;

reg a, b, cin;
wire sum_exact, cout_exact;
wire sum_approx, cout_approx;

param_full_adder #(.APPROX(0)) FA_exact (
    .a(a), .b(b), .cin(cin),
    .sum(sum_exact),
    .cout(cout_exact)
);

param_full_adder #(.APPROX(1)) FA_approx (
    .a(a), .b(b), .cin(cin),
    .sum(sum_approx),
    .cout(cout_approx)
);

initial begin
    a=0; b=0; cin=0; #10;
    a=0; b=0; cin=1; #10;
    a=0; b=1; cin=0; #10;
    a=0; b=1; cin=1; #10;
    a=1; b=0; cin=0; #10;
    a=1; b=0; cin=1; #10;
    a=1; b=1; cin=0; #10;
    a=1; b=1; cin=1; #10;
    $finish;
end

endmodule


`timescale 1ns / 1ps

module tb_param_csa;

parameter WIDTH = 8;

reg  [WIDTH-1:0] a, b, c;

wire [WIDTH-1:0] sum_exact, carry_exact;
wire [WIDTH-1:0] sum_approx, carry_approx;

// Exact CSA Instance
param_csa #(
    .WIDTH(WIDTH),
    .APPROX(0)
) exact_csa (
    .a(a),
    .b(b),
    .c(c),
    .sum(sum_exact),
    .carry(carry_exact)
);

// Approximate CSA Instance
param_csa #(
    .WIDTH(WIDTH),
    .APPROX(1)
) approx_csa (
    .a(a),
    .b(b),
    .c(c),
    .sum(sum_approx),
    .carry(carry_approx)
);

initial begin

    $display("A        B        C        | Exact SUM | Approx SUM");

    a = 8'b00001111;
    b = 8'b00000011;
    c = 8'b00000101;
    #10;

    $display("%b %b %b | %b | %b", a, b, c, sum_exact, sum_approx);

    a = 8'b10101010;
    b = 8'b01010101;
    c = 8'b11110000;
    #10;

    $display("%b %b %b | %b | %b", a, b, c, sum_exact, sum_approx);

    a = 8'b11111111;
    b = 8'b00000001;
    c = 8'b00000001;
    #10;

    $display("%b %b %b | %b | %b", a, b, c, sum_exact, sum_approx);

    $finish;
end

endmodule


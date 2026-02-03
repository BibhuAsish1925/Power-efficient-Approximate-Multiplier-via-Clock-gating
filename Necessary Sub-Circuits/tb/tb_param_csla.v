`timescale 1ns / 1ps

module tb_param_csla;

parameter WIDTH = 8;

reg  [WIDTH-1:0] a, b;
reg              cin;

wire [WIDTH-1:0] sum_exact, sum_approx;
wire cout_exact, cout_approx;

// Exact CSLA
param_csla #(
    .WIDTH(WIDTH),
    .APPROX(0)
) exact_csla (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum_exact),
    .cout(cout_exact)
);

// Approximate CSLA
param_csla #(
    .WIDTH(WIDTH),
    .APPROX(1)
) approx_csla (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum_approx),
    .cout(cout_approx)
);

initial begin

    $display("A        B        | Exact SUM | Approx SUM");

    cin = 0;

    a = 8'b00001111;
    b = 8'b00000011;
    #10;

    $display("%b %b | %b | %b", a, b, sum_exact, sum_approx);

    a = 8'b10101010;
    b = 8'b01010101;
    #10;

    $display("%b %b | %b | %b", a, b, sum_exact, sum_approx);

    a = 8'b11110000;
    b = 8'b00001111;
    #10;

    $display("%b %b | %b | %b", a, b, sum_exact, sum_approx);

    a = 8'b11111111;
    b = 8'b00000001;
    #10;

    $display("%b %b | %b | %b", a, b, sum_exact, sum_approx);

    $finish;
end

endmodule

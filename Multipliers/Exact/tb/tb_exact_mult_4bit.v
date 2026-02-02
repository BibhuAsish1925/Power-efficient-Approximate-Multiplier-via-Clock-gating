`timescale 1ns / 1ps

module tb_exact_mult_4bit;

    reg  [3:0] A, B;
    wire [7:0] Y;

    exact_mult_4bit DUT (.A(A), .B(B), .Y(Y));

    initial begin
        A=3;  B=3;   #10; // 9
        A=5;  B=4;   #10; // 20
        A=7;  B=7;   #10; // 49
        A=15; B=15;  #10; // 225
        $finish;
    end

endmodule

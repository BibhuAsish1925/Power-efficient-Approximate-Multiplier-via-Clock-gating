`timescale 1ns / 1ps

module tb_exact_mult_16bit;

    reg  [15:0] A, B;
    wire [31:0] Y;

    exact_mult_16bit DUT (.A(A), .B(B), .Y(Y));

    initial begin
        A=16'd20;    B=16'd10;    #10; // 200
        A=16'd100;   B=16'd25;    #10; // 2500
        A=16'd1024;  B=16'd8;     #10; // 8192
        A=16'd65535; B=16'd2;     #10; // 131070
        $finish;
    end

endmodule

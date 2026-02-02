`timescale 1ns / 1ps

module tb_exact_mult_8bit;

    reg  [7:0] A, B;
    wire [15:0] Y; 

    exact_mult_8bit DUT (.A(A), .B(B), .Y(Y));

    initial begin
        A=8'd10;  B=8'd5;    #10; // 50
        A=8'd25;  B=8'd4;    #10; // 100
        A=8'd50;  B=8'd10;   #10; // 500
        A=8'd255; B=8'd255;  #10; // 65025
        $finish;
    end

endmodule

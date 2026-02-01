`timescale 1ns / 1ps

module tb_clock_gated_exact_mult_4bit;

    reg clk, rst, en;
    reg [3:0] A, B;
    wire [7:0] Y;

    clock_gated_exact_mult_4bit DUT (
        .clk(clk), .rst(rst), .en(en), .A(A), .B(B), .Y(Y)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; en = 0; A = 0; B = 0;
        #10 rst = 0;

        en = 1;
        A = 4'd3;  B = 4'd3;   #10; // 9
        A = 4'd7;  B = 4'd7;   #10; // 49
        A = 4'd12; B = 4'd11;  #10; // 132
        A = 4'd15; B = 4'd15;  #10; // 225

        en = 0;
        A = 4'd5;  B = 4'd5;   #20; // hold

        en = 1;
        A = 4'd6;  B = 4'd6;   #10; // 36

        $finish;
    end

endmodule

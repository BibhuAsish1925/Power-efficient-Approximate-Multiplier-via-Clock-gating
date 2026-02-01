`timescale 1ns / 1ps

module tb_clock_gated_approx_mult_4bit;

    reg clk, rst, en;
    reg [3:0] A, B;
    wire [7:0] Y;

    clock_gated_approx_mult_4bit DUT (
        .clk(clk),
        .rst(rst),
        .en(en),
        .A(A),
        .B(B),
        .Y(Y)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        en  = 0;
        A = 0; B = 0;

        #10 rst = 0;

        en = 1;
        A=3;  B=3;  #10;
        A=7;  B=7;  #10;
        A=9;  B=3;  #10;
        A=13; B=13; #10;

        en = 0; // HOLD
        A=15; B=15; #20;
        A=3;  B=3;  #20;

        en = 1;
        A=5; B=2; #10;

        $finish;
    end

endmodule

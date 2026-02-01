`timescale 1ns / 1ps

module tb_clock_gated_exact_mult_8bit;

    reg clk, rst, en;
    reg [7:0] A, B;
    wire [15:0] Y;

    clock_gated_exact_mult_8bit DUT (
        .clk(clk), .rst(rst), .en(en), .A(A), .B(B), .Y(Y)
    );

    always #5 clk = ~clk;

    initial begin
        clk=0; rst=1; en=0; A=0; B=0;
        #10 rst=0;

        en=1;
        A=8'd10;  B=8'd5;    #10; // 50
        A=8'd25;  B=8'd4;    #10; // 100
        A=8'd50;  B=8'd10;   #10; // 500
        A=8'd255; B=8'd255;  #10; // 65025

        en=0;
        A=8'd100; B=8'd100;  #20;

        en=1;
        A=8'd12;  B=8'd12;   #10; // 144

        $finish;
    end

endmodule

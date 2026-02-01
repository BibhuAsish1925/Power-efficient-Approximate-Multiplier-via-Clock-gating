`timescale 1ns / 1ps

module tb_clock_gated_approx_mult_16bit;

    reg clk;
    reg rst;
    reg en;
    reg [15:0] A, B;
    wire [31:0] Y;

    // DUT
    clock_gated_approx_mult_16bit DUT (
        .clk(clk),
        .rst(rst),
        .en(en),
        .A(A),
        .B(B),
        .Y(Y)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        en  = 0;
        A   = 0;
        B   = 0;

        #10 rst = 0;

        // Enable ON → output updates
        en = 1;
        A = 16'd20;    B = 16'd10;    #10;   // ~200
        A = 16'd100;   B = 16'd25;    #10;   // ~2500
        A = 16'd256;   B = 16'd16;    #10;   // ~4096
        A = 16'd1024;  B = 16'd8;     #10;   // ~8192

        // Disable → output should HOLD
        en = 0;
        A = 16'd65535; B = 16'd65535; #20;
        A = 16'd5000;  B = 16'd3000;  #20;

        // Enable again
        en = 1;
        A = 16'd15;    B = 16'd15;    #10;

        $finish;
    end

endmodule

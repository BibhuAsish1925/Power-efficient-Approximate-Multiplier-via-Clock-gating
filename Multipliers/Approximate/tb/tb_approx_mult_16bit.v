`timescale 1ns / 1ps

module tb_approx_mult_16bit;

    reg  [15:0] A, B;
    wire [31:0] Z;

    approx_mult_16bit #(.ADDER_SEL(0)) DUT (
        .A(A), .B(B), .Z(Z)
    );

    initial begin
        A = 16'd15;   B = 16'd15;    #10;
        A = 16'd100;  B = 16'd50;    #10;
        A = 16'd255;  B = 16'd255;   #10;
        A = 16'd1000; B = 16'd200;   #10;
        A = 16'd65535;B = 16'd65535; #10;
        A = 16'd2987; B = 16'd50763; #10;
        $finish;
    end

endmodule


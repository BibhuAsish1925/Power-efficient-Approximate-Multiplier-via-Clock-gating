`timescale 1ns / 1ps

module tb_approx_mult_4bit;

    reg  [3:0] A, B;
    wire [7:0] Y_rca, Y_csa, Y_csla, Y_cosa;

    approx_mult_4bit #(.ADDER_SEL(0)) DUT_RCA  (.A(A), .B(B), .Y(Y_rca));
    approx_mult_4bit #(.ADDER_SEL(1)) DUT_CSA  (.A(A), .B(B), .Y(Y_csa));
    approx_mult_4bit #(.ADDER_SEL(2)) DUT_CSLA (.A(A), .B(B), .Y(Y_csla));
    approx_mult_4bit #(.ADDER_SEL(3)) DUT_COSA (.A(A), .B(B), .Y(Y_cosa));

    initial begin
        A = 0; B = 0;
        repeat (10) begin
            #10;
            A = $random % 16;
            B = $random % 16;
        end
        #20 $finish;
    end

endmodule



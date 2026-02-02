module tb_approx_mult_8bit;

    reg  [7:0] A, B;
    wire [15:0] Z;

    approx_mult_8bit #(.ADDER_SEL(0)) DUT (
        .A(A), .B(B), .Z(Z)
    );

    initial begin
        A = 8'd15;  B = 8'd15;  #10;
        A = 8'd25;  B = 8'd10;  #10;
        A = 8'd50;  B = 8'd20;  #10;
        A = 8'd100; B = 8'd50;  #10;
        A = 8'd255; B = 8'd255; #10;
        $finish;
    end

endmodule


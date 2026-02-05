`timescale 1ns / 1ps

//Parameterized Carry Save Adder (CSA) using param_half_adder and param_full_adder

module param_csa #(
    parameter WIDTH = 8,
    parameter APPROX = 1    //0=exact, 1=full
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire [WIDTH-1:0] c,
    output wire [WIDTH-1:0] sum,
    output wire [WIDTH-1:0] carry
);

genvar i;

generate
    for (i = 0; i < WIDTH; i = i + 1) begin : CSA_STAGE

        if (APPROX == 0) begin
            // EXACT FULL ADDER
            param_full_adder #(
                .APPROX(0)
            ) FA (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .sum(sum[i]),
                .cout(carry[i])
            );
        end
        else begin
            // APPROXIMATE FULL ADDER
            param_full_adder #(
                .APPROX(1)
            ) AFA (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .sum(sum[i]),
                .cout(carry[i])
            );
        end

    end
endgenerate

endmodule


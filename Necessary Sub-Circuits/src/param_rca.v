`timescale 1ns / 1ps

//Parameterized Ripple Carry Adder (RCA) using param_half_adder and param_full_adder

module param_rca #(
    parameter WIDTH = 8,
    parameter APPROX = 1   //0=exact, 1=full
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire cin,
    output wire [WIDTH-1:0] sum,
    output wire cout
);

wire [WIDTH:0] carry;

assign carry[0] = cin;

genvar i;

generate
    for (i = 0; i < WIDTH; i = i + 1) begin : RCA_STAGE

        if (i == 0) begin
            // Use Half Adder for LSB stage
            param_half_adder #(
                .APPROX(APPROX)
            ) HA (
                .a(a[i]),
                .b(b[i]),
                .sum(sum[i]),
                .carry(carry[i+1])
            );
        end
        else begin
            // Use Full Adders for remaining stages
            param_full_adder #(
                .APPROX(APPROX)
            ) FA (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1])
            );
        end

    end
endgenerate

assign cout = carry[WIDTH];

endmodule


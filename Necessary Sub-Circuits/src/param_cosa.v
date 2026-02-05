`timescale 1ns / 1ps

//Parameterized Carry Skip Adder/ Carry Bypass (COSA) using param_half_adder and param_full_adder

module param_cosa #(
    parameter WIDTH = 8,
    parameter APPROX = 1    //0=exact, 1=full
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             cin,
    output wire [WIDTH-1:0] sum,
    output wire             cout
);

wire [WIDTH:0] carry;
wire [WIDTH-1:0] propagate;

assign carry[0] = cin;

genvar i;

generate
    for (i = 0; i < WIDTH; i = i + 1) begin : COSA_STAGE

        // Full Adder for each bit
        param_full_adder #(
            .APPROX(APPROX)
        ) FA (
            .a(a[i]),
            .b(b[i]),
            .cin(carry[i]),
            .sum(sum[i]),
            .cout(carry[i+1])
        );

        // Propagate signal
        assign propagate[i] = a[i] ^ b[i];

    end
endgenerate

// Carry Skip Logic
assign cout = ( &propagate ) ? cin : carry[WIDTH];

endmodule


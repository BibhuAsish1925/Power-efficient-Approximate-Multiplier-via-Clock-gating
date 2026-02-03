`timescale 1ns / 1ps

//Clock Gating Module

module clock_gating_cell (
    input  wire clk,
    input  wire enable,
    input  wire rst,
    output wire gated_clk
);

reg enable_latch;

always @(posedge clk or posedge rst) begin
    if (rst)
        enable_latch <= 1'b0;
    else
        enable_latch <= enable;
end

assign gated_clk = clk & enable_latch;

endmodule


`timescale 1ns / 1ps

module tb_clock_gating_cell;

reg clk;
reg enable;
reg rst;

wire gated_clk;

// Instantiate clock gating cell
clock_gating_cell uut (
    .clk(clk),
    .enable(enable),
    .rst(rst),
    .gated_clk(gated_clk)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;

initial begin

    rst = 1;
    enable = 0;

    #10 rst = 0;

    #20 enable = 1;   // enable clock
    #50 enable = 0;   // disable clock
    #30 enable = 1;   // enable again

    #50 $finish;

end

endmodule


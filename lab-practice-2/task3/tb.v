// tb.v -- Part B2. Do NOT change the input sequence.
// You may add $display / $monitor statements here and inside timer.v.
`timescale 1ns/1ps
module tb;
  reg clk = 0, rst_n = 0, add = 0, tick = 0, clr = 0;
  wire [5:0] t;
  wire on;
  timer dut (.clk(clk), .rst_n(rst_n), .add(add), .tick(tick), .clr(clr),
             .t(t), .on(on));
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  always #5 clk = ~clk;
  initial begin
    #12 rst_n = 1;
    @(negedge clk) add = 1;
    @(negedge clk);
    @(negedge clk) add = 0; tick = 1;
    @(negedge clk);
    @(negedge clk) tick = 0; add = 1;
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk) add = 0; clr = 1;
    @(negedge clk) clr = 0; add = 1;
    @(negedge clk) add = 0; tick = 1;
    repeat (11) @(negedge clk);
    tick = 0;
    @(negedge clk) $finish;
  end
endmodule

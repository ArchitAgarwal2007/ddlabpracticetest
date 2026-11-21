// tb.v -- Part B1: complete this self-checking testbench for timer.
// Keep the instance name dut.
// It must end by printing one line: RESULT: PASS or RESULT: FAIL
`timescale 1ns/1ps
module tb;
  reg        clk = 0, rst_n = 0, add = 0, tick = 0, clr = 0;
  wire [5:0] t;
  wire       on;
  timer dut (.clk(clk), .rst_n(rst_n), .add(add), .tick(tick), .clr(clr),
             .t(t), .on(on));

  always #5 clk = ~clk;

  // (a) TODO: compute the expected t and on yourself, from the specification
  //     in the paper (for example, a behavioural always block on posedge clk
  //     and negedge rst_n that updates exp_t).
  reg  [5:0] exp_t;
  wire       exp_on;

  // (a) TODO: after every clock edge, compare t and on of dut with the
  //     expected values; on a mismatch add 1 to errors ($display helps debug).
  integer errors = 0;

  // (b) TODO: test cases. Change inputs only at falling clock edges.
  //     Cases worth trying: add when t is close to 60 (e.g. 55 + 10),
  //     tick down to 0 and one more tick at 0, clr, and a reset pulse
  //     between two clock edges.
  initial begin
    #12 rst_n = 1;
    @(negedge clk) add = 1;
    @(negedge clk) add = 0;
    // ... your test cases here ...
    @(negedge clk); #1;                       // let the last check finish
    if (errors == 0) $display("RESULT: PASS");
    else             $display("RESULT: FAIL");
    $finish;
  end

  // waveform dump for the Run button: keep this block
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end
endmodule

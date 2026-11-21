// tb.v -- Part A. Do not change.
// 1) Checks that btn_check, lift and lift_ctrl exist with the right port names.
// 2) Applies the inputs of Figure A3 to lift_ctrl, so you can compare your
//    waveform (wave.vcd) and the printed table with Figure A3.
`timescale 1ns/1ps
module tb;
  reg clk = 0, rst_n, up = 0, dn = 0, alarm = 0;   // rst_n is set to 0 at time 0 below

  // ---- port-name check (compiles only if all names match Figure A1/A2)
  reg        k_key = 1;
  reg  [1:0] k_up = 2'b10, k_dn = 2'b10;
  wire       k_p, k_f, k_alarm, k_moving;
  wire [2:0] k_floor;
  wire [1:0] k_disp;
  btn_check chk_b (.a(k_up[0]), .b(k_up[1]), .k(k_key), .p(k_p), .f(k_f));
  lift      chk_l (.clk(clk), .rst_n(rst_n), .key(k_key), .up_btn(k_up), .dn_btn(k_dn),
                   .alarm(k_alarm), .moving(k_moving), .floor(k_floor), .disp(k_disp));

  // ---- Figure A3 stimulus on lift_ctrl
  wire [2:0] floor;
  wire       moving;
  wire [1:0] disp;
  lift_ctrl U (.clk(clk), .rst_n(rst_n), .up(up), .dn(dn), .alarm(alarm),
               .floor(floor), .moving(moving), .disp(disp));

  initial begin #5; forever begin clk = 1; #5 clk = 0; #5; end end  // rising edges at 5, 15, 25, ...

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb);
    $timeformat(-9, 0, " ns", 7);
    rst_n = 0;               // x -> 0 is a falling edge: async reset at t = 0
    #12 rst_n = 1;
    #8  up = 1;               // 20
    #30 dn = 1;               // 50
    #10 dn = 0;               // 60
    #20 alarm = 1;            // 80
    #10 up = 0; dn = 1;       // 90
    #10 alarm = 0;            // 100
    #20 alarm = 1;            // 120
    #10 alarm = 0;            // 130
    #30 alarm = 1;            // 160
    #10 alarm = 0;            // 170
    #10 $finish;              // 180
  end

  // one line each time something changes
  initial $monitor("t=%t rst_n=%b up=%b dn=%b alarm=%b | floor=%0d moving=%b disp=%b",
                   $time, rst_n, up, dn, alarm, floor, moving, disp);
endmodule

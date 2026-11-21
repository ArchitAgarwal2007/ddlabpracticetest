// next_time: works out what t should become at the next clock edge
module next_time (input [5:0] t, input add, tick, clr, on,
                  output reg [5:0] nt);
  always @(*) begin
    if (clr)             nt = 6'd0;                             // cancel
    else if (add)        nt = (t >= 6'd51) ? 6'd60 : t + 6'd10; // +10 s, max 60
    else if (tick && on) nt = t - 6'd1;                         // 1 s has passed
    else                 nt = t;
  end
endmodule

// time_reg: stores t; rst_n clears it
module time_reg (input clk, rst_n, input [5:0] d, output reg [5:0] q);
  always @(posedge clk or negedge rst_n)
    if (!rst_n) q <= 6'd0;
    else        q <= d;
endmodule

// on_check: on = 1 while there is time left
module on_check (input [5:0] t, output on);
  assign on = (t >= 6'd1);
endmodule

// timer: top level
module timer (input clk, rst_n, add, tick, clr,
              output [5:0] t, output on);
  wire [5:0] nt;
  next_time U1 (t, add, tick, clr, on, nt);
  time_reg  U2 (clk, rst_n, nt, t);
  on_check  U3 (t, on);
endmodule

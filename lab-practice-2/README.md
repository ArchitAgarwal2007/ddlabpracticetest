# F215 Verilog Lab Exam - Practice Paper 2 (lab-practice-2)

The questions are in `F215_Verilog_Practice_Paper_2.pdf`.

| Folder | What to do | Files |
|---|---|---|
| `task1` | Part A: A1 and A2 | write `btn_check.v`, `lift.v`, `lift_ctrl.v`; `tb.v` is given |
| `task2` | Part B1 | complete `tb.v`; `timer.v` is the given (buggy) design |
| `task3` | Part B2 | fill in `answers.md`; you may add `$display` to `tb.v` and `timer.v`, but do not change the input sequence |

## Running

In a terminal, inside a task folder:

    iverilog -g2012 -o sim *.v && vvp sim +vcd=wave.vcd

(or `vrun` if you set up that alias). Open `wave.vcd` with VaporView to see the waveform.

- `task1/tb.v` checks your module and port names and applies the inputs of
  Figure A3 to `lift_ctrl`. Compare its printed table and `wave.vcd` with Figure A3.
  It will not compile until all three of your modules exist.
- Keep only one testbench (one `module tb`) in each folder.

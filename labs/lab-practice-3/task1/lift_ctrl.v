// Part A: write module lift_ctrl here.
module lift_ctrl(input [3:0] btn ,input clk,input rst,output door,output err, output  [1:0] disp,output [2:0] floor)
wire u1,d1,e1,u2,d2,e2,req_up,req_dn,err;
btn_enc U1(.up(btn[0],.dn(btn[1]),.u(u1),.d(d1),.e(e1));
btn_enc U2(.up(btn[2],.dn(btn[3]),.u(u2),.d(d2),.e(e2));
or g1(req_up,u1,u2);
or g2(req_dn,d1,d2);
or g3(err,e1,e2);
floor_ctrl U3(.clk(clk),.rst(rst),.req_up(req_up),.req_dn(req_dn),.err(err),.floor(floor),.door(door),disp(disp));
endmodule
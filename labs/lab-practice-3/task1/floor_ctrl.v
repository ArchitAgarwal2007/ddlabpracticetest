// Part A: write module floor_ctrl here
module floor_ctrl(input clk,rst,req_up,req_dn,err,output reg [2:0]floor,output wire door,output reg [1:0] disp);
always @(posedge clk) begin
    if(rst==1)begin
        floor<=0;
end
elif(err==1)begin
end
elif(req_up==1 && req_dn==0 && floor!=6)begin
floor<=floor+1;
end

elif(req_up==0 && req_dn==1 &&floor!=0)begin
floor<=floor-1;
end
assign door = (err==1||req_up==0&&req_dn==0)? 1:0;

always @(posedge clk)begin
if(err==1) disp=2'b11;
else if(floor==6) begindisp=2'b10;
else if(floor==0) disp=2'b01;
else disp=2'b00;
end
endmodule


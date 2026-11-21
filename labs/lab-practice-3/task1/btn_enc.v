// Part A: write module btn_enc here.
module btn_enc(input up, dn, output u,d,e);
wire a,b;
not g1(a,up);
not g2(b,dn);
and(u,up,b);
and(d,dn,a);
and(e,up,dn);
endmodule
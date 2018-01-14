//fetch_top.v


module fetch_top(
//data path
rx_a,
rx_b,
pkg_data,
pkg_vld,
pkg_frm,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//clk rst
fire_sync,
clk_sys,
rst_n
);
//data path
input rx_a;
input rx_b;
output [7:0]	pkg_data;
output				pkg_vld;
output				pkg_frm;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
//clk rst
input fire_sync;
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------


//---------- fetch_reg ------------
fetch_reg u_fetch_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//configuration

//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule


//repkg_top.v

module repkg_top(
//data path
pkg_data,
pkg_vld,
pkg_frm,
repk_data,
repk_vld,
repk_frm,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//clk rst
clk_sys,
rst_n
);
input[15:0]	pkg_data;
input				pkg_vld;
input				pkg_frm;
output [15:0]	repk_data;
output				repk_vld;
output				repk_frm;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------


// no logic
wire [15:0]	repk_data = pkg_data;
wire				repk_vld = pkg_vld;
wire				repk_frm = pkg_frm;


//register  
repkg_reg u_repkg_reg(
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

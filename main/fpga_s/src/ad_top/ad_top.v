//ad_top.v

module ad_top(
//data path output
ad_data,
ad_vld,
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
//data path output
output [23:0]	ad_data;
output				ad_vld;
//fx bus
input [15:0]	fx_waddr;
input 				fx_wr;
input [7:0]		fx_data;
input					fx_rd;
input [15:0]	fx_raddr;
output	[7:0]	fx_q;
input [5:0]		mod_id;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------

ad_reg u_ad_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

endmodule

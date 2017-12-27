//pack_top.v


module pack_top(
//data path input
dp_data,
dp_vld,
dp_utc,
dp_ns,
//pack data output
pk_data,
pk_vld,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//configuration
cfg_sample,
//clk rst
clk_sys,
rst_n
);
//data path output
input [23:0]	dp_data;
input					dp_vld;
input [31:0]	dp_utc;
input [31:0]	dp_ns;
//pack data output
output [7:0]	pk_data;
output				pk_vld;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
//configuration
input [7:0]	cfg_sample;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------



pack_reg u_pack_reg(
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



pack_buf u_pack_buf(
//data path input
.dp_data(dp_data),
.dp_vld(dp_vld),
.dp_utc(dp_utc),
.dp_ns(dp_ns),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule

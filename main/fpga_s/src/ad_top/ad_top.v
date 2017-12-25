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


wire [7:0]	cfg_sample;
wire [7:0]	cfg_ad_tp;
wire [23:0]	cfg_tp_base;
wire [7:0]	cfg_tp_step;
ad_reg u_ad_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//configuration
.cfg_sample(cfg_sample),
.cfg_ad_tp(cfg_ad_tp),
.cfg_tp_base(cfg_tp_base),
.cfg_tp_step(cfg_tp_step),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- ad_tp --------
wire [15:0]	tp_data;
wire				tp_vld;
ad_tp u_ad_tp(
.tp_data(tp_data),
.tp_vld(tp_vld),
//configuration
.cfg_sample(cfg_sample),
.cfg_ad_tp(cfg_ad_tp),
.cfg_tp_base(cfg_tp_base),
.cfg_tp_step(cfg_tp_step),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- ad_mux -------
ad_mux u_ad_mux(
.ad_data(ad_data),
.ad_vld(ad_vld),
.tp_data(tp_data),
.tp_vld(tp_vld),
.real_data(24'h0),
.real_vld(real_vld),
//configuration
.cfg_ad_tp(cfg_ad_tp),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule

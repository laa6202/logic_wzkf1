//ad_top.v

module ad_top(
//data path output
ad_data,
ad_vld,
//adc interface
ad_mclk,
ad_clk,
ad_din,
ad_cfg,
ad_sync,
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
pluse_us,
rst_n
);
//data path output
output [23:0]	ad_data;
output				ad_vld;
//adc interface
output ad_mclk;
output ad_clk;
input   ad_din;
output ad_cfg;
output ad_sync;

//fx bus
input [15:0]	fx_waddr;
input 				fx_wr;
input [7:0]		fx_data;
input					fx_rd;
input [15:0]	fx_raddr;
output	[7:0]	fx_q;
input [5:0]		mod_id;
//configuration
output [7:0]	cfg_sample;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//--------------------------------------
//--------------------------------------


//---------- ad_clk_gen ----------
wire clk_2kHz;
wire clk_2_5M;
ad_clk_gen   u_ad_clk_gen(
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n),
.clk_2_5M(clk_2_5M),
.clk_2kHz(clk_2kHz)
);
assign ad_mclk   = clk_2_5M;


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


//---------- ad_sample ----------
wire [23:0]	real_data;
wire				real_vld;
ad_sample u_ad_sample(
//adc interface
.ad_clk_in(clk_2_5M),
.ad_clk(ad_clk),
.clk_2kHz(clk_2kHz),
.ad_din(ad_din),
.ad_cfg(ad_cfg),
.ad_sync(ad_sync),
//data path
.ad_data(real_data),
.ad_vld(real_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//----------- ad_tp --------
wire [23:0]	tp_data;
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
.real_data(real_data),
.real_vld(real_vld),
//configuration
.cfg_ad_tp(cfg_ad_tp),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule

//dsp_top.v

module dsp_top(
//data path in
ad1_data,
ad1_vld,
ad2_data,
ad2_vld,
ad3_data,
ad3_vld,
//data path output
dp_data,
dp_vld,
dp_utc,
dp_ns,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//clk rst
utc_sec,
now_ns,
clk_sys,
rst_n
);
//data path in
input [23:0]	ad1_data;
input					ad1_vld;
input [23:0]	ad2_data;
input					ad2_vld;
input [23:0]	ad3_data;
input					ad3_vld;
//data path output
output [23:0]	dp_data;
output				dp_vld;
output [31:0]	dp_utc;
output [31:0]	dp_ns;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
//clk rst
input [31:0]	utc_sec;
input [31:0]	now_ns;
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------


dsp_reg u_dsp_reg(
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

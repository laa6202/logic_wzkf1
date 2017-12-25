//ad_tp.v
//ad_tp.v

module ad_tp(
tp_data,
tp_vld,
//configuration
cfg_sample,
cfg_ad_tp,
cfg_tp_base,
cfg_tp_step,
//clk rst
clk_sys,
rst_n
);
output [23:0]	tp_data;
output				tp_vld;
//configuration
input [7:0]	cfg_sample;
input [7:0]	cfg_ad_tp;
input [23:0]cfg_tp_base;
input [7:0]	cfg_tp_step;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------



endmodule

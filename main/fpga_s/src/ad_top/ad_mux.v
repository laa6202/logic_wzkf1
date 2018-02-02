//ad_tp.v
//ad_mux.v

module ad_mux(
ad_data,
ad_vld,
tp_data,
tp_vld,
real_data,
real_vld,
//configuration
cfg_ad_tp,
//clk rst
clk_sys,
rst_n
);
output [23:0]	ad_data;
output				ad_vld;
input [23:0]	tp_data;
input					tp_vld;
input [23:0]	real_data;
input					real_vld;
//configuration
input [7:0]		cfg_ad_tp;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------

wire [23:0]	ad_data;
wire 				ad_vld;
assign ad_data = (cfg_ad_tp != 8'h0) ? tp_data : real_data;
assign ad_vld  = (cfg_ad_tp != 8'h0) ? tp_vld  : real_vld ;


endmodule

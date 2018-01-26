//cspi_codec.v

module cspi_codec(
//all cmd path
cmd_dev,
cmd_mod,
cmd_addr,
cmd_data,
cmd_vld,
cmd_q,
//internal control path
ctrl_data,
ctrl_dvld,
ctrl_q,
ctrl_qvld,
//clk rst
clk_sys,
rst_n
);
//all cmd path
output [7:0]	cmd_dev;
output [7:0]	cmd_mod;
output [7:0]	cmd_addr;
output [7:0]	cmd_data;
output				cmd_vld;
input  [7:0]	cmd_q;
//internal control path
input [7:0]	ctrl_data;
input				ctrl_dvld;
output  [7:0]	ctrl_q;
output				ctrl_qvld;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------



endmodule

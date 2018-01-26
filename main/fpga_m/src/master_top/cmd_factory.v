//cmd_factoty.v

module cmd_factory(
//all cmd path
cmd_dev,
cmd_mod,
cmd_addr,
cmd_data,
cmd_vld,
cmd_q,
//cmd remote path
cmdr_dev,
cmdr_mod,
cmdr_addr,
cmdr_data,
cmdr_vld,
//cmd local path
cmdl_mod,
cmdl_addr,
cmdl_data,
cmdl_vld,
cmdl_q,
//clk rst
clk_sys,
rst_n
);
//all cmd path
input [7:0]	cmd_dev;
input [7:0]	cmd_mod;
input [7:0]	cmd_addr;
input [7:0]	cmd_data;
input				cmd_vld;
output[7:0]	cmd_q;
//cmd remote path
output [7:0]	cmdr_dev;
output [7:0]	cmdr_mod;
output [7:0]	cmdr_addr;
output [7:0]	cmdr_data;
output				cmdr_vld;
//cmd local path
output [7:0]	cmdl_mod;
output [7:0]	cmdl_addr;
output [7:0]	cmdl_data;
output				cmdl_vld;
input  [7:0]	cmdl_q;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------




endmodule


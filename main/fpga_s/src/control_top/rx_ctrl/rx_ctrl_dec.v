//rx_ctrl_dec.v

module rx_ctrl_dec(
//cmd decode
cmdr_dev,
cmdr_mod,
cmdr_addr,
cmdr_data,
cmdr_vld,
//raw data
rx_vld,
rx_data,
//clk rst
clk_sys,
rst_n
);
//cmd decode
output [7:0]	cmdr_dev;
output [7:0]	cmdr_mod;
output [7:0]	cmdr_addr;
output [7:0]	cmdr_data;
output 				cmdr_vld;
//raw data
input				rx_vld;
input [7:0]	rx_data;
//clk rst
input clk_sys;
input rst_n;

//--------------------------------------



endmodule

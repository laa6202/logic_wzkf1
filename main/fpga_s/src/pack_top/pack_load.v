//pack_load.v


module pack_load(
fire_load,
done_load,
//data path
load_data,
load_vld,
buf_waddr,
buf_raddr,
q_x,
q_y,
q_z,
//configuration
cfg_sample,
//clk rst
clk_sys,
rst_n
);
input		fire_load;
output	done_load;
//data path
output [7:0]	load_data;
output				load_vld;
input  [11:0]	buf_waddr;
output [11:0]	buf_raddr;
input  [31:0]	q_x;
input  [31:0]	q_y;
input  [31:0]	q_z;
//configuration
input [7:0]	cfg_sample;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------



endmodule


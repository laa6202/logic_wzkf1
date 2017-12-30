//pack_head.v


module pack_head(
fire_head,
done_head,
//data path
head_data,
head_vld,
//configuration
cfg_sample,
//clk rst
clk_sys,
rst_n
);
input		fire_head;
output	done_head;
//data path
output [7:0]	head_data;
output				head_vld;
//configuration
input [7:0]	cfg_sample;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------



endmodule


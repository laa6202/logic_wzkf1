//pack_mux.v


module pack_mux (
pk_data,
pk_vld,
//data path
head_data,
head_vld,
load_data,
load_vld,
tail_data,
tail_vld,
crc_data,
crc_vld,
//clk rst
clk_sys,
rst_n
);
output [7:0]	pk_data;
output				pk_vld;
//data path
input [7:0]	head_data;
input				head_vld;
input [7:0]	load_data;
input				load_vld;
input [7:0]	tail_data;
input				tail_vld;
input [7:0]	crc_data;
input				crc_vld;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------


wire [7:0]	pk_data;
wire				pk_vld;
assign pk_data = head_data | load_data | tail_data | crc_data;
assign pk_vld = head_vld | load_vld | tail_vld | crc_vld;


endmodule


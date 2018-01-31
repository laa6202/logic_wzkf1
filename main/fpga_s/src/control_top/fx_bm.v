//fx_bm.v

module fx_bm(
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
//bm data 
bm_data,
bm_vld,
//clk rst
clk_sys,
rst_n
);
//fx bus
input [15:0]	fx_waddr;
input 				fx_wr;
input [7:0]	fx_data;
input				fx_rd;
input [15:0]	fx_raddr;
input  [7:0]	fx_q;
//bm data 
output [31:0]	bm_data;
output				bm_vld;
//clk rst
input clk_sys;
input rst_n;

//--------------------------------------
//--------------------------------------



endmodule

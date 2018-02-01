//ex_top.v

module ex_top(
exp_data,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//clk rst
clk_sys,
rst_n
);
output [255:0]	exp_data;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------

//no logic
wire [255:0]	exp_data = 255'h1234567890abcdef55aa55aa55aa55aa;


endmodule

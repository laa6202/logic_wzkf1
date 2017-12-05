//fx_bm.v

module fx_bm(
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
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
//clk rst
input clk_sys;
input rst_n;

//--------------------------------------
//--------------------------------------



endmodule

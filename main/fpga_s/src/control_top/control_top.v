//control_top.v

module control_top(
//485 line
tx_ctrl,
rx_ctrl,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
//clk rst
clk_sys,
pluse_us,
rst_n
);
//485 line
output tx_ctrl;
input  rx_ctrl;
//fx bus
output [23:0]	fx_waddr;
output 				fx_wr;
output [7:0]	fx_data;
output				fx_rd;
output [23:0]	fx_raddr;
input  [7:0]	fx_q;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;


//---------------------------------------



endmodule

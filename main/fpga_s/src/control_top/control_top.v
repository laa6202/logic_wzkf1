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
//global
dev_id,
mod_id,
//clk rst
clk_sys,
pluse_us,
rst_n
);
//485 line
output tx_ctrl;
input  rx_ctrl;
//fx bus
output [15:0]	fx_waddr;
output 				fx_wr;
output [7:0]	fx_data;
output				fx_rd;
output [15:0]	fx_raddr;
input  [7:0]	fx_q;
//global
output [7:0]	dev_id;
input  [7:0]	mod_id;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;


//---------------------------------------
//---------------------------------------
wire [7:0]	cmdr_dev;
wire [7:0]	cmdr_mod;
wire [7:0]	cmdr_addr;
wire [7:0]	cmdr_data;
wire 				cmdr_vld;
rx_ctrl_top u_rx_ctrl(
//485 line
.rx_ctrl(rx_ctrl),
//cmd decode
.cmdr_dev(cmdr_dev),
.cmdr_mod(cmdr_mod),
.cmdr_addr(cmdr_addr),
.cmdr_data(cmdr_data),
.cmdr_vld(cmdr_vld),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);


//---------- factory ---------
wire [7:0]	cmdt_dev;
wire [7:0]	cmdt_mod;
wire [7:0]	cmdt_addr;
wire [7:0]	cmdt_data;
wire				cmdt_vld;
wire [7:0]	cmdl_dev;
wire [7:0]	cmdl_mod;
wire [7:0]	cmdl_addr;
wire [7:0]	cmdl_data;
wire				cmdl_vld;
wire [7:0]	dev_id;
factory_ctrl u_factory_ctrl(
//cmd receive
.cmdr_dev(cmdr_dev),
.cmdr_mod(cmdr_mod),
.cmdr_addr(cmdr_addr),
.cmdr_data(cmdr_data),
.cmdr_vld(cmdr_vld),
//cmd transmit
.cmdt_dev(cmdt_dev),
.cmdt_mod(cmdt_mod),
.cmdt_addr(cmdt_addr),
.cmdt_data(cmdt_data),
.cmdt_vld(cmdt_vld),
//cmd local
.cmdl_dev(cmdl_dev),
.cmdl_mod(cmdl_mod),
.cmdl_addr(cmdl_addr),
.cmdl_data(cmdl_data),
.cmdl_vld(cmdl_vld),
//configuration
.dev_id(dev_id),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);



endmodule

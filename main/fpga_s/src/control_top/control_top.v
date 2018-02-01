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
//mcu spi
mcu_csn,
mcu_sck,
mcu_mosi,
mcu_sel,
//bm path
bm_data,
bm_vld,
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
//mcu port
input mcu_csn;
input mcu_sck;
input mcu_mosi;
input mcu_sel;
//bm path
output [31:0]	bm_data;
output 				bm_vld;
//global
output [7:0]	dev_id;
input  [5:0]	mod_id;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;


//---------------------------------------
//---------------------------------------

//------------ mcu spi ---------
wire [7:0]	spi_data;
wire 				spi_vld;
mcuspi_inf u_mcuspi_inf(
//mcu spi
.mcu_csn(mcu_csn),
.mcu_sck(mcu_sck),
.mcu_mosi(mcu_mosi),
//internal control path
.spi_data(spi_data),
.spi_vld(spi_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//---------- dev_id ----------
wire [7:0]	dev_id;
devid_gen u_devid(
.dev_id(dev_id),
//fx bus 
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
//mcu spi path
.spi_data(spi_data),
.spi_vld(spi_vld),
.mcu_sel(mcu_sel),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

//---------- rx_ctrl ----------
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

//---------- tx_ctrl ---------
tx_ctrl_top u_tx_ctrl(
//485 line
.tx_ctrl(tx_ctrl),
//cmd transmit
.cmdt_dev(cmdt_dev),
.cmdt_mod(cmdt_mod),
.cmdt_addr(cmdt_addr),
.cmdt_data(cmdt_data),
.cmdt_vld(cmdt_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- fx_bc -----------
wire [7:0]	fx_q_all;
fx_bc u_fx_bc(
.cmdl_mod(cmdl_mod),
.cmdl_addr(cmdl_addr),
.cmdl_data(cmdl_data),
.cmdl_vld(cmdl_vld),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_all),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//---------- bus monitor -------
fx_bm u_fx_bm(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_all),
//bm data 
.bm_data(bm_data),
.bm_vld(bm_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


wire [7:0]	fx_q_ctrl;
cfg_reg u_ctrl_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_ctrl),
.mod_id(mod_id),
.dev_id(dev_id),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

assign fx_q_all = fx_q_ctrl | fx_q;

endmodule

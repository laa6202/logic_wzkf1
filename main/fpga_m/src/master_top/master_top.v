//master_top.v


module master_top(
//arm control spi
cspi_csn,
cspi_sck,
cspi_miso,
cspi_mosi,
//fx bus master
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
//signal line 
arm_int_n,
//485 line
tx_ctrl,
//clk rst
clk_sys,
rst_n
);
//arm control spi
input cspi_csn;
input cspi_sck;
output cspi_miso;
input cspi_mosi;
//fx bus master
output [15:0]	fx_waddr;
output				fx_wr;
output [7:0]	fx_data;
output				fx_rd;
output [15:0]	fx_raddr;
input  [7:0]	fx_q;
//signal line 
input  arm_int_n;
//485 line
output tx_ctrl;
//clk rst
input clk_sys;
input rst_n;

//----------------------------------------
//----------------------------------------


//----------- cspi_inf ------------
wire [7:0]	ctrl_data;
wire				ctrl_dvld;
wire  [7:0]	ctrl_q;
wire				ctrl_qvld;
cspi_inf u_cspi_inf(
//arm control spi
.cspi_csn(cspi_csn),
.cspi_sck(cspi_sck),
.cspi_miso(cspi_miso),
.cspi_mosi(cspi_mosi),
//internal control path
.ctrl_data(ctrl_data),
.ctrl_dvld(ctrl_dvld),
.ctrl_q(ctrl_q),
.ctrl_qvld(ctrl_qvld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- cspi_codec ---------
wire [7:0]	cmd_dev;
wire [7:0]	cmd_mod;
wire [7:0]	cmd_addr;
wire [7:0]	cmd_data;
wire				cmd_vld;
wire  [7:0]	cmd_q;
wire				cmd_qvld;
cspi_codec u_cspi_codec(
//all cmd path
.cmd_dev(cmd_dev),
.cmd_mod(cmd_mod),
.cmd_addr(cmd_addr),
.cmd_data(cmd_data),
.cmd_vld(cmd_vld),
.cmd_q(cmd_q),
.cmd_qvld(cmd_qvld),
//internal control path
.ctrl_data(ctrl_data),
.ctrl_dvld(ctrl_dvld),
.ctrl_q(ctrl_q),
.ctrl_qvld(ctrl_qvld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- cmd_factory ----------
wire [7:0]	cmdr_dev;
wire [7:0]	cmdr_mod;
wire [7:0]	cmdr_addr;
wire [7:0]	cmdr_data;
wire				cmdr_vld;
wire [7:0]	cmdl_mod;
wire [7:0]	cmdl_addr;
wire [7:0]	cmdl_data;
wire				cmdl_vld;
wire  [7:0]	cmdl_q;
wire 				cmdl_qvld;
cmd_factory u_cmd_factory(
//all cmd path
.cmd_dev(cmd_dev),
.cmd_mod(cmd_mod),
.cmd_addr(cmd_addr),
.cmd_data(cmd_data),
.cmd_vld(cmd_vld),
.cmd_q(cmd_q),
.cmd_qvld(cmd_qvld),
//cmd remote path
.cmdr_dev(cmdr_dev),
.cmdr_mod(cmdr_mod),
.cmdr_addr(cmdr_addr),
.cmdr_data(cmdr_data),
.cmdr_vld(cmdr_vld),
//cmd local path
.cmdl_mod(cmdl_mod),
.cmdl_addr(cmdl_addr),
.cmdl_data(cmdl_data),
.cmdl_vld(cmdl_vld),
.cmdl_q(cmdl_q),
.cmdl_qvld(cmdl_qvld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- fx_bc -----------
fx_bc_m u_fx_bc(
.cmdl_mod(cmdl_mod),
.cmdl_addr(cmdl_addr),
.cmdl_data(cmdl_data),
.cmdl_vld(cmdl_vld),
.cmdl_q(cmdl_q),
.cmdl_qvld(cmdl_qvld),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//------------ tx_ctrl -----------
tx_ctrl_top u_mctrl_tx(
//485 line
.tx_ctrl(tx_ctrl),
//cmd transmit
.cmdt_dev(cmdr_dev),
.cmdt_mod(cmdr_mod),
.cmdt_addr(cmdr_addr),
.cmdt_data(cmdr_data),
.cmdt_vld(cmdr_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


endmodule

//arm_ctrl_top.v

module arm_ctrl_top(
cspi_csn,
cspi_sck,
cspi_miso,
cspi_mosi,
//configuration
dev_id,
mod_id,
cmd_addr,
cmd_data,
cmd_vld,
//clk rst
clk_sys,
rst_n
);
output cspi_csn;
output cspi_sck;
input  cspi_miso;
output cspi_mosi;
//configuration
input [7:0]	dev_id;
input [7:0]	mod_id;
input	[7:0]	cmd_addr;
input	[7:0]	cmd_data;
input 			cmd_vld;
//clk rst
input clk_sys;
input rst_n;

//--------------------------------------
//--------------------------------------


//----------- arm_ctrl_mac -------
wire fire_cspi;
wire done_cspi;
wire [7:0]	set_data;
wire				set_vld;
wire	[7:0]	get_q;
wire 				get_vld;
arm_ctrl_mac u_actrl_mac(
.fire_cspi(fire_cspi),
.done_cspi(done_cspi),
//data path
.set_data(set_data),
.set_vld(set_vld),
.get_q(get_q),
.get_vld(get_vld),
//configuration
.dev_id(dev_id),
.mod_id(mod_id),
.cmd_addr(cmd_addr),
.cmd_data(cmd_data),
.cmd_vld(cmd_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//-------- arm_ctrl_phy -----------
arm_ctrl_phy u_actrl_phy(
.fire_cspi(fire_cspi),
.done_cspi(done_cspi),
//interface
.cspi_csn(cspi_csn),
.cspi_sck(cspi_sck),
.cspi_miso(cspi_miso),
.cspi_mosi(cspi_mosi),
//data path
.set_data(set_data),
.set_vld(set_vld),
.get_q(get_q),
.get_vld(get_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule

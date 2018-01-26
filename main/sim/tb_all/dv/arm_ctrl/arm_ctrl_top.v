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



endmodule

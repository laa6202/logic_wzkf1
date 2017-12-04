//factory_ctrl.v

module factory_ctrl(
//cmd receive
cmdr_dev,
cmdr_mod,
cmdr_addr,
cmdr_data,
cmdr_vld,
//cmd transmit
cmdt_dev,
cmdt_mod,
cmdt_addr,
cmdt_data,
cmdt_vld,
//cmd local
cmdl_dev,
cmdl_mod,
cmdl_addr,
cmdl_data,
cmdl_vld,
//configuration
dev_id,
//clk rst
clk_sys,
pluse_us,
rst_n
);
//cmd receive
input [7:0]	cmdr_dev;
input [7:0]	cmdr_mod;
input [7:0]	cmdr_addr;
input [7:0]	cmdr_data;
input 			cmdr_vld;
//cmd transmit
output [7:0]	cmdt_dev;
output [7:0]	cmdt_mod;
output [7:0]	cmdt_addr;
output [7:0]	cmdt_data;
output				cmdt_vld;
//cmd local
output [7:0]	cmdl_dev;
output [7:0]	cmdl_mod;
output [7:0]	cmdl_addr;
output [7:0]	cmdl_data;
output 				cmdl_vld;
//configuration
output [7:0]	dev_id;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//---------------------------------------
//---------------------------------------

reg [7:0] dev_id;
wire broadcast = (cmdr_dev == 8'hff) ? 1'b1 : 1'b0;
wire localhost = (cmdr_dev == dev_id) ? 1'b1 : 1'b0;




endmodule


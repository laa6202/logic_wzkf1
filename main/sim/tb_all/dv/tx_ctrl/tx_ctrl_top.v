//tx_top.v

module tx_ctrl_top(
tx_ctrl,
//configuration
dev_id,
mod_id,
cmd_addr,
cmd_data,
//clk rst
clk_sys,
rst_n
);
output tx_ctrl;
//configuration
input [7:0]	dev_id;
input [7:0]	mod_id;
input	[7:0]	cmd_addr;
input	[7:0]	cmd_data;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------

wire fire_tx;
wire done_tx;
wire [7:0] data_tx;
tx_ctrl_mac u_tx_mac(
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
//configuration
.tx_total(32'h4),
.dev_id(dev_id),
.mod_id(mod_id),
.cmd_addr(cmd_addr),
.cmd_data(cmd_data),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


tx_ctrl_phy u_tx_phy(
.tx_ctrl(tx_ctrl),
//control 
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
`ifdef SIM
.tbit_period(20'd10),
`else 
.tbit_period(20'd1000),
`endif
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);




endmodule


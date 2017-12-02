//tx_top.v

module tx_ctrl_top(
tx_ctrl,
//configuration
dev_id,
mod_id,
addr,
data,
//clk rst
clk_sys,
rst_n
);
output tx_ctrl;
//configuration
input [7:0]	dev_id;
input [7:0]	mod_id;
input	[7:0]	addr;
input	[7:0]	data;
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
.tx_pattern(1'b0),
.now_send(now_send),
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


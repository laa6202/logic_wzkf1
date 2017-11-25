//tx_top.v

module tx_top(
tx,
//configuration
tbit_period,
tx_total,
tx_pattern,
now_send,
//clk rst
clk_sys,
rst_n
);
output tx;
//configuration
input [19:0]	tbit_period;
input [31:0]	tx_total;
input					tx_pattern;
output				now_send;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------

wire fire_tx;
wire done_tx;
wire [7:0] data_tx;
tx_ctrl u_tx_mac(
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
//configuration
.tx_total(tx_total),
.tx_pattern(tx_pattern),
.now_send(now_send),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


tx_inf u_tx_phy(
.tx(tx),
//control 
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
.tbit_period(tbit_period),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);




endmodule


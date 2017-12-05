//tx_ctrl_top.v

module tx_ctrl_top(
//485 line
tx_ctrl,
//cmd transmit
cmdt_dev,
cmdt_mod,
cmdt_addr,
cmdt_data,
cmdt_vld,
//clk rst
clk_sys,
rst_n
);
//485 line
output tx_ctrl;
//cmd transmit
input [7:0]	cmdt_dev;
input [7:0]	cmdt_mod;
input [7:0]	cmdt_addr;
input [7:0]	cmdt_data;
input 			cmdt_vld;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------------
//--------------------------------------------
wire fire_tx;
wire done_tx;
wire [7:0]	data_tx;
tx_ctrl_enc u_tx_enc(
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
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


tx_ctrl_phy u_tx_phy(
.tx(tx_ctrl),
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


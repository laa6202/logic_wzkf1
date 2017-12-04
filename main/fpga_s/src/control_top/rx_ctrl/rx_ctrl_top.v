//rx_ctrl_top.v

module rx_ctrl_top(
//485 line
rx_ctrl,
//cmd decode
cmdr_dev,
cmdr_mod,
cmdr_addr,
cmdr_data,
cmdr_vld,
//clk rst
clk_sys,
pluse_us,
rst_n
);
//485 line
input rx_ctrl;
//cmd decode
output [7:0]	cmdr_dev;
output [7:0]	cmdr_mod;
output [7:0]	cmdr_addr;
output [7:0]	cmdr_data;
output 				cmdr_vld;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;

//-----------------------------------------------
wire [7:0]	rx_ctrl_data;
wire 				rx_ctrl_vld;
rx_ctrl_phy u_rx_ctrl_phy(
.rx(rx_ctrl),
`ifdef SIM
.tbit_period(20'd10),
`else
.tbit_period(20'd1000),
`endif
.rx_vld(rx_ctrl_vld),
.rx_data(rx_ctrl_data),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


rx_ctrl_dec u_rx_ctrl_dec(
//cmd decode
.cmdr_dev(cmdr_dev),
.cmdr_mod(cmdr_mod),
.cmdr_addr(cmdr_addr),
.cmdr_data(cmdr_data),
.cmdr_vld(cmdr_vld),
//raw data
.rx_vld(rx_ctrl_vld),
.rx_data(rx_ctrl_data),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


endmodule


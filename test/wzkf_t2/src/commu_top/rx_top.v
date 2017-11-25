//rx_top.v

module rx_top(
rx,
rx_total,
tbit_period,
tx_pattern,
//clk rst
clk_sys,
rst_n

);
input 				rx;
output [31:0]	rx_total;
input  [19:0]	tbit_period;
input 				tx_pattern;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------

wire [7:0]	rx_data;
wire 				rx_vld;
rx_inf u_rx_phy(
.rx(rx),
.tbit_period(tbit_period),
.rx_vld(rx_vld),
.rx_data(rx_data),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


rx_ctrl u_rx_ctrl(
.rx_total(rx_total),
.tx_pattern(tx_pattern),
.rx_data(rx_data),
.rx_vld(rx_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);




endmodule


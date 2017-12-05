//top_s.v

module top_m(
//485 line
tx_ctrl,
tx_syn,
rx_a,
rx_b,
//clk rst
mclk0,
mclk1,
mclk2,
hrst_n
);
//485 line
output 	tx_ctrl;
output 	tx_syn;
input 	rx_a;
input		rx_b;
//clk rst
input	mclk0;
input	mclk1;
input	mclk2;
input	hrst_n;
//----------------------------------------


clk_rst_top u_clk_rst(
.hrst_n(),
.mclk0(),
.mclk1(),
.mclk2(),
.clk_sys(),
.clk_slow(),
.pluse_us(),
.rst_n()
);


endmodule

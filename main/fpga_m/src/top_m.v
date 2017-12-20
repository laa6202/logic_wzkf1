//top_s.v

module top_m(
//485 line
tx_ctrl,
tx_syn,
rx_a,
rx_b,
//syn pluse from GPS
gps_pluse,
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
//syn pluse from GPS
input gps_pluse;

//clk rst
input	mclk0;
input	mclk1;
input	mclk2;
input	hrst_n;
//----------------------------------------

wire clk_sys;
wire clk_slow;
wire pluse_us;
wire rst_n;
clk_rst_top u_clk_rst(
.hrst_n(hrst_n),
.mclk0(mclk0),
.mclk1(mclk1),
.mclk2(mclk2),
.clk_sys(clk_sys),
.clk_slow(clk_slow),
.pluse_us(pluse_us),
.rst_n(rst_n)
);


//--------- syn_m_top ---------
syn_m_top u_syn_m(
.tx_syn(tx_syn),
//gps inf
.gps_pluse(gps_pluse),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);



endmodule
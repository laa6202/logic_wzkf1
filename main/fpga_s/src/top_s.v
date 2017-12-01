//top_s.v
//The top of wz slave FPGA

module top_s(
//485 line
tx_ctrl,
rx_ctrl,
tx_syn,
rx_syn,
tx_a,
rx_a,
tx_b,
rx_b,
//clk rst
mclk0,
mclk1,
mclk2,
hrst_n
);
//485 line
output	tx_ctrl;
input		rx_ctrl;
output	tx_syn;
input		rx_syn;
output	tx_a;
input		rx_a;
output	tx_b;
input		rx_b;
//clk rst
input mclk0;
input mclk1;
input mclk2;
input hrst_n;
//--------------------------------------------
//--------------------------------------------


//------------ clk_rst_top -------------
wire clk_sys;
wire clk_slow;
wire rst_n;
wire pluse_us;
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


//--------- the control source ---------
control_top u_control_top(
//485 line
.tx_ctrl(),
.rx_ctrl(),
//fx bus
.fx_waddr(),
.fx_wr(),
.fx_data(),
.fx_rd(),
.fx_raddr(),
.fx_q(),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);


endmodule


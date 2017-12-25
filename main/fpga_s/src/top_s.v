//top_s.v
//The top of wz slave FPGA

module top_s(
//485 line
rx_ctrl,
tx_ctrl,
rx_syn,
tx_a,
de_a,
tx_b,
de_b,
//clk rst
mclk0,
mclk1,
mclk2,
hrst_n
);
//485 line
input		rx_ctrl;
output	tx_ctrl;
input		rx_syn;
output	tx_a;
output	de_a;
output	tx_b;
output	de_b;
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
wire [15:0]	fx_waddr;
wire 				fx_wr;
wire [7:0]	fx_data;
wire				fx_rd;
wire [15:0]	fx_raddr;
wire  [7:0]	fx_q;
wire [7:0]	dev_id;
control_top u_control_top(
//485 line
.tx_ctrl(tx_ctrl),
.rx_ctrl(rx_ctrl),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
//global
.dev_id(dev_id),
.mod_id(6'h1),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);


wire [7:0] fx_q_syn;
wire [7:0] fx_q_ad1;
wire [7:0] fx_q_ad2 = 8'h0;
wire [7:0] fx_q_ad3 = 8'h0;
fx_bus u_fx_bus(
.fx_q(fx_q),
.fx_q_syn(fx_q_syn),
.fx_q_ad1(fx_q_ad1),
.fx_q_ad2(fx_q_ad2),
.fx_q_ad3(fx_q_ad3),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//------------ syn_top -------------
wire [31:0] utc_sec;
wire [31:0]	now_ns;
wire [7:0] stu_err_syn;

syn_top u_syn_top(
.rx_syn(rx_syn),
.utc_sec(utc_sec),
.now_ns(now_ns),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_syn),
//clk rst
.mod_id(6'h2),
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//------------- ad_top ---------------
wire [23:0]	ad1_data;
wire				ad1_vld; 
ad_top ad1_top(
//data path output
.ad_data(ad1_data),
.ad_vld(ad1_vld),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_ad1),
.mod_id(6'h11),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule


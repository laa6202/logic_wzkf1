//top_s.v
//The top of wz slave FPGA

module top_s(
//adc interface
ad_mclk,
ad_clk,
ad_din,
ad_cfg,
ad_sync,
//485 line
rx_ctrl,
rx_syn,
tx_a,
te_a,
re_a,
//mcu port
mcu_csn,
mcu_sck,
mcu_miso,
mcu_mosi,
mcu_sel,
cfg_id,
//clk rst
mclk0,
mclk1,
mclk2,
hrst_n
);
//adc interface
output ad_mclk;
output ad_clk;
input ad_din;
output ad_cfg;
output ad_sync;
//485 line
input		rx_ctrl;
input		rx_syn;
output	tx_a;
output	te_a;
output	re_a;
//mcu port
input mcu_csn;
input mcu_sck;
output mcu_miso;
input mcu_mosi;
input mcu_sel;
input cfg_id;
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
wire [31:0]	bm_data;
wire				bm_vld;
control_top u_control_top(
//485 line
.tx_ctrl(),
.rx_ctrl(rx_ctrl),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
//mcu spi
.mcu_csn(mcu_csn),
.mcu_sck(mcu_sck),
.mcu_mosi(mcu_mosi),
.mcu_miso(mcu_miso),
.mcu_sel(mcu_sel),
//bm data
.bm_data(bm_data),
.bm_vld(bm_vld),
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
wire [7:0] fx_q_dsp;
wire [7:0] fx_q_pack;
wire [7:0] fx_q_ep;
wire [7:0] fx_q_commu;
fx_bus u_fx_bus(
.fx_q(fx_q),
.fx_q_syn(fx_q_syn),
.fx_q_ad1(fx_q_ad1),
.fx_q_ad2(fx_q_ad2),
.fx_q_ad3(fx_q_ad3),
.fx_q_dsp(fx_q_dsp),
.fx_q_ep(fx_q_ep),
.fx_q_pack(fx_q_pack),
.fx_q_commu(fx_q_commu),
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
wire [7:0]	cfg_sample;
wire [23:0]	ad1_data;
wire				ad1_vld; 
wire [23:0]	ad2_data = 24'h222222;
wire				ad2_vld = ad1_vld;  
wire [23:0]	ad3_data = 24'h333333;
wire				ad3_vld = ad1_vld;  
ad_top ad1_top(
//data path output
.ad_data(ad1_data),		
.ad_vld(ad1_vld),
//adc interface
.ad_mclk(ad_mclk),
.ad_clk(ad_clk),
.ad_din(ad_din),
.ad_cfg(ad_cfg),
.ad_sync(ad_sync),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_ad1),
.mod_id(6'h11),
//configuration
.cfg_sample(cfg_sample),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);


//----------- ex_top -------
wire [255:0] exp_data;
ex_top u_ex_top(
.exp_data(exp_data),
//mcu spi
.mcu_csn(mcu_csn),
.mcu_sck(mcu_sck),
.mcu_mosi(mcu_mosi),
.mcu_sel(mcu_sel),
.cfg_id(cfg_id),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_ep),
.mod_id(6'h1E),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- dsp_top ------------
wire [23:0]	dp_data;
wire				dp_vld;
wire [31:0]	dp_utc;
wire [31:0]	dp_ns;
dsp_top u_dsp_top(
//data path in
.ad1_data(ad1_data),
.ad1_vld(ad1_vld),
.ad2_data(ad2_data),
.ad2_vld(ad2_vld),
.ad3_data(ad3_data),
.ad3_vld(ad3_vld),
//data path output
.dp_data(dp_data),
.dp_vld(dp_vld),
.dp_utc(dp_utc),
.dp_ns(dp_ns),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_dsp),
.mod_id(6'h20),
//clk rst
.utc_sec(utc_sec),
.now_ns(now_ns),
.clk_sys(clk_sys),
.rst_n(rst_n)
);




//----------- pack_top ------------
wire [7:0]	pk_data;
wire				pk_vld;
wire				pk_frm;
pack_top u_pack_top(
//data path input
.dp_data(dp_data),
.dp_vld(dp_vld),
.dp_utc(dp_utc),
.dp_ns(dp_ns),
//bm and exp data
.bm_data(bm_data),
.bm_vld(bm_vld),
.exp_data(exp_data),
//pack data output
.pk_data(pk_data),
.pk_vld(pk_vld),
.pk_frm(pk_frm),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_pack),
.mod_id(6'h21),
//configuration
.cfg_sample(cfg_sample),
.dev_id(dev_id),
//clk rst
.utc_sec(utc_sec),
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- commu_top ----------
commu_top u_commu_top(
//data path
.pk_data(pk_data),
.pk_vld(pk_vld),
.pk_frm(pk_frm),
.tx_a(tx_a),
.te_a(te_a),
.re_a(re_a),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_commu),
.mod_id(6'h22),
//configuration
.cfg_sample(cfg_sample),
.dev_id(dev_id),
//clk rst
.utc_sec(utc_sec),
.now_ns(now_ns),
.clk_sys(clk_sys),
.rst_n(rst_n)
);




endmodule


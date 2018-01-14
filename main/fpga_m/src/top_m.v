//top_s.v

module top_m(
//arm spi
spi_csn,
spi_sck,
spi_miso,
spi_mosi,
arm_int_n,
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
//arm spi
input spi_csn;
input spi_sck;
output	spi_miso;
input		spi_mosi;
output	arm_int_n;
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
wire tx_syn1;
wire fire_sync;
syn_m_top u_syn_m(
.tx_syn(tx_syn),
.fire_sync(fire_sync),
//gps inf
.gps_pluse(gps_pluse),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);






//----------- fetch_m_top -----------
wire [15:0]	pkg_data;
wire				pkg_vld;
wire				pkg_frm;
wire [15:0] len_pkg;
fetch_top u_fetch_top(
.rx_a(rx_a),
.rx_b(rx_b),
.pkg_data(pkg_data),
.pkg_vld(pkg_vld),
.pkg_frm(pkg_frm),
//fx bus
.fx_waddr(),
.fx_wr(1'b0),
.fx_data(),
.fx_rd(1'b0),
.fx_raddr(),
.fx_q(),
.mod_id(6'h3),
.len_pkg(len_pkg),
//clk rst
.fire_sync(fire_sync),
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//------------ repkg_top ----------
wire [15:0]	repk_data;
wire				repk_vld;
wire				repk_frm;
repkg_top u_repkg_top(
//data path
.pkg_data(pkg_data),
.pkg_vld(pkg_vld),
.pkg_frm(pkg_frm),
.repk_data(repk_data),
.repk_vld(repk_vld),
.repk_frm(repk_frm),
//fx bus
.fx_waddr(),
.fx_wr(1'b0),
.fx_data(),
.fx_rd(1'b0),
.fx_raddr(),
.fx_q(),
.mod_id(6'h4),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//---------- arm commu_top ----------
commu_m_top u_commu_m(
//arm spi
.spi_csn(spi_csn),
.spi_sck(spi_sck),
.spi_miso(spi_miso),
.spi_mosi(spi_mosi),
.arm_int_n(arm_int_n),
//pkg data
.repk_data(repk_data),
.repk_vld(repk_vld),
.repk_frm(repk_frm),
//fx bus
.fx_waddr(),
.fx_wr(1'b0),
.fx_data(),
.fx_rd(1'b0),
.fx_raddr(),
.fx_q(),
.mod_id(6'h2),
.len_pkg(len_pkg),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule

//top_s.v

module top_m(
//arm spi
pspi_csn,
pspi_sck,
pspi_miso,
pspi_mosi,
cspi_csn,
cspi_sck,
cspi_miso,
cspi_mosi,
arm_int_n,
//485 line
tx_ctrl,
tx_syn,
rx_a,
rx_b,
//syn pluse from GPS
gps_pluse,
mcu_csn,
mcu_sck,
mcu_mosi,
beep,
//hmi
led_gps_n,
led_ch_n,
//clk rst
mclk0,
mclk1,
mclk2,
hrst_n,

led1
);

output led1;
//arm spi
input 	pspi_csn;
input 	pspi_sck;
output	pspi_miso;
input		pspi_mosi;
input 	cspi_csn;
input 	cspi_sck;
output	cspi_miso;
input		cspi_mosi;
output  arm_int_n;
//485 line
output 	tx_ctrl;
output 	tx_syn;
input 	rx_a;
input		rx_b;
//syn pluse from GPS
input gps_pluse;
input 	mcu_csn;
input 	mcu_sck;
input 	mcu_mosi;
output 	beep;
//hmi
output led_gps_n;
output [7:0]	led_ch_n;
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

led_flash flash_inst(
.mclk0(mclk0),
.hrst_n(hrst_n),

.led1(led1),
.led2( ),
.led3( )
);

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



//---------- master_top -----------
wire [15:0]	fx_waddr;
wire				fx_wr;
wire [7:0]	fx_data;
wire				fx_rd;
wire [15:0]	fx_raddr;
wire  [7:0]	fx_q;
wire 				arm_int_n;
master_top u_master_top( 
//arm control spi
.cspi_csn(cspi_csn),
.cspi_sck(cspi_sck),
.cspi_miso(cspi_miso),
.cspi_mosi(cspi_mosi),
//fx bus master
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
//signal line 
.arm_int_n(arm_int_n),
//485 line
.tx_ctrl(tx_ctrl),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- fx_bus_m -----------
wire [7:0]	fx_q_fetch;
wire [7:0]	fx_q_repkg;
wire [7:0]	fx_q_commu;
fx_bus_m u_fx_bus_m(
.fx_q(fx_q),
.fx_q_fetch(fx_q_fetch),
.fx_q_repkg(fx_q_repkg),
.fx_q_commu(fx_q_commu),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//--------- syn_m_top ---------
wire tx_syn1;
wire fire_sync;
wire err_syn_m;
syn_m_top u_syn_m(
.tx_syn(tx_syn),
.fire_sync(fire_sync),
//gps inf
.gps_pluse(gps_pluse),
.mcu_csn(mcu_csn),
.mcu_sck(mcu_sck),
.mcu_mosi(mcu_mosi),
.err(err_syn_m),
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
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_fetch),
.mod_id(6'h33),
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
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_repkg),
.mod_id(6'h34),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);






//---------- arm commu_top ----------
wire wd_arm_high;
commu_m_top u_commu_m(
//arm spi
.spi_csn(pspi_csn),
.spi_sck(pspi_sck),
.spi_miso(pspi_miso),
.spi_mosi(pspi_mosi),
.arm_int_n(arm_int_n),
//pkg data
.repk_data(repk_data),
.repk_vld(repk_vld),
.repk_frm(repk_frm),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q_commu),
.mod_id(6'h32),
.len_pkg(len_pkg),
//clk rst
.wd_arm_high(wd_arm_high),
.pluse_us(pluse_us),
.clk_sys(clk_sys),
.rst_n(rst_n)
);


/*
reg [27:0] cnt_beep;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_beep <= 28'd0;
	else if(err_syn_m | wd_arm_high)
		cnt_beep <= 28'd10_000_00;
	else if(cnt_beep != 28'h0)
		cnt_beep <= cnt_beep - 28'h1;
	else ;
end
//wire beep = (cnt_beep != 28'h0) ? 1'b1 : 1'b0;
wire beep = 1'b0;
*/



hmi_top u_hmi(
.led_gps_n(led_gps_n),
.led_ch_n(led_ch_n),
//input signal
.pkg_data(pkg_data),
.pkg_vld(pkg_vld),
.pkg_frm(pkg_frm),
.gps_pluse(gps_pluse),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);


endmodule

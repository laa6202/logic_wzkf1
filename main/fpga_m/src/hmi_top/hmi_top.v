//hmi_top.v

module hmi_top(
led_gps_n,
led_ch_n,
//input signal
pkg_data,
pkg_vld,
pkg_frm,
gps_pluse,
//clk rst
clk_sys,
pluse_us,
rst_n
);
output 				led_gps_n;
output [7:0]	led_ch_n;
//input signal
input [15:0]	pkg_data;
input				pkg_vld;
input				pkg_frm;
input		gps_pluse;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//--------------------------------------
//--------------------------------------



led_gps u_led_gps(
.led_gps_n(led_gps_n),
.gps_pluse(gps_pluse),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);



led_pkg u_led_pkg(
.led_ch_n(led_ch_n),
//input signal
.pkg_data(pkg_data),
.pkg_vld(pkg_vld),
.pkg_frm(pkg_frm),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);




endmodule


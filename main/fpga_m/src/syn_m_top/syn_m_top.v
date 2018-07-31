//syn_m_top.v

module syn_m_top(
tx_syn,
fire_sync,
//gps inf
gps_pluse,
mcu_csn,
mcu_sck,
mcu_mosi,
err,
//clk rst
clk_sys,
pluse_us,
rst_n
);
output	tx_syn;
output 	fire_sync;
//gps inf
input		gps_pluse;
input 	mcu_csn;
input 	mcu_sck;
input 	mcu_mosi;
output  err;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//-------------------------------------------
//-------------------------------------------


//---------- mcuspi ----------
wire [7:0] 	spi_data;
wire 				spi_vld;
mcuspi_inf u_gps_spi(
//mcu spi
.mcu_csn(mcu_csn),
.mcu_sck(mcu_sck),
.mcu_mosi(mcu_mosi),
//internal control path
.spi_data(spi_data),
.spi_vld(spi_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

wire [31:0] utc_sec_gps;
mcuspi_mac u_spi_mac(
.utc_sec_gps(utc_sec_gps),
.spi_data(spi_data),
.spi_vld(spi_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- syn ----------
wire fire_sync;
wire fire_info;
syn_m_main u_syn_m_main(
.fire_sync(fire_sync),
.fire_info(fire_info),
//gps info
.gps_pluse(gps_pluse),
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n)
);


wire tx_sync;
syn_m_sync u_syn_m_sync( 
.tx_sync(tx_sync),
.fire_sync(fire_sync),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


wire tx_info;
wire err;
syn_m_info u_syn_m_info(
.tx_info(tx_info),
.fire_sync(fire_sync),
.fire_info(fire_info),
.utc_sec_gps(utc_sec_gps),
//clk rst
.err(err),
.pluse_us(pluse_us),
.clk_sys(clk_sys),
.rst_n(rst_n)
);

wire tx_syn =  tx_sync & tx_info;




endmodule

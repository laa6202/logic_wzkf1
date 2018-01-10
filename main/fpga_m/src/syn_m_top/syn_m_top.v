//syn_m_top.v

module syn_m_top(
tx_syn,
fire_sync,
//gps inf
gps_pluse,
//clk rst
clk_sys,
pluse_us,
rst_n
);
output	tx_syn;
output 	fire_sync;
//gps inf
input		gps_pluse;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//-------------------------------------------
//-------------------------------------------

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
syn_m_info u_syn_m_info(
.tx_info(tx_info),
.fire_sync(fire_sync),
.fire_info(fire_info),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

wire tx_syn =  tx_sync & tx_info;


endmodule

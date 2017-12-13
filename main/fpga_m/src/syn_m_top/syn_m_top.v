//syn_m_top.v

module syn_m_top(
tx_syn,
//gps inf
gps_pluse,
//clk rst
clk_sys,
pluse_us,
rst_n
);
output	tx_syn;
//gps inf
input		gps_pluse;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//-------------------------------------------
//-------------------------------------------


syn_m_main u_syn_m_main(
.fire_sync(),
.done_sync(),
.fire_info(),
.done_info(),
//gps info
.gps_pluse(),
//clk rst
.clk_sys(),
.pluse_us(),
.rst_n()
);

endmodule

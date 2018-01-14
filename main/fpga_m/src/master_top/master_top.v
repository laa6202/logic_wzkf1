//master_top.v


module master_top(
//arm control spi
cspi_csn,
cspi_sck,
cspi_miso,
cspi_mosi,
//fx bus master
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
//signal line 
arm_int_n,
//clk rst
clk_sys,
rst_n
);
//arm control spi
input cspi_csn;
input cspi_sck;
output cspi_miso;
input cspi_mosi;
//fx bus master
output [15:0]	fx_waddr;
output				fx_wr;
output [7:0]	fx_data;
output				fx_rd;
output [15:0]	fx_raddr;
input  [7:0]	fx_q;
//signal line 
input  arm_int_n;
//clk rst
input clk_sys;
input rst_n;

//----------------------------------------
//----------------------------------------

// no logic
wire cspi_miso = arm_int_n;


endmodule

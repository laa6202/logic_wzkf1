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
//485 line
tx_ctrl,
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
//485 line
output tx_ctrl;
//clk rst
input clk_sys;
input rst_n;

//----------------------------------------
//----------------------------------------

// no logic
wire cspi_miso = arm_int_n;


//----------- fx_bc -----------
fx_bc_m u_fx_bc(
.cmdl_mod(cmdl_mod),
.cmdl_addr(cmdl_addr),
.cmdl_data(cmdl_data),
.cmdl_vld(cmdl_vld),
.cmdl_q(cmdl_q),
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


endmodule

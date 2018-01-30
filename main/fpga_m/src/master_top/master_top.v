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


//wire cspi_miso = arm_int_n;
//internal control path
wire [7:0]	ctrl_data;
wire				ctrl_dvld;
wire  [7:0]	ctrl_q = 8'h57;
wire				ctrl_qvld = 1'b0;
cspi_inf ucspi_inf(
//arm control spi
.cspi_csn(cspi_csn),
.cspi_sck(cspi_sck),
.cspi_miso(cspi_miso),
.cspi_mosi(cspi_mosi),
//internal control path
.ctrl_data(ctrl_data),
.ctrl_dvld(ctrl_dvld),
.ctrl_q(ctrl_q),
.ctrl_qvld(ctrl_qvld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


wire [7:0]	cmdl_mod;
wire [7:0]	cmdl_addr;
wire [7:0]	cmdl_data;
wire				cmdl_vld;
wire  [7:0]	cmdl_q;


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

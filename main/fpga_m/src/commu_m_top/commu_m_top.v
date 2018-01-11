//commu_m_top.v

module commu_m_top(
//arm spi
spi_csn,
spi_sck,
spi_miso,
spi_mosi,
arm_int_n,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//clk rst
clk_sys,
rst_n
);
//arm spi
input spi_csn;
input spi_sck;
output	spi_miso;
input		spi_mosi;
output	arm_int_n;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------


//------------ commu_m_reg ---------
wire [7:0] cfg_tp;
commu_m_reg u_commu_m_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//configuration
.cfg_tp(cfg_tp),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//--------- spi_inf -----------
wire 				req_rd;
wire [7:0]	req_q;
spi_top u_spi_inf(
//arm rd
.req_rd(req_rd),
.req_q(req_q),
//arm spi
.spi_csn(spi_csn),
.spi_sck(spi_sck),
.spi_miso(spi_miso),
.spi_mosi(spi_mosi),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


endmodule

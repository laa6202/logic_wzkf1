//commu_m_top.v

module commu_m_top(
//arm spi
spi_csn,
spi_sck,
spi_miso,
spi_mosi,
arm_int_n,
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
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------


spi_top u_spi_top(
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

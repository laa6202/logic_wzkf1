//spi_top.v

module spi_top(
//arm rd
req_rd,
req_q,
//arm spi
spi_csn,
spi_sck,
spi_miso,
spi_mosi,
//clk rst
clk_sys,
rst_n
);
//arm rd
output req_rd;
input [7:0]	req_q;
//arm spi
input spi_csn;
input spi_sck;
output	spi_miso;
input		spi_mosi;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------
//-----------------------------------


reg spi_sck_reg;
always @ (posedge clk_sys)
	spi_sck_reg <= spi_sck;
wire spi_sck_rasing = (~spi_sck_reg) & spi_sck;
wire spi_sck_falling = spi_sck_reg & (~spi_sck);





endmodule

//ex_top.v

module ex_top(
exp_data,
//mcu spi
mcu_csn,
mcu_sck,
mcu_mosi,
mcu_sel,
cfg_id,
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
output [255:0]	exp_data;
//mcu port
input mcu_csn;
input mcu_sck;
input mcu_mosi;
input mcu_sel;
input cfg_id;
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
//--------------------------------------
//--------------------------------------


//-------------- ex_reg ---------
ex_reg u_ex_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

//------------ mcu spi ---------
wire [7:0]	spi_data;
wire 				spi_vld;
mcuspi_inf u_mcuspi_inf(
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


//------------ ex_push -----------
ex_push u_ex_push(
.exp_data(exp_data),
.spi_data(spi_data),
.spi_vld(spi_vld),
.mcu_sel(mcu_sel),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule

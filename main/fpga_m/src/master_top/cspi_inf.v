//cspi_inf.v

module cspi_inf(
//arm control spi
cspi_csn,
cspi_sck,
cspi_miso,
cspi_mosi,
//internal control path
ctrl_data,
ctrl_dvld,
ctrl_q,
ctrl_qvld,
//clk rst
clk_sys,
rst_n
);
//arm control spi
input cspi_csn;
input cspi_sck;
output cspi_miso;
input cspi_mosi;
//internal control path
output [7:0]	ctrl_data;
output				ctrl_dvld;
input  [7:0]	ctrl_q;
input					ctrl_qvld;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------
//------------------------------------

//----------- prepare ------------
wire csn;
io_filter u_io_csn(
.io_in(cspi_csn),
.io_real(csn),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);
wire sck;
io_filter u_io_sck(
.io_in(cspi_sck),
.io_real(sck),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

wire csn_r;
wire csn_f;
edge_det u_edge_csn(
.din(csn),
.dr(csn_r),
.df(csn_f),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

wire sck_r;
wire sck_f;
edge_det u_edge_sck(
.din(sck),
.dr(sck_r),
.df(sck_f),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule

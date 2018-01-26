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




endmodule

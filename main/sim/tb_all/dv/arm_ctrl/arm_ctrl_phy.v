//arm_ctrl_phy.v

module arm_ctrl_phy(
fire_cspi,
done_cspi,
//cspi interface
cspi_csn,
cspi_sck,
cspi_miso,
cspi_mosi,
//data path
set_data,
set_vld,
get_q,
get_vld,
//clk rst
clk_sys,
rst_n
);
input		fire_cspi;
output	done_cspi;
//cspi interface
output cspi_csn;
output cspi_sck;
input  cspi_miso;
output cspi_mosi;
//configuration
input [7:0]	set_data;
input				set_vld;
output[7:0]	get_q;
output 			get_vld;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------
//-----------------------------------


wire done_cspi = 1'b1;


endmodule

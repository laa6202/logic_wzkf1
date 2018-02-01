//dev_id.v

module devid_gen(
dev_id,
//fx bus
fx_waddr,
fx_wr,
fx_data,
//mcu spi
spi_data,
spi_vld,
mcu_sel,
//clk rst
clk_sys,
rst_n
);
output [7:0]	dev_id;
//fx bus
input [15:0]	fx_waddr;
input					fx_wr;
input [7:0]		fx_data;
//mcu spi
input [7:0]	spi_data;
input				spi_vld;
input 			mcu_sel;
//clk rst
input	clk_sys;
input	rst_n;
//--------------------------------------
//--------------------------------------

//----------set dev id ---------
reg [7:0]	dev_id;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		dev_id <= 8'hff;
	else if(spi_vld & (~mcu_sel))
		dev_id <= spi_data;
	else if(fx_wr & (fx_waddr == 16'h0))
		dev_id <= fx_data;
	else ;
end


endmodule

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
mcu_a,
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
output [2:0]	mcu_a;
//clk rst
input	clk_sys;
input	rst_n;
//--------------------------------------
//--------------------------------------


wire case1/*synthesis keep*/;
wire case2/*synthesis keep*/;
assign case1 = spi_vld & (~mcu_sel);
assign case2 = fx_wr & (fx_waddr == 16'h0);


//----------set dev id ---------
reg [7:0]	dev_id;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
`ifdef SIM
		dev_id <= 8'h1;
`else
		dev_id <= 8'hff;
`endif
	else if(spi_vld & (~mcu_sel))
		dev_id <= spi_data;
	else if(fx_wr & (fx_waddr == 16'h0))
		dev_id <= fx_data;
	else ;
end


//------------ mcu_a for notify MCU ---------
reg [2:0] mcu_a;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		mcu_a <= 3'h4;
	else if(case1)
		mcu_a <= 3'h1;
	else if(case2)
		mcu_a <= 3'h0;
	else ;
end


endmodule

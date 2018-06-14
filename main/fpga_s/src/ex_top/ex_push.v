//ex_push.v


module ex_push(
exp_data,
spi_data,
spi_vld,
mcu_sel,
mcu_csn2,
//clk rst
clk_sys,
rst_n
);
output [255:0]	exp_data;
input [7:0]	spi_data;
input				spi_vld;
input 			mcu_sel;
input 			mcu_csn2;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------

wire csn2;
io_filter u_filter_csn2(
.io_in(mcu_csn2),
.io_real(csn2),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

reg csn2_reg;
always @ (posedge clk_sys)	csn2_reg <= csn2;
wire csn2_rasing = (~csn2_reg) & csn2;


//---------- data -----------
reg [255:0] data;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		data <= 256'h0;
	else if(spi_vld & mcu_sel)
		data <= {data[247:0],spi_data};
	else ;
end
reg [255:0] exp_data;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		exp_data <= 256'h0;
	else if(csn2_rasing)
		exp_data <= data;
	else ;
end


endmodule

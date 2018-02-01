//ex_push.v


module ex_push(
exp_data,
spi_data,
spi_vld,
mcu_sel,
//clk rst
clk_sys,
rst_n
);
output [255:0]	exp_data;
input [7:0]	spi_data;
input				spi_vld;
input 			mcu_sel;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------

reg [255:0] data;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		data <= 256'h0;
	else if(spi_vld & mcu_sel)
		data <= {data[247:0],spi_data};
	else ;
end
wire [255:0] exp_data = data;


endmodule

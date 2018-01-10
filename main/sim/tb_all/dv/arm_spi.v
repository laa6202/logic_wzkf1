//arm_spi.v

module arm_spi(
//arm spi
spi_csn,
spi_sck,
spi_miso,
spi_mosi,
//clk rst
clk_sys,
rst_n
);
output spi_csn;
output spi_sck;
input	spi_miso;
output spi_mosi;

//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------


//------------ spi_sck ------------
reg [3:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 4'h0;
	else if(cnt_cycle == 4'h9)
		cnt_cycle <= 4'h0;
	else 
		cnt_cycle <= cnt_cycle + 4'h1;
end
wire pluse_10M;
assign pluse_10M = (cnt_cycle == 4'h9) ? 1'b1 : 1'b0;
reg [3:0] cnt_spi_bit;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_spi_bit <= 4'b0;
	else if(pluse_10M) begin
		if(cnt_spi_bit == 4'h9)
			cnt_spi_bit <= 4'h0;
		else 
			cnt_spi_bit <= cnt_spi_bit + 4'h1;
	end
	else ;
end
wire spi_en = (cnt_spi_bit != 4'h8) & (cnt_spi_bit != 4'h9);

reg spi_sck_i;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		spi_sck_i <= 1'b1;
	else if(cnt_cycle == 4'h4)
		spi_sck_i <= 1'b0;
	else if(cnt_cycle == 4'h9)
		spi_sck_i <= 1'b1;
	else ;
end
wire spi_sck = spi_en ? spi_sck_i : 1'b1;




endmodule

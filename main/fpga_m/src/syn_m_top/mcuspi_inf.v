//cspi_inf.v

`define NO_SPI_CSN

module mcuspi_inf(
//mcu spi
mcu_csn,
mcu_sck,
mcu_mosi,
//internal control path
spi_data,
spi_vld,
//clk rst
clk_sys,
rst_n
);
//arm control spi
input mcu_csn;
input mcu_sck;
input mcu_mosi;
//internal control path
output [7:0]	spi_data;
output				spi_vld;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------
//------------------------------------

//----------- prepare ------------
wire csn;
io_filter u_io_csn(
.io_in(mcu_csn),
.io_real(csn),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);
wire sck;
io_filter u_io_sck(
.io_in(mcu_sck),
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


//--------- cnt_sck and sck_wd -------------
reg [2:0] cnt_sck;
wire wd_sck;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_sck <= 3'h0;
`ifndef NO_SPI_CSN
	else if(csn)
		cnt_sck <= 3'h0;
`endif
	else if(wd_sck)
		cnt_sck <= 3'h0;
	else if(sck_r)
		cnt_sck <= cnt_sck + 3'h1;
	else ;
end

reg [2:0] cnt_sck_reg;
always @ (posedge clk_sys)
	cnt_sck_reg <= cnt_sck;
wire cnt_sck_keep = (cnt_sck == cnt_sck_reg) & (cnt_sck != 3'h0);
reg [19:0] cnt_wd;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_wd <= 20'h0;
	else if(cnt_sck_keep)
		cnt_wd <= cnt_wd + 20'h1;
	else 
		cnt_wd <= 20'h0;
end
assign wd_sck= (cnt_wd == 20'd10_000_00) ? 1'b1 : 1'b0;		//10ms


//-------- mosi path ---------
reg [7:0] lock_mset;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		lock_mset <= 8'h0;
	else if(sck_r)
		lock_mset <= {lock_mset[6:0],mcu_mosi};
	else ;
end

wire sck_byte;
assign sck_byte = (cnt_sck == 3'h7) & sck_r;
reg [1:0]	sck_byte_reg;
always @ (posedge clk_sys)
	sck_byte_reg <= {sck_byte_reg[0],sck_byte};

//---------- output ------------
wire [7:0]	spi_data_i;
wire				spi_vld_i;
assign spi_data_i = lock_mset;
assign spi_vld_i = sck_byte_reg[1];

reg [7:0]	spi_data;
reg				spi_vld;
always @(posedge clk_sys)	begin
	if(spi_vld_i) begin
		spi_data <= spi_data_i;
		spi_vld <= 1'b1;
	end
	else 
		spi_vld <= 1'b0;
end


endmodule
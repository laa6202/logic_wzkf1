//spi_inf.v

module spi_top(
//arm rd
req_rd,
req_q,
//arm spi
spi_csn,
spi_sck,
spi_miso,
spi_mosi,
//clk rst
clk_sys,
rst_n
);
//arm rd
output req_rd;
input [7:0]	req_q;
//arm spi
input spi_csn;
input spi_sck;
output	spi_miso;
input		spi_mosi;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------
//-----------------------------------


//---------- spi_filter ---------
wire spi_csn_real;
io_filter spi_cs_filter(
.io_in(spi_csn),
.io_real(spi_csn_real),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//--------- spi sck cap ---------
reg spi_csn_reg;
reg spi_sck_reg;
always @ (posedge clk_sys)	begin
	spi_csn_reg <= spi_csn_real;
	spi_sck_reg <= spi_sck;
end
wire spi_csn_falling = spi_csn_reg & (~spi_csn_real);
wire spi_sck_rasing = (~spi_sck_reg) & spi_sck & (~spi_csn_real);
wire spi_sck_falling = spi_sck_reg & (~spi_sck) & (~spi_csn_real);

reg [3:0]  cnt_spi_bit;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)	
		cnt_spi_bit <= 4'h0;
	else if(spi_sck_rasing)	begin
		if(cnt_spi_bit == 4'h7)
			cnt_spi_bit <= 4'h0;
		else 
			cnt_spi_bit <= cnt_spi_bit + 4'h1;
	end
	else ;
end
	
		
//----------- req read -------------
reg req_rd;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		req_rd <= 1'b0;
	else 
		req_rd <= (cnt_spi_bit == 4'h0) & spi_sck_falling;
end

reg req_rd_dly0;
reg req_rd_dly1;
reg req_rd_dly2;
always @(posedge clk_sys) begin
	req_rd_dly0 <= req_rd;
	req_rd_dly1 <= req_rd_dly0;
	req_rd_dly2 <= req_rd_dly1;
end

reg spi_sck_rasing_dly;

always @(posedge clk_sys)	
	spi_sck_rasing_dly <= spi_sck_rasing;


reg [7:0] req_q_lock;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		req_q_lock <= 8'h0;
	else if(req_rd_dly1 | spi_csn_falling)
		req_q_lock <= req_q;
	else ;
end


//------------- output miso -------------
reg spi_csn_falling_dly;
always @ (posedge clk_sys)
	spi_csn_falling_dly <= spi_csn_falling;
	
reg miso;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		miso <= 1'b1;
	else if(spi_sck_rasing_dly | spi_csn_falling_dly | req_rd_dly2)	begin
		case(cnt_spi_bit)
			4'h0 : miso <= req_q_lock[7];
			4'h1 : miso <= req_q_lock[6];
			4'h2 : miso <= req_q_lock[5];
			4'h3 : miso <= req_q_lock[4];
			4'h4 : miso <= req_q_lock[3];
			4'h5 : miso <= req_q_lock[2];
			4'h6 : miso <= req_q_lock[1];
			4'h7 : miso <= req_q_lock[0];
			default :;
		endcase
	end 
	else ;
end


reg spi_miso;
always @(posedge clk_sys)
	spi_miso <= miso;


endmodule


//mcuspi_mac.v
//decode mcuspu info

module mcuspi_mac(
utc_sec_gps,
utc_sec_vld,
spi_data,
spi_vld,
//clk rst
debug,
clk_sys,
rst_n
);
output [31:0]	utc_sec_gps;
output				utc_sec_vld;
input [7:0]	spi_data;
input				spi_vld;
//clk rst
output debug;
input	clk_sys;
input	rst_n;
//-------------------------------------------
//-------------------------------------------


//---------- cnt_vld -----------
reg [4:0]	cnt_vld;
wire wd_spi/*synthesis keep*/;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_vld <= 5'h0;
	else if(wd_spi)
		cnt_vld <= 5'h0;
	else if(spi_vld)	
		cnt_vld <= (cnt_vld == 5'd17)? 5'h0 : (cnt_vld + 5'h1);
	else ;
end

reg [27:0] cnt_wd_spi;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_wd_spi <= 28'h0;
	else if(spi_vld)
		cnt_wd_spi <= 28'h0;
	else 
		cnt_wd_spi <= cnt_wd_spi + 28'h1;
end
assign wd_spi = (cnt_wd_spi == 28'd800_000_00) ? 1'b1 : 1'b0;


//----------- data recode ----------
reg [31:0] utc_buf;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		utc_buf <= 32'h0;
	else if(spi_vld)begin
		case(cnt_vld)
			5'h8 : utc_buf[31:24] <= spi_data;
			5'h9 : utc_buf[23:16] <= spi_data;
			5'ha : utc_buf[15:8] <= spi_data;
			5'hb : utc_buf[7:0] <= spi_data;
			default : ;
		endcase
	end
	else ;
end


//--------- output ----------
reg [31:0]	utc_sec_gps;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		utc_sec_gps <= 32'h0;
	else if((cnt_vld == 5'd13) & spi_vld)
		utc_sec_gps <= utc_buf;
	else ;
end

reg utc_sec_vld;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		utc_sec_vld <= 1'b0;
	else 
		utc_sec_vld <= (cnt_vld == 5'd13) & spi_vld;
end



//----------- debug ----------
reg [31:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 32'h0;
	else if(utc_sec_vld)
		cnt_cycle <= 32'h0;
	else 
		cnt_cycle <= cnt_cycle + 32'h1;
end
reg [31:0] max_uv;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		max_uv <= 32'h0;
	else if(utc_sec_vld)
		max_uv <= (cnt_cycle > max_uv) ? cnt_cycle : max_uv;
	else ;
end
reg [31:0] min_uv;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		min_uv <= 32'hffff_ffff;
	else if(utc_sec_vld)
		min_uv <= (cnt_cycle < min_uv)?cnt_cycle : min_uv;
	else ;
end


wire debug = ^max_uv ^ ^min_uv;

endmodule


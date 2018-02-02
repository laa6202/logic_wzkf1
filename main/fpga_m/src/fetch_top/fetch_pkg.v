//fetch_pkg.v

module fetch_pkg(
pkg_data,
pkg_vld,
pkg_frm,
rx_vld,
rx_data,
//configration
len_pkg,
//clk rst
clk_sys,
rst_n
);
output [15:0]	pkg_data;
output				pkg_vld;
output				pkg_frm;
input					rx_vld;
input [15:0]	rx_data;
//configuration
input [15:0]	len_pkg;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------------
//-----------------------------------------------

wire [15:0]	lenw_pkg = {1'b0,len_pkg[15:1]};

reg [15:0] cnt_rx;
wire wd_cnt_idle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_rx <= 16'h0;
	else if(wd_cnt_idle)
		cnt_rx <= 16'h0;
	else 	if(cnt_rx == lenw_pkg)
		cnt_rx <= 16'h0;
	else if(rx_vld)	
		cnt_rx <= cnt_rx + 16'h1;
	else ;
end

reg [19:0] cnt_idle;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_idle <= 20'h0;
	else if(rx_vld)
		cnt_idle <= 20'h0;
	else if(cnt_idle == 20'hfffff)
		cnt_idle <= 20'hfffff;
	else 
		cnt_idle <= cnt_idle + 20'h1;
end
assign wd_cnt_idle = (cnt_idle == 20'd1_000_00) ? 1'b1 : 1'b0;


wire pkg_sop;
wire pkg_eop;
assign pkg_sop = (cnt_rx == 16'h0) & rx_vld;
assign pkg_eop = (cnt_rx == lenw_pkg) | wd_cnt_idle;


//------------ pkg output -----------
reg pkg_frm;
always @ (posedge clk_sys or negedge rst_n) begin
	if(~rst_n)
		pkg_frm <= 1'b0;
	else if(pkg_eop)
		pkg_frm <= 1'b0;
	else if(pkg_sop)
		pkg_frm <= 1'b1;
	else ;
end
reg pkg_vld;
reg [15:0] pkg_data;
always @(posedge clk_sys)	begin
	pkg_vld <= rx_vld;
	pkg_data <= rx_data;
end

endmodule

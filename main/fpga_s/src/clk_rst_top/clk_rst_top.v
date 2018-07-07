//clk_rst_top.v


module clk_rst_top(
hrst_n,
mclk0,
mclk1,
mclk2,
clk_sys,
clk_slow,
clk_10m,
pluse_us,
rst_n
);
input hrst_n;
input mclk0;
input mclk1;
input mclk2;
output clk_sys;
output clk_slow;
output clk_10m;
output pluse_us;
output rst_n;
//---------------------------------
//---------------------------------

wire rst_n;
assign rst_n = hrst_n;

wire clk_100m;
wire clk_1m;
`ifndef SIM
sgpll u_sgpll(
.areset(1'b0),
.inclk0(mclk0),
.c0(clk_100m),
.c1(clk_1m),
.locked()
);
`else
assign clk_100m = mclk1;
assign clk_1m = mclk2;
`endif

wire clk_sys;
assign clk_sys = clk_100m;
wire clk_slow;
assign clk_slow = clk_1m;


//----------- gen pluse 1us at cly_sys zone-------
pluse_us_gen u_pluse_us_gen(
.pluse_us(pluse_us),
.clk_sys(clk_sys),
.rst_n(rst_n)
);





reg [2:0]ad_clk_10M_cnt;
reg ad_clk_10M;
always @(posedge clk_sys or negedge rst_n)
begin
	if(~rst_n)
		ad_clk_10M_cnt <= 3'd0;
	else if(ad_clk_10M_cnt < 3'd4)
		ad_clk_10M_cnt <= ad_clk_10M_cnt + 3'd1;
	else 
		ad_clk_10M_cnt <= 3'd0;
end

always @(posedge clk_sys or negedge rst_n)
begin
	if(~rst_n)
		ad_clk_10M <= 1'b0;
	else if(ad_clk_10M_cnt == 3'd0)
		ad_clk_10M <= ~ad_clk_10M;
	else 
		;
end


wire clk_10m = ad_clk_10M;

endmodule

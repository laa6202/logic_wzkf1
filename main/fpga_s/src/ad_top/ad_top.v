//ad_top.v

module ad_top(
//data path output
ad_data,
ad_vld,
//adc interface
ad_mclk,
ad_clk,
ad_din,
ad_cfg,
ad_sync,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//configuration
cfg_sample,
//clk rst
syn_vld,
clk_sys,
pluse_us,
rst_n
);
//data path output
output [23:0]	ad_data;
output				ad_vld;
//adc interface
output ad_mclk;
output ad_clk;
input   ad_din;
output ad_cfg;
output ad_sync;

//fx bus
input [15:0]	fx_waddr;
input 				fx_wr;
input [7:0]		fx_data;
input					fx_rd;
input [15:0]	fx_raddr;
output	[7:0]	fx_q;
input [5:0]		mod_id;
//configuration
output [7:0]	cfg_sample;
//clk rst
input syn_vld;
input clk_sys;
input pluse_us;
input rst_n;
//--------------------------------------
//--------------------------------------


//---------- ad_clk_gen ----------
wire clk_2kHz;
wire clk_2_5M;
wire clk_5M;
ad_clk_gen   u_ad_clk_gen(
//clk rst
.clk_sys(clk_sys),
.pluse_us(pluse_us),
.rst_n(rst_n),
.clk_2M(clk_2M),
.clk_2_5M(clk_2_5M),
.clk_5M(clk_5M),
.clk_2kHz(clk_2kHz)
);
assign ad_mclk   = clk_2M;


wire [7:0]	cfg_sample;
wire [7:0]	cfg_ad_tp;
wire [23:0]	cfg_tp_base;
wire [7:0]	cfg_tp_step;
ad_reg u_ad_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//configuration
.cfg_sample(cfg_sample),
.cfg_ad_tp(cfg_ad_tp),
.cfg_tp_base(cfg_tp_base),
.cfg_tp_step(cfg_tp_step),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- ad_sample ----------
wire [23:0]	real_data;
wire	real_vld;
reg ad_sync_1s;
ad_sample u_ad_sample(
//adc interface
.ad_clk_in(clk_2_5M),//系统产生2.5M时钟，输入到此模块
.ad_clk(ad_clk),//ad_clk = ad_clk_in | ad_clk_vld ,//将系统产生的2.5M信号定时送到AD7195的clk引脚
.clk_2kHz(clk_2kHz),//no use
.ad_din(ad_din),//AD7195的串行数据输出引脚
.ad_cfg(ad_cfg),//AD7195的串行配置引脚
.ad_sync(ad_sync),//AD7195的同步引脚
//data path
.ad_data(real_data),
.ad_vld(real_vld),
.ad_sync_in(ad_sync_1s),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


/*
//测试每秒同步一次ad_sample 模块
reg [15:0]cnt_sync;
always @(posedge clk_sys or negedge rst_n)
begin
	if(~rst_n)
		cnt_sync <= 16'd0;
	else if(cnt_sync < 16'd1999)
	begin
		if(real_vld)
			cnt_sync <= cnt_sync + 16'd1;
	end
	else
		cnt_sync <= 16'd0;
end


always @ (posedge clk_sys or negedge rst_n)
begin
	if(~rst_n)
		ad_sync_1s <= 1'b1;
	else 
	begin
	if(cnt_sync == 16'd1999)
		ad_sync_1s <= 1'b0;
	if(cnt_dly > 16'd1000)
		ad_sync_1s <= 1'b1;
	end
end

reg [15:0]cnt_dly;
always @ (posedge clk_sys or negedge rst_n)
begin
	if(~rst_n)
		cnt_dly <= 16'd0;
	else if(~ad_sync_1s)
		cnt_dly <= cnt_dly + 16'd1;
	else
	    cnt_dly <= 16'd0;
end

//测试每秒同步一次ad_sample 模块结束
*/

//----------- ad_tp --------
wire [23:0]	tp_data;
wire				tp_vld;
ad_tp u_ad_tp(
.tp_data(tp_data),
.tp_vld(tp_vld),
//configuration
.cfg_sample(cfg_sample),
.cfg_ad_tp(cfg_ad_tp),
.cfg_tp_base(cfg_tp_base),
.cfg_tp_step(cfg_tp_step),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- ad_mux -------
ad_mux u_ad_mux(
.ad_data(ad_data),
.ad_vld(ad_vld),
.tp_data(tp_data),
.tp_vld(tp_vld),
.real_data(real_data),
.real_vld(real_vld),
//configuration
.cfg_ad_tp(cfg_ad_tp),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule

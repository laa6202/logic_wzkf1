//ad_tp.v
//ad_tp.v

module ad_tp(
tp_data,
tp_vld,
//configuration
cfg_sample,
cfg_ad_tp,
cfg_ad_fix,
cfg_tp_base,
cfg_tp_step,
//clk rst
mod_id,
syn_vld,
clk_sys,
rst_n
);
output [23:0]	tp_data;
output				tp_vld;
//configuration
input [7:0]	cfg_sample;
input [7:0]	cfg_ad_tp;
input [23:0]cfg_ad_fix;
input [23:0]cfg_tp_base;
input [7:0]	cfg_tp_step;
//clk rst
input [5:0] mod_id;
input syn_vld;
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------


reg [23:0] 	cfg_tp_base_reg;
reg [7:0]		cfg_tp_step_reg;
always @ (posedge clk_sys)	begin
	cfg_tp_base_reg <= cfg_tp_base;
	cfg_tp_step_reg <= cfg_tp_step;
end
wire cfg_tp_change = 	(cfg_tp_base_reg != cfg_tp_base) | 
											(cfg_tp_step_reg != cfg_tp_step);

//----------- tp_period -------------
wire [23:0]	tp_period;
`ifdef SIM
assign tp_period = 	(cfg_sample == 8'd20) ? 24'd50 :			//2M = 500ns
										(cfg_sample == 8'd10) ? 24'd1_00 :		//1M = 1us
										(cfg_sample == 8'd5) ? 24'd2_00 :			//500K =2us
										(cfg_sample == 8'd2) ? 24'd5_00 : 	//200K= 5us
										(cfg_sample == 8'd1) ? 24'd10_00 : 	//100K = 10us
										24'd1_000_00;
`else
assign tp_period = 	(cfg_sample == 8'd20) ? 24'd500_00 :			//2K = 500us
										(cfg_sample == 8'd10) ? 24'd1_000_00 :		//1K = 1ms
										(cfg_sample == 8'd5) ? 24'd2_000_00 :			//500Hz =	2ms
										(cfg_sample == 8'd2) ? 24'd5_000_00 : 	//200Hz = 5ms
										(cfg_sample == 8'd1) ? 24'd10_000_00 : 	//100Hz = 10ms
										24'd500_00;
`endif

reg [23:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 24'h0;
	else if(syn_vld)
		cnt_cycle <= 24'h0;
	else if(cnt_cycle == (tp_period - 24'h1))
		cnt_cycle <= 24'h0;
	else 
		cnt_cycle <= cnt_cycle + 24'h1;
end
wire period_vld = (cnt_cycle == (tp_period - 24'h1)) ? 1'b1 : 1'b0;


//----------- test pattern output -----------
wire [23:0] tp1_data = 	(mod_id[1:0] == 2'h1) ? 24'h111111 :
												(mod_id[1:0] == 2'h2) ? 24'h222222 :
												(mod_id[1:0] == 2'h3) ? 24'h333333 : 24'h999999;
wire [23:0] tp3_data = cfg_ad_fix;
reg [23:0] tp2_data;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		tp2_data <= cfg_tp_base;
	else if(cfg_tp_change)
		tp2_data <= cfg_tp_base;
	else if(period_vld)
		tp2_data <= tp2_data + {16'h0, cfg_tp_step};
	else ;
end
reg tp_vld;
always @(posedge clk_sys or negedge rst_n)	begin	
	if(~rst_n)
		tp_vld <= 1'b0;
	else 
		tp_vld <= period_vld ? 1'b1 : 1'b0;
end
wire [23:0] tp_data;
assign tp_data = 	(cfg_ad_tp == 8'h1) ? tp1_data :
									(cfg_ad_tp == 8'h2) ? tp2_data : 
									(cfg_ad_tp == 8'h3) ? tp3_data : 24'h555555;


endmodule

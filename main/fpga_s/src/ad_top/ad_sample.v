//ad_sample.v

`define PERIOD 32'd0_499_99
`define CFG_REG8A		8'h10
`define CFG_REG8B		8'h50
`define CFG_REG8C		8'h5C
`define CFG_REG24A	24'h000110

`define CFG_REG8D		8'h08
`define CFG_REG8E		8'h48
`define CFG_REG24B	24'h088004 //24'h088001--4.8KHz  24'h088002--2.4KHz 24'h088004--1.2kHz

module ad_sample(
//adc interface
ad_clk_in,//系统产生2.5M时钟，输入到此模块
ad_clk,   //ad_clk = ad_clk_in | ad_clk_vld ; //将系统产生的2.5M信号定时送到AD7195的clk引脚
clk_2kHz, //没有使用
ad_din,   //AD7195的串行数据输出引脚
ad_cfg,   //AD7195的串行配置引脚
ad_sync,  //AD7195的同步引脚，没隔1999个采用数据同步一次，第2000个自动补齐
//data path
ad_data,
ad_vld,
ad_sync_in,//每隔1s输入一个负脉冲同步信号，此信号用于同步所有的AD7195芯片
//clk rst
clk_sys,
rst_n,
//debug
debug
);

//adc interface
input  ad_clk_in;
output ad_clk;
input  clk_2kHz;
input  ad_din;
output  ad_cfg;
output ad_sync;
//data path
output [23:0] ad_data;
output 		  ad_vld;
input ad_sync_in;
//clk rst
input clk_sys;
input rst_n;
//debug
output debug;

//--------------------------------------------------------
//--------------------------------------------------------




reg[2:0] ad_clk_r;
always @ ( posedge clk_sys or negedge rst_n )
  if(~rst_n)
     ad_clk_r <= 0;
  else
     ad_clk_r <= { ad_clk_r[1:0], ad_clk_in};

wire ad_clk_in_rising  = ad_clk_r[1] && ( ~ad_clk_r[2] );       
wire ad_clk_in_falling = ( ~ad_clk_r[1] ) && ad_clk_r[2]; 

reg[2:0] clk_2kHz_r;
always @ ( posedge clk_sys or negedge rst_n )
  if(~rst_n)
     clk_2kHz_r <= 0;
  else
     clk_2kHz_r <= { clk_2kHz_r[1:0], clk_2kHz};

wire clk_2kHz_rising  = clk_2kHz_r[1] && ( ~clk_2kHz_r[2] );       
wire clk_2kHz_falling = ( ~clk_2kHz_r[1] ) && clk_2kHz_r[2]; 

reg[2:0] ad_din_r;
always @ ( posedge clk_sys or negedge rst_n )
  if(~rst_n)
     ad_din_r <= 0;
  else
     ad_din_r <= { ad_din_r[1:0], ad_din};

wire ad_din_rising  = ad_din_r[1] && ( ~ad_din_r[2] );       
wire ad_din_falling = ( ~ad_din_r[1] ) && ad_din_r[2];



//------------- main FSM --------------

//main STATE 
parameter S_INIT = 4'h0;
parameter S_IDLE = 4'h8;
parameter S_AD_RESET = 4'h1;
parameter S_AD_UNRST = 4'h9;
parameter S_AD_RESET_DLY = 4'h6;
parameter S_AD_CONFIG = 4'h2;
parameter S_AD_SAMPLE = 4'h3;
parameter S_DATA_PUSH = 4'h4;

wire finish_init;
wire finish_rst;
wire finish_unrst;
wire finish_sample;
reg [3:0] st_ad_p1;

reg [15:0] cnt_config;
wire sample_fire;
reg [7:0] cnt_sample;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_ad_p1 <= S_INIT;
	else begin
		case(st_ad_p1)
			S_INIT : 			st_ad_p1 <= finish_init ? S_IDLE : S_INIT;		
			S_IDLE : 			st_ad_p1 <= S_AD_RESET;
			S_AD_RESET : 	st_ad_p1 <= finish_rst ? S_AD_UNRST : S_AD_RESET;
			S_AD_UNRST :  st_ad_p1 <= finish_unrst ? S_AD_CONFIG : S_AD_UNRST;
			S_AD_CONFIG : st_ad_p1 <= (cnt_config > 16'd1250) ? S_AD_RESET_DLY : S_AD_CONFIG;
			S_AD_RESET_DLY : st_ad_p1 <= (ad_din_falling & (ad_vld_cnt<16'd3000))? S_AD_SAMPLE : S_AD_RESET_DLY;
			S_AD_SAMPLE : st_ad_p1 <= finish_sample ? S_DATA_PUSH : S_AD_SAMPLE;
			S_DATA_PUSH : st_ad_p1 <= S_AD_RESET_DLY;
			default : st_ad_p1 <= S_IDLE;
		endcase
	end
end


//----------- FMS switch condition ---------
reg [19:0] cnt_init;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_init <= 20'h0;
	else if(st_ad_p1 == S_INIT)
		cnt_init <= cnt_init + 20'h1;
	else 
		cnt_init <= 20'h0;
end
`ifdef SIM
assign finish_init = (cnt_init == 20'hf) ? 1'b1 : 1'b0;
`else 
assign finish_init = (cnt_init == 20'hfffff) ? 1'b1 : 1'b0;
`endif

reg [31:0]cnt_period;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_period <= 32'd0;
	else if(st_ad_p1 == S_DATA_PUSH)
		cnt_period <= 32'd0;
	else if((st_ad_p1 == S_AD_RESET_DLY) | (st_ad_p1 == S_AD_SAMPLE))
		cnt_period <= cnt_period + 32'd1;
	else 
		cnt_period <= 32'd0;
end
`ifdef SIM
assign sample_fire = (cnt_period == 32'd499) ? 1'b1 : 1'b0;
`else
assign sample_fire = (cnt_period == `PERIOD) ? 1'b1 : 1'b0;
`endif

reg [19:0] cnt_reset;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_reset <= 20'd0;
	else if((ad_clk_in_rising)&&(st_ad_p1 == S_AD_RESET))
		cnt_reset <= cnt_reset + 20'd1;
	else ;
end
`ifdef SIM
assign finish_rst = (cnt_reset == 20'd10) ? 1'b1 : 1'b0;
`else 
assign finish_rst = (cnt_reset == 20'd600) ?  1'b1 : 1'b0;
`endif

reg [31:0] cnt_unrst;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_unrst <= 32'd0;
	else if(st_ad_p1 == S_AD_UNRST)
		cnt_unrst <= cnt_unrst + 32'd1;
	else 
		cnt_unrst <= 32'h0;
end
`ifdef SIM
assign finish_unrst = (cnt_unrst == 32'd10_00) ? 1'b1 : 1'b0;
`else 
assign finish_unrst = (cnt_unrst == 32'd10_000_00) ?  1'b1 : 1'b0;
`endif

always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_config <= 16'd0;
	else if((ad_clk_in_rising)&&(st_ad_p1 == S_AD_CONFIG))
		cnt_config <= cnt_config + 16'd1;
	else ;
end


always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_sample <= 8'd0;
	else if(st_ad_p1 == S_AD_SAMPLE)
		cnt_sample <= ad_clk_in_rising ? (cnt_sample + 8'd1) : cnt_sample;
	else 
		cnt_sample <= 8'd0;
end
assign finish_sample = (cnt_sample == 8'd26) ? 1'b1 :1'b0;


//--------- handle unexpect --------

//----------- data output -----------
reg ad_cfg;
reg ad_clk_vld;
reg [7:0]cfg_reg8;
reg [23:0]ret_reg24;
reg [23:0]got_ad_value;
reg [23:0]cfg_reg24;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n) begin
		ad_clk_vld <= 1'b1;
		ad_cfg <= 1'b1;
		got_ad_value <= 24'h0;
		ret_reg24 <= 24'h0;
		cfg_reg8 <= 8'h0;
		cfg_reg24 <= 24'h0;
	end
	else	begin
		case(st_ad_p1)
			S_INIT : 	  begin ad_cfg <= 1'b1; ad_clk_vld <= 1'b1;end
			S_IDLE : 	  begin ad_cfg <= 1'b1; ad_clk_vld <= 1'b1;end
			S_AD_RESET : begin ad_cfg <= 1'b1; ad_clk_vld <= 1'b0;end
			S_AD_UNRST : begin ad_cfg <= 1'b0; ad_clk_vld <= 1'b1;end
			S_AD_RESET_DLY : begin ad_cfg <= 1'b0; ad_clk_vld <= 1'b1; end
			S_AD_CONFIG : 
			begin
				if(cnt_config == 16'd0) begin
					ad_cfg <= 1'b0;
					ad_clk_vld <= 1'b1;
				end
				else if(cnt_config == 16'd61) 
					cfg_reg8 <= `CFG_REG8A;
				else if((cnt_config == 16'd70)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg8[7];
				end
				else if((cnt_config >16'd70)&(cnt_config < 16'd77)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg8[16'd77-cnt_config];
				end
				else if((cnt_config == 16'd77)&(ad_clk_in_rising))
				begin
				   ad_clk_vld <= 1'b1;
				   ad_cfg <= cfg_reg8[0];
				end
				else if((cnt_config == 16'd78)&(ad_clk_in_rising))
				begin  
						ad_cfg <= 1'b0;
				end
				    //writing 1 byte end
		 
				else if(cnt_config == 16'd81)//writing 3 byte begin 
					cfg_reg24 <= `CFG_REG24A;
				else if((cnt_config == 16'd90)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg24[23];
				end
				else if((cnt_config >16'd90)&(cnt_config < 16'd113)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg24[16'd113-cnt_config];
				end
				else if((cnt_config == 16'd113)&(ad_clk_in_rising))
			    ad_clk_vld <= 1'b1;
				else if((cnt_config == 16'd113)&(ad_clk_in_falling))
				  ad_cfg <= cfg_reg24[0];
				else if((cnt_config == 16'd114)&(ad_clk_in_falling))
					ad_cfg <= 1'b0;
				    //writing 3 byte end
				
				
				
				
				//writing 1 byte begin
				else if(cnt_config == 16'd121) 
					cfg_reg8 <= `CFG_REG8B;
				else if((cnt_config == 16'd130)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg8[7];
				end
				else if((cnt_config >16'd130)&(cnt_config < 16'd137)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg8[16'd137-cnt_config];
				end
				else if((cnt_config == 16'd137)&(ad_clk_in_rising))
				begin
				   ad_clk_vld <= 1'b1;
				   ad_cfg <= cfg_reg8[0];
				end
				else if((cnt_config == 16'd138)&(ad_clk_in_rising))
				begin  
						ad_cfg <= 1'b0;
				end
				    //writing 1 byte end
				
				
				// reading 3 bytes begin	
				else if((cnt_config == 16'd170)&(ad_clk_in_falling))
				begin
						ad_clk_vld <= 1'b0;
				end
				else if((cnt_config == 16'd170)&(ad_clk_in_rising))
					 ret_reg24[23] <= ad_din;
				else if((cnt_config == 16'd171)&(ad_clk_in_falling))
				begin
					 ret_reg24[22] <= ad_din;
				end
				else if((16'd171 < cnt_config )&(cnt_config <16'd194)&(ad_clk_in_falling))
				begin
					 ret_reg24[16'd193-cnt_config] <= ad_din;
				end
				else if((cnt_config == 16'd193)&(ad_clk_in_rising))
				begin
					ad_clk_vld <= 1'b1;
					// if disable output 
					ret_reg24 <= 24'h0;
				end
				
				/////////////write next MODE register
				else if(cnt_config == 16'd261) 
					cfg_reg8 <= `CFG_REG8D;
				else if((cnt_config == 16'd270)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg8[7];
				end
				else if((cnt_config >16'd270)&(cnt_config < 16'd277)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg8[16'd277-cnt_config];
				end
				else if((cnt_config == 16'd277)&(ad_clk_in_rising))
				begin
				   ad_clk_vld <= 1'b1;
				   ad_cfg <= cfg_reg8[0];
				end
				else if((cnt_config == 16'd278)&(ad_clk_in_rising))
				begin  
						ad_cfg <= 1'b0;
				end
				    //writing 1 byte end
		 
				else if(cnt_config == 16'd281)//writing 3 byte begin 
					cfg_reg24 <= `CFG_REG24B;
				else if((cnt_config == 16'd290)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg24[23];
				end
				else if((cnt_config >16'd290)&(cnt_config < 16'd313)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg24[16'd313-cnt_config];
				end
				else if((cnt_config == 16'd313)&(ad_clk_in_rising))
			    ad_clk_vld <= 1'b1;
				else if((cnt_config == 16'd313)&(ad_clk_in_falling))
				  ad_cfg <= cfg_reg24[0];
				else if((cnt_config == 16'd314)&(ad_clk_in_falling))
					ad_cfg <= 1'b0;
				    //writing 3 byte end
				
				
				
				
				//writing 1 byte begin
				else if(cnt_config == 16'd321) 
					cfg_reg8 <= `CFG_REG8E;
				else if((cnt_config == 16'd330)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg8[7];
				end
				else if((cnt_config >16'd330)&(cnt_config < 16'd337)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg8[16'd337-cnt_config];
				end
				else if((cnt_config == 16'd337)&(ad_clk_in_rising))
				begin
				   ad_clk_vld <= 1'b1;
				   ad_cfg <= cfg_reg8[0];
				end
				else if((cnt_config == 16'd338)&(ad_clk_in_rising))
				begin  
						ad_cfg <= 1'b0;
				end
				    //writing 1 byte end
				
				
				// reading 3 bytes begin	
				else if((cnt_config == 16'd370)&(ad_clk_in_falling))
				begin
						ad_clk_vld <= 1'b0;
				end
				else if((cnt_config == 16'd370)&(ad_clk_in_rising))
					 ret_reg24[23] <= ad_din;
				else if((cnt_config == 16'd371)&(ad_clk_in_falling))
				begin
					 ret_reg24[22] <= ad_din;
				end
				else if((16'd371 < cnt_config )&(cnt_config <16'd394)&(ad_clk_in_falling))
				begin
					 ret_reg24[16'd393-cnt_config] <= ad_din;
				end
				else if((cnt_config == 16'd393)&(ad_clk_in_rising))
				begin
					ad_clk_vld <= 1'b1;
					// if disable output 
					ret_reg24 <= 24'h0;
				end
				///////////////////config  MODE END ////////////////////////////
				
				//writing 1 byte begin
				else if(cnt_config == 16'd1221) 
					cfg_reg8 <= `CFG_REG8C;
				else if((cnt_config == 16'd1230)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg8[7];
				end
				else if((cnt_config >16'd1230)&(cnt_config < 16'd1237)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg8[16'd1237-cnt_config];
				end
				else if((cnt_config == 16'd1237)&(ad_clk_in_rising))
				begin
					ad_clk_vld <= 1'b1;
					ad_cfg <= cfg_reg8[0];
				end
				else if((cnt_config == 16'd1238)&(ad_clk_in_rising))
				begin  
					ad_cfg <= 1'b0;
					ad_clk_vld <= 1'b1;
				end
				    //writing 1 byte end
			end
			
			
			
			S_AD_SAMPLE : begin
					// reading 3 bytes begin	
					if((cnt_sample == 8'd1)&(ad_clk_in_falling))
						ad_clk_vld <= 1'b0;
					else if((cnt_sample == 8'd1)&(ad_clk_in_rising))
						got_ad_value[23] <= ad_din;
					else if((cnt_sample == 8'd2)&(ad_clk_in_falling))
					begin
						got_ad_value[22] <= ad_din;
					end
					else if((8'd2 < cnt_sample )&(cnt_sample <8'd25)&(ad_clk_in_falling))
					begin
						 got_ad_value[8'd24-cnt_sample] <= ad_din;
					end
					else if((cnt_sample == 8'd24)&(ad_clk_in_rising))
					begin
						ad_clk_vld <= 1'b1;
						//if enable output
						//got_ad_value <= 24'h0;
					end
			
			end
			
			S_DATA_PUSH :  begin ad_cfg <= 1'b0; ad_clk_vld <= 1'b1;end
			default :  begin ad_cfg <= 1'b0; ad_clk_vld <= 1'b1;end
		endcase
	end
end



reg [15:0]ad_vld_cnt;
always @(posedge clk_sys or negedge rst_n)
begin
	if(~rst_n)
		ad_vld_cnt <= 16'd0;
	else if(~ad_sync_in)
		ad_vld_cnt <= 16'd0;
	else if((ad_vld)&(ad_vld_cnt < 16'd3000))
		ad_vld_cnt <= ad_vld_cnt + 16'd1;
	else 
	    ;
		
end




wire ad_clk;

assign ad_clk = ad_clk_in | ad_clk_vld ; //enable ad_clk 
assign ad_vld = (st_ad_p1 == S_DATA_PUSH) ? 1'b1 :1'b0;
assign ad_data = got_ad_value;
assign ad_sync = ad_sync_in;

assign debug = &cnt_period;


endmodule


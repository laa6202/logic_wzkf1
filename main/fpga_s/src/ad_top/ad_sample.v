//ad_sample.v
module ad_sample(
//adc interface
ad_clk_in,
ad_clk,//2.5M
clk_2kHz,
ad_din,
ad_cfg,
ad_sync,
//data path
ad_data,
ad_vld,
//clk rst
clk_sys,
rst_n
);

//adc interface
input  ad_clk_in;
output ad_clk;
input  clk_2kHz;
input  ad_din;
output  ad_cfg;
output ad_sync;
//clk rst
input clk_sys;
input rst_n;
//data path
output [23:0] ad_data;
output ad_vld;
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



//------------- main FSM --------------

//main STATE 
parameter S_IDLE = 3'h0;
parameter S_AD_RESET = 3'h1;
parameter S_AD_RESET_DLY = 3'h6;
parameter S_AD_CONFIG = 3'h2;
parameter S_AD_SAMPLE = 3'h3;
parameter S_DATA_PUSH = 3'h4;
parameter S_DONE      = 3'h5;


reg [2:0] st_ad_p1;
reg [5:0]rst_cnt;
reg [7:0] config_cnt;
reg [15:0]dly_cnt;
reg [7:0] sample_cnt;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_ad_p1 <= S_IDLE;
	else begin
		case(st_ad_p1)
			S_IDLE : 			st_ad_p1 <= 1'b1 ? S_AD_RESET : S_IDLE;
			S_AD_RESET : 	st_ad_p1 <= (rst_cnt == 6'd60) ? S_AD_CONFIG : S_AD_RESET;
			S_AD_CONFIG : st_ad_p1 <= (config_cnt > 8'd190) ? S_AD_RESET_DLY : S_AD_CONFIG;
			S_AD_RESET_DLY : st_ad_p1 <= ((dly_cnt == 16'd20000)&(~ad_din))? S_AD_SAMPLE : S_AD_RESET_DLY;
			S_AD_SAMPLE : st_ad_p1 <= (sample_cnt == 240)? S_DATA_PUSH : S_AD_SAMPLE;
			S_DATA_PUSH : st_ad_p1 <= S_AD_RESET_DLY;
			S_DONE : st_ad_p1 <= S_IDLE;
			default : st_ad_p1 <= S_IDLE;
		endcase
	end
end


//----------- FMS switch condition ---------
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		dly_cnt <= 16'd0;
	else if((dly_cnt < 16'd20000)&&(st_ad_p1 == S_AD_RESET_DLY))
		dly_cnt <= dly_cnt + 16'd1;
	else if(st_ad_p1 == S_AD_SAMPLE)
		dly_cnt <= 16'd0;
	else ;
end


always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rst_cnt <= 6'd0;
	else if((rst_cnt < 6'd60)&&(ad_clk_in_rising)&&(st_ad_p1 == S_AD_RESET))
		rst_cnt <= rst_cnt + 6'd1;
	else ;
end


always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		config_cnt <= 8'd0;
	else if((config_cnt < 8'd252)&&(ad_clk_in_rising)&&(st_ad_p1 == S_AD_CONFIG))
		config_cnt <= config_cnt + 8'd1;
	else ;
end


always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		sample_cnt <= 8'd0;
	else if((sample_cnt < 8'd240)&&(ad_clk_in_rising)&&(st_ad_p1 == S_AD_SAMPLE))
		sample_cnt <= sample_cnt + 8'd1;
	else if(sample_cnt == 8'd240)
		sample_cnt <= 8'd0;
	else ;
end


//----------- data output -----------
reg ad_cfg;
reg ad_clk_vld;
reg [7:0]cfg_reg8;
reg [23:0]ret_reg24;
reg [23:0]got_ad_value;
reg [23:0]cfg_reg24;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		ad_clk_vld <= 1'b1;
	else
	begin
		case(st_ad_p1)
			S_IDLE : 	  begin ad_cfg <= 1'b1; ad_clk_vld <= 1'b1;end
			S_AD_RESET :  begin ad_cfg <= 1'b1; ad_clk_vld <= 1'b0;end
			S_AD_RESET_DLY : begin ad_clk_vld <= 1'b1; ad_cfg <= 1'b0;end
			S_AD_CONFIG : 
			begin
				if(config_cnt == 8'd61) 
					cfg_reg8 <= 8'h10;
				else if((config_cnt == 8'd70)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg8[7];
				end
				else if((config_cnt >8'd70)&(config_cnt < 8'd77)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg8[8'd77-config_cnt];
				end
				else if((config_cnt == 8'd77)&(ad_clk_in_rising))
				begin
				   ad_clk_vld <= 1'b1;
				   ad_cfg <= cfg_reg8[0];
				end
				else if((config_cnt == 8'd78)&(ad_clk_in_rising))
				begin  
						ad_cfg <= 1'b0;
				end
				    //writing 1 byte end
		 
				else if(config_cnt == 8'd81)//writing 3 byte begin 
					cfg_reg24 <= 24'h000116;
				else if((config_cnt == 8'd90)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg24[23];
				end
				else if((config_cnt >8'd90)&(config_cnt < 8'd113)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg24[8'd113-config_cnt];
				end
				else if((config_cnt == 8'd113)&(ad_clk_in_rising))
			    ad_clk_vld <= 1'b1;
				else if((config_cnt == 8'd113)&(ad_clk_in_falling))
				  ad_cfg <= cfg_reg24[0];
				else if((config_cnt == 8'd114)&(ad_clk_in_falling))
					ad_cfg <= 1'b0;
				    //writing 3 byte end
				
				
				
				
				//writing 1 byte begin
				else if(config_cnt == 8'd121) 
					cfg_reg8 <= 8'h50;
				else if((config_cnt == 8'd130)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg8[7];
				end
				else if((config_cnt >8'd130)&(config_cnt < 8'd137)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg8[8'd137-config_cnt];
				end
				else if((config_cnt == 8'd137)&(ad_clk_in_rising))
				begin
				   ad_clk_vld <= 1'b1;
				   ad_cfg <= cfg_reg8[0];
				end
				else if((config_cnt == 8'd138)&(ad_clk_in_rising))
				begin  
						ad_cfg <= 1'b0;
				end
				    //writing 1 byte end
				
				
				// reading 3 bytes begin	
				else if((config_cnt == 8'd140)&(ad_clk_in_falling))
				begin
						ad_clk_vld <= 1'b0;
				end
				else if((config_cnt == 8'd140)&(ad_clk_in_rising))
					 ret_reg24[23] <= ad_din;
				else if((config_cnt == 8'd141)&(ad_clk_in_falling))
				begin
					 ret_reg24[22] <= ad_din;
				end
				else if((8'd141 < config_cnt )&(config_cnt <8'd164)&(ad_clk_in_falling))
				begin
					 ret_reg24[8'd163-config_cnt] <= ad_din;
				end
				else if((config_cnt == 8'd163)&(ad_clk_in_rising))
				begin
					ad_clk_vld <= 1'b1;
				end
				
				
				//writing 1 byte begin
				else if(config_cnt == 8'd171) 
					cfg_reg8 <= 8'h5C;
				else if((config_cnt == 8'd180)&(ad_clk_in_falling))
				begin
					ad_clk_vld <= 1'b0;
					ad_cfg <= cfg_reg8[7];
				end
				else if((config_cnt >8'd180)&(config_cnt < 8'd187)&(ad_clk_in_falling))
				begin
					ad_cfg <= cfg_reg8[8'd187-config_cnt];
				end
				else if((config_cnt == 8'd187)&(ad_clk_in_rising))
				begin
				   ad_clk_vld <= 1'b1;
				   ad_cfg <= cfg_reg8[0];
				end
				else if((config_cnt == 8'd188)&(ad_clk_in_rising))
				begin  
						ad_cfg <= 1'b0;
				end
				    //writing 1 byte end
					 
					 
			end
			S_AD_SAMPLE : 
				begin
						// reading 3 bytes begin	
					if((sample_cnt == 8'd210)&(ad_clk_in_falling))
					begin
							ad_clk_vld <= 1'b0;
					end
					else if((sample_cnt == 8'd210)&(ad_clk_in_rising))
						 got_ad_value[23] <= ad_din;
					else if((sample_cnt == 8'd211)&(ad_clk_in_falling))
					begin
						 got_ad_value[22] <= ad_din;
					end
					else if((8'd211 < sample_cnt )&(sample_cnt <8'd234)&(ad_clk_in_falling))
					begin
						 got_ad_value[8'd233-sample_cnt] <= ad_din;
					end
					else if((sample_cnt == 8'd233)&(ad_clk_in_rising))
					begin
						ad_clk_vld <= 1'b1;
					end
				end
			
			S_DATA_PUSH : ad_cfg = 1'b0;
			S_DONE :  ad_cfg = 1'b0;
			default : ad_cfg = 1'b1;
		endcase
	end
end







wire ad_clk;

assign ad_clk = ad_clk_in | ad_clk_vld; //enable ad_clk 
assign ad_vld = clk_2kHz_falling;
assign ad_data = ret_reg24 + got_ad_value;
assign ad_sync = 1'b1;



endmodule


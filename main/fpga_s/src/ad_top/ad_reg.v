//ad_reg.v

module ad_reg(
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
//configuration
cfg_sample,
cfg_ad_tp,
cfg_ad_fix,
cfg_tp_base,
cfg_tp_step,
//clk rst
mod_id,
clk_sys,
rst_n
);
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
//configuration
output [7:0]	cfg_sample;
output [7:0]	cfg_ad_tp;
output [23:0] cfg_ad_fix;
output [23:0]	cfg_tp_base;
output [7:0]	cfg_tp_step;
//clk rst
input [5:0] mod_id;
input clk_sys;
input rst_n;

//-----------------------------------------
//-----------------------------------------

wire dev_wsel = (fx_waddr[13:8]== mod_id) ? 1'b1 :1'b0;
wire dev_rsel = (fx_raddr[13:8]== mod_id) ? 1'b1 :1'b0;

wire now_wr = fx_wr & dev_wsel;
wire now_rd = fx_rd & dev_rsel;


//--------- register --------
reg [7:0]	cfg_sample;
reg [7:0]	cfg_ad_tp;
reg [23:0] cfg_ad_fix;
reg [23:0]cfg_tp_base;
reg [7:0]	cfg_tp_step;
reg [7:0] cfg_dbg0;
reg [7:0] cfg_dbg1;
reg [7:0] cfg_dbg2;
reg [7:0] cfg_dbg3;
reg [7:0] cfg_dbg4;
reg [7:0] cfg_dbg5;
reg [7:0] cfg_dbg6;
reg [7:0] cfg_dbg7;



//--------- write register ----------
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)	begin
		cfg_sample <= 8'd20;
		cfg_ad_tp <= 8'd0;
		cfg_ad_fix <= 24'h0;
		cfg_tp_base <= 24'h0;
		cfg_tp_step <= 8'h1;
		cfg_dbg0 <= 8'h80;
		cfg_dbg1 <= 8'h81;
		cfg_dbg2 <= 8'h82;
		cfg_dbg3 <= 8'h83;
		cfg_dbg4 <= 8'h84;
		cfg_dbg5 <= 8'h85;
		cfg_dbg6 <= 8'h86;
		cfg_dbg7 <= 8'h87;
	end
	else if(now_wr) begin
		case(fx_waddr[7:0])
			8'h20 : cfg_sample <= fx_data;
			8'h40	:	cfg_ad_tp <= fx_data;
			8'h41 : cfg_ad_fix[7:0] <= fx_data;
			8'h42 : cfg_ad_fix[15:8] <= fx_data;
			8'h43 : cfg_ad_fix[23:16] <= fx_data;
			8'h44	:	cfg_tp_base[7:0] <= fx_data;
			8'h45	:	cfg_tp_base[15:8] <= fx_data;
			8'h46	:	cfg_tp_base[23:16] <= fx_data;
			8'h47	:	cfg_tp_step <= fx_data;
			8'h80 : cfg_dbg0 <= fx_data;
			8'h81 : cfg_dbg1 <= fx_data;
			8'h82 : cfg_dbg2 <= fx_data;
			8'h83 : cfg_dbg3 <= fx_data;
			8'h84 : cfg_dbg4 <= fx_data;
			8'h85 : cfg_dbg5 <= fx_data;
			8'h86 : cfg_dbg6 <= fx_data;
			8'h87 : cfg_dbg7 <= fx_data;
			default : ;
		endcase
	end
	else ;
end
			

//---------- read register ---------
reg [7:0] q0;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n) begin
		q0 <= 8'h0;
	end
	else if(now_rd) begin
		case(fx_raddr[7:0])
			8'h0  : q0 <= mod_id;
			8'h20 : q0 <= cfg_sample;
			8'h40 : q0 <= cfg_ad_tp;
			8'h41 : q0 <= cfg_ad_fix[7:0];
			8'h42 : q0 <= cfg_ad_fix[15:8];
			8'h43 : q0 <= cfg_ad_fix[23:16];
			8'h44 : q0 <= cfg_tp_base[7:0];
			8'h45 : q0 <= cfg_tp_base[15:8];
			8'h46 : q0 <= cfg_tp_base[23:16];
			8'h47 : q0 <= cfg_tp_step;
			8'h80 : q0 <= cfg_dbg0;
			8'h81 : q0 <= cfg_dbg1;
			8'h82 : q0 <= cfg_dbg2;
			8'h83 : q0 <= cfg_dbg3;
			8'h84 : q0 <= cfg_dbg4;
			8'h85 : q0 <= cfg_dbg5;
			8'h86 : q0 <= cfg_dbg6;
			8'h87 : q0 <= cfg_dbg7;
			
			default : q0 <= 8'h0;
		endcase
	end
	else 
		q0 <= 8'h0;
end

wire [7:0] fx_q;
assign fx_q = q0;
	
	
endmodule

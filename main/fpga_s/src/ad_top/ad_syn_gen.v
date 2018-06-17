//ad_syn_gen.v

module ad_syn_gen(
ad_sync_1sn,
//clk rst
syn_vld,
clk_sys,
rst_n
);
output ad_sync_1sn;
//clk rst
input syn_vld;
input clk_sys;
input rst_n;
//--------------------------------------------
//--------------------------------------------

parameter S_IDLE = 2'h0;
parameter S_SYN  = 2'h1;
parameter S_DONE = 2'h3;
reg [1:0] st_ad_syn;
wire finish_syn;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_ad_syn <= S_IDLE;
	else begin
		case(st_ad_syn)
			S_IDLE : st_ad_syn <= syn_vld ? S_SYN : S_IDLE;
			S_SYN  : st_ad_syn <= finish_syn ? S_DONE : S_SYN;
			S_DONE : st_ad_syn <= S_IDLE;
			default : st_ad_syn <= S_IDLE;
		endcase
	end
end

reg [19:0] cnt_syn;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_syn <= 20'h0;
	else if(st_ad_syn == S_SYN)
		cnt_syn <= cnt_syn + 20'h1;
	else 
		cnt_syn <= 20'h0;
end
assign finish_syn = (cnt_syn == 20'd100_00) ? 1'b1 : 1'b0;


//------------ output -------
wire ad_sync_1sn;
assign ad_sync_1sn = (st_ad_syn == S_SYN) ? 1'b0 : 1'b1;



endmodule

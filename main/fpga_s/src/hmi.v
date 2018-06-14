//hmi.v

module hmi(
led0_n,
led1_n,
led2_n,
syn_vld,
pk_frm,
rx_a,
re_a,
//clk rst
clk_sys,
rst_n
);
output led0_n;
output led1_n;
output led2_n;
input pk_frm;
input rx_a;
input re_a;
input syn_vld;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------


//----------- led0_n --------------
reg [27:0] cnt_syn;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_syn <= 28'h0;
	else if(syn_vld)
		cnt_syn <= 28'd300_000_00;
	else if(cnt_syn != 28'h0)
		cnt_syn <= cnt_syn - 28'h1;
	else ;
end
wire led0_n = (cnt_syn != 28'h0) ? 1'b0 : 1'b1;


//----------- led1_n --------------
reg pk_frm_reg;
always @ (posedge clk_sys)	pk_frm_reg <= pk_frm;
wire pk_frm_rasing = (~pk_frm_reg) & pk_frm;
reg [27:0] cnt_pkg;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_pkg <= 28'h0;
	else if(pk_frm_rasing)
		cnt_pkg <= 28'd300_000_00;
	else if(cnt_pkg != 28'h0)
		cnt_pkg <= cnt_pkg - 28'h1;
	else ;
end
wire led1_n = (cnt_pkg != 28'h0) ? 1'b0 : 1'b1;


//----------- led2_n --------------
reg [7:0]	rx_a_reg;
always @ (posedge clk_sys)	rx_a_reg <= {rx_a_reg[6:0],rx_a};
wire rx_a_falling = (rx_a_reg[7]) & (~rx_a_reg[6]);
reg [27:0] cnt_rxa;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_rxa <= 28'h0;
	else if(re_a)
		cnt_rxa <= 28'h0;
	else if(rx_a_falling)
		cnt_rxa <= 28'd300_000_00;
	else if(cnt_rxa != 28'h0)
		cnt_rxa <= cnt_rxa - 28'h1;
	else ;
end
wire led2_n = (cnt_rxa != 28'h0) ? 1'b0 : 1'b1;



endmodule


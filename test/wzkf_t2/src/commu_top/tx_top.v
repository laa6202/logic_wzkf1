//tx_top.v

module tx_top(
tx,
//configuration
tbit_period,
tx_total,
now_send,
//clk rst
clk_sys,
rst_n
);
output tx;
//configuration
input [19:0]	tbit_period;
input [31:0]	tx_total;
output				now_send;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------

wire fire_tx;
wire done_tx;
wire [7:0] data_tx;
tx_ctrl u_tx_mac(
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
//configuration
.tx_total(tx_total),
.now_send(now_send),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


tx_inf u_tx_phy(
.tx(tx),
//control 
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
.tbit_period(tbit_period),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



/*
reg [31:0] cnt_tx;
wire tbit_vld;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_tx <= 32'h0;
	else if(tbit_vld)
		cnt_tx <= cnt_tx + 32'h1;
	else ;
end
										
reg [19:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 20'h0;
	else if(cnt_cycle == tbit_period)
		cnt_cycle <= 20'h1;
	else if(cnt_tx < tx_total)
		cnt_cycle <= cnt_cycle + 20'h1;
	else ;
end

assign tbit_vld =  (cnt_cycle == tbit_period) ? 1'b1 : 1'b0;

reg tx;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		tx <= 1'b1;
	else if(tbit_vld)
		tx <= ~tx;
	else ;
end
wire now_send = (cnt_tx < tx_total) ? 1'b1 : 1'b0;
*/

endmodule


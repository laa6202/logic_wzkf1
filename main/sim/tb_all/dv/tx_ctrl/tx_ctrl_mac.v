//tx_ctrl.v
`define T_INIT 20'd100

module tx_ctrl_mac(
fire_tx,
done_tx,
data_tx,
//configuration
tx_total,
dev_id,
mod_id,
cmd_addr,
cmd_data,
//clk rst
clk_sys,
rst_n
);
output fire_tx;
input  done_tx;
output [7:0]	data_tx;
//configuration
input [31:0]	tx_total;
input [7:0]	dev_id;
input [7:0]	mod_id;
input	[7:0]	cmd_addr;
input	[7:0]	cmd_data;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------
//--------------------------------


//----------- main FSM ----------
parameter S_INIT = 3'h0;
parameter S_FIRE = 3'h1;
parameter S_WAIT = 3'h2;
parameter S_CHECK = 3'h3;
parameter S_DONE = 3'h7;
reg [2:0] st_tx_mac;
wire finish_init;
wire finish_send;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_tx_mac <= S_INIT;
	else begin
		case(st_tx_mac)
			S_INIT : st_tx_mac <= finish_init ? S_FIRE : S_INIT;
			S_FIRE : st_tx_mac <= S_WAIT;
			S_WAIT : st_tx_mac <= done_tx ? S_CHECK : S_WAIT;
			S_CHECK: st_tx_mac <= finish_send ? S_DONE : S_FIRE;
			S_DONE : ;
			default : st_tx_mac <= S_INIT;
		endcase
	end
end


//------- FSM init -----------
reg [19:0] cnt_init;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_init <= 20'h0;
	else if(st_tx_mac == S_INIT)
		cnt_init <= cnt_init + 20'h1;
	else 
		cnt_init <= 20'h0;
end
assign finish_init = (cnt_init == `T_INIT) ? 1'b1 : 1'b0;
		

//-------- FSM check ---------
reg [31:0] cnt_tx;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_tx <= 32'h0;
	else if(st_tx_mac == S_FIRE)
		cnt_tx <= cnt_tx + 32'h1;
	else ;
end
assign finish_send = (tx_total == cnt_tx) ? 1'b1 : 1'b0;


//-------- output -------------
wire fire_tx = (st_tx_mac == S_FIRE) ? 1'b1 : 1'b0;
wire [7:0] data;
assign data = (cnt_tx == 8'h0) ? dev_id :
							(cnt_tx == 8'h1) ? mod_id :
							(cnt_tx == 8'h2) ? cmd_addr :
							(cnt_tx == 8'h3) ? cmd_data : 8'h55;

wire [7:0]	data_tx;
assign data_tx =  data ;


endmodule

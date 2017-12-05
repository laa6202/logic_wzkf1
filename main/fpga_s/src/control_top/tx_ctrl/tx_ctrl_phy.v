//tx_inf.v

module tx_ctrl_phy(
tx,
//control 
fire_tx,
done_tx,
data_tx,
tbit_period,
//clk rst
clk_sys,
rst_n
);

output tx;
//control 
input fire_tx;
output done_tx;
input [7:0]		data_tx;
input [19:0]	tbit_period;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------
//--------------------------------


reg [7:0] data;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		data <= 8'h0;
	else if(fire_tx)
		data <= data_tx;
	else ;
end

//---------- main FSM -----------
parameter S_IDLE = 4'h0;
parameter S_START = 4'h1;
parameter S_S7 = 4'h2;
parameter S_S6 = 4'h3;
parameter S_S5 = 4'h4;
parameter S_S4 = 4'h5;
parameter S_S3 = 4'h6;
parameter S_S2 = 4'h7;
parameter S_S1 = 4'h8;
parameter S_S0 = 4'h9;
parameter S_STOP = 4'ha;
parameter S_STOP2 = 4'hb;
parameter S_DONE = 4'hf;
reg [3:0] st_tx_phy;
wire finish_bit;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_tx_phy <= S_IDLE ;
	else begin
		case(st_tx_phy)
			S_IDLE : st_tx_phy <= fire_tx ? S_START : S_IDLE;
			S_START: st_tx_phy <= finish_bit ? S_S7 : S_START;
			S_S7   : st_tx_phy <= finish_bit ? S_S6 : S_S7;
			S_S6   : st_tx_phy <= finish_bit ? S_S5 : S_S6;
			S_S5   : st_tx_phy <= finish_bit ? S_S4 : S_S5;
			S_S4   : st_tx_phy <= finish_bit ? S_S3 : S_S4;
			S_S3   : st_tx_phy <= finish_bit ? S_S2 : S_S3;
			S_S2   : st_tx_phy <= finish_bit ? S_S1 : S_S2;
			S_S1   : st_tx_phy <= finish_bit ? S_S0 : S_S1;
			S_S0   : st_tx_phy <= finish_bit ? S_STOP : S_S0;
			S_STOP : st_tx_phy <= finish_bit ? S_STOP2 : S_STOP;
			S_STOP2: st_tx_phy <= finish_bit ? S_DONE : S_STOP2;
			S_DONE : st_tx_phy <= S_IDLE;
			default : st_tx_phy <= S_IDLE;
		endcase
	end
end
wire send_bit = (st_tx_phy != S_IDLE) & (st_tx_phy != S_DONE);

//--------- FSM finish_bit ----------
reg [19:0] cnt_cycle;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 20'h0;
	else if(cnt_cycle == (tbit_period - 20'h1))
		cnt_cycle <= 20'h0;
	else if(send_bit)
		cnt_cycle <= cnt_cycle + 20'h1;
	else 
		cnt_cycle <= 20'h0;
end
assign finish_bit = (cnt_cycle == (tbit_period - 20'h1)) ? 1'b1 : 1'b0;


//----------- output -------
wire done_tx;
assign done_tx = (st_tx_phy == S_DONE) ? 1'b1 : 1'b0;
wire tx;
assign tx = (st_tx_phy == S_S7) ? data[7] : 
						(st_tx_phy == S_S6) ? data[6] : 
						(st_tx_phy == S_S5) ? data[5] : 
						(st_tx_phy == S_S4) ? data[4] : 
						(st_tx_phy == S_S3) ? data[3] : 
						(st_tx_phy == S_S2) ? data[2] : 
						(st_tx_phy == S_S1) ? data[1] :
						(st_tx_phy == S_S0) ? data[0] :	
						(st_tx_phy == S_START ) ? 1'b0 : 1'b1;
			
endmodule

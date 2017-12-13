//syn_m_info.v

module syn_m_info(
tx_info,
fire_sync,
fire_info,
//clk rst
clk_sys,
rst_n
);

output	tx_info;
input		fire_sync;
input 	fire_info;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------


//----------- utc secord register --------
reg [31:0]	utc_sec;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		utc_sec <= 32'h0;
	//else if()			//update from gps_setting
	else if(fire_sync)
		utc_sec <= utc_sec + 32'h1;
	else ;
end






//----------- main FSM -----------
parameter S_IDLE = 4'h0;
parameter S_FS1 = 4'h1;
parameter S_WS1 = 4'h2;
parameter S_FS2 = 4'h3;
parameter S_WS2 = 4'h4;
parameter S_FS3 = 4'h5;
parameter S_WS3 = 4'h6;
parameter S_FS4 = 4'h7;
parameter S_WS4 = 4'h8;
parameter S_DONE = 4'hf;
reg [3:0] st_tx_info;
wire done_tx;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_tx_info <= S_IDLE;
	else begin
		case(st_tx_info)
			S_IDLE : st_tx_info <= fire_info ? S_FS1 : S_IDLE;
			S_FS1 : st_tx_info <= S_WS1;
			S_WS1 : st_tx_info <= done_tx ? S_FS2 : S_WS1;
			S_FS2 : st_tx_info <= S_WS2;
			S_WS2 : st_tx_info <= done_tx ? S_FS3 : S_WS2;
			S_FS3 : st_tx_info <= S_WS3;
			S_WS3 : st_tx_info <= done_tx ? S_FS4 : S_WS3;
			S_FS4 : st_tx_info <= S_WS4;
			S_WS4 : st_tx_info <= done_tx ? S_DONE : S_WS4;
			S_DONE : st_tx_info <= S_IDLE;
			default : st_tx_info <= S_IDLE;
		endcase
	end
end


//---------- enc and phy ----------
wire fire_tx = 	(st_tx_info == S_FS1) | (st_tx_info == S_FS2) |
								(st_tx_info == S_FS3) | (st_tx_info == S_FS4) ;
wire [7:0]	data_tx;
assign data_tx = 	(st_tx_info == S_FS1) ? utc_sec[31:24] :
									(st_tx_info == S_FS2) ? utc_sec[23:16] :
									(st_tx_info == S_FS3) ? utc_sec[15:8] :
									(st_tx_info == S_FS4) ? utc_sec[7:0] : 8'h0;
									
tx_info_phy u_tx_syn_phy(
.tx(tx_info),
//control 
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
`ifdef SIM	
.tbit_period(20'd10),		//10M
`else
.tbit_period(20'd1000),	//100K
`endif
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

endmodule


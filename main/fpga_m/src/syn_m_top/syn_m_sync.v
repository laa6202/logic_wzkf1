//syn_m_sync.v

module syn_m_sync(
tx_sync,
fire_sync,
//clk rst
clk_sys,
rst_n
);

output	tx_sync;
input		fire_sync;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------


reg [19:0]	 cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 20'h0;
`ifdef SIM
	else if(cnt_cycle == 20'd200)		//1M = 2us
`else 
	else if(cnt_cycle == 20'd1_000_00)	//1K = 1ms
`endif
		cnt_cycle <= 20'h0;
	else if(fire_sync)
		cnt_cycle <= 20'd1;
	else if(cnt_cycle != 20'd0)
		cnt_cycle <= cnt_cycle + 20'h1;
	else ;
end

reg tx_sync;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		tx_sync <= 1'b1;
	else if(cnt_cycle != 20'd0)
		tx_sync <= 1'b0;
	else 
		tx_sync <= 1'b1;
end


endmodule


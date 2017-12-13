//syn_m_main.v

module syn_m_main(
fire_sync,
fire_info,
//gps info
gps_pluse,
//clk rst
clk_sys,
pluse_us,
rst_n
);
output	fire_sync;
output	fire_info;
//gps info
input		gps_pluse;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//-------------------------------------------
//-------------------------------------------

//--------- pre handle of gps_pluse
reg [7:0] gps_pluse_reg;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		gps_pluse_reg <= 8'h0;
	else 
		gps_pluse_reg <= {gps_pluse_reg[6:0],gps_pluse};
end
`ifdef SIM
wire gps_pluse_true = gps_pluse;
`else 
reg gps_pluse_true;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		gps_pluse_true <= 1'b0;
	else if(gps_pluse_reg == 8'hff)
		gps_pluse_true <= 1'b1;
	else if(gps_pluse_reg == 8'h0)
		gps_pluse_true <= 1'b0;
	else ;
end
`endif
reg gps_pluse_true_reg;
always @ (posedge clk_sys)
	gps_pluse_true_reg <= gps_pluse_true;
wire gps_pluse_true_rasing = (~gps_pluse_true_reg) & gps_pluse_true;



//-------------- main couter ------------
reg [21:0] cnt_us;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_us <= 22'h0;
	else if(gps_pluse_true_rasing)
		cnt_us <= 22'h0;
	else if(pluse_us) begin
`ifdef SIM
		if(cnt_us == 22'd119)
			cnt_us <= 22'd020;
		else 
			cnt_us <= cnt_us + 22'd1;
`else 
		if(cnt_us == 22'd1_199_999)
			cnt_us <= 22'd0_200_000;
		else 
			cnt_us <= cnt_us + 22'd1;
`endif
	end
	else ;
end
	
	
//--------- output -----------
wire fire_sync;
`ifdef SIM
assign fire_sync = pluse_us & (cnt_us == 22'd0_20);
`else 
assign fire_sync = pluse_us & (cnt_us == 22'd0_200_000);
`endif

wire fire_info;
`ifdef SIM
assign fire_info = pluse_us & (cnt_us == 22'd0_80);
`else 
assign fire_info = pluse_us & (cnt_us == 22'd0_800_000);
`endif

endmodule

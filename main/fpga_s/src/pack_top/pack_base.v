//pack_base.v

module pack_base(
len_load,
pk_frm,
cfg_sample,
//clk rst
clk_sys,
rst_n
);
output [11:0]	len_load;
input					pk_frm;
input [7:0]		cfg_sample;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------

reg [11:0] len_load;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		len_load <= 12'h0;
	else if(~pk_frm) begin
`ifdef SIM
		len_load <= (cfg_sample == 8'd20) ? 12'd20 :
								(cfg_sample == 8'd10) ? 12'd10 :
								(cfg_sample == 8'd5) ? 12'd5 :
								(cfg_sample == 8'd2) ? 12'd2 :
								(cfg_sample == 8'd1) ? 12'd1 : 12'd20;
`else 
		len_load <= (cfg_sample == 8'd20) ? 12'd2000 :
								(cfg_sample == 8'd10) ? 12'd1000 :
								(cfg_sample == 8'd5) ? 12'd500 :
								(cfg_sample == 8'd2) ? 12'd200 :
								(cfg_sample == 8'd1) ? 12'd100 : 12'd2000;
`endif
	end
	else ;
end


endmodule

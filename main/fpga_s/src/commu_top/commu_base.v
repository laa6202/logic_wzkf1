//commu_base.v

module commu_base(
len_pkg,
//configuration
cfg_sample,
//clk rst
clk_sys,
rst_n
);
output [15:0]	len_pkg;
//configuration
input [7:0]	cfg_sample;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------


//-------------- len_pkg -------------
reg [15:0] len_load;
always @ (posedge clk_sys)	begin
`ifdef SIM
	len_load <=	(cfg_sample == 8'd20) ? 16'd180 :
							(cfg_sample == 8'd10) ? 16'd90 :
							(cfg_sample == 8'd5) ? 16'd45 :
							(cfg_sample == 8'd2) ? 16'd18 :
							(cfg_sample == 8'd1) ? 16'd9 : 16'd180;
`else 
	len_load <=	(cfg_sample == 8'd20) ? 16'd18000 :
							(cfg_sample == 8'd10) ? 16'd9000 :
							(cfg_sample == 8'd5) ? 16'd4500 :
							(cfg_sample == 8'd2) ? 16'd1800 :
							(cfg_sample == 8'd1) ? 16'd900 : 16'd18000;
`endif
end
wire [15:0] len_head = 16'd12;
wire [15:0] len_tail = 16'd0;
wire [15:0] len_crc  = 16'h1;
reg [15:0] len_pkg;
always @ (posedge clk_sys)	begin
	len_pkg <= len_head + len_load + len_tail + len_crc;
end




endmodule


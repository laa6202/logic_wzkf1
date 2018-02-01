//commu_base.v

module commu_base(
len_pkg,
mode_numDev,
tbit_frq,
tbit_period,
//configuration
cfg_numDev,
cfg_sample,
//clk rst
clk_sys,
rst_n
);
output [15:0]	len_pkg;
output [1:0]  mode_numDev;
output [15:0]	tbit_frq;
output [19:0]	tbit_period;
//configuration
input [7:0] cfg_numDev;
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
wire [15:0] len_tail = 16'd48;
wire [15:0] len_crc  = 16'h2;
reg [15:0] len_pkg;
always @ (posedge clk_sys)	begin
	len_pkg <= len_head + len_load + len_tail + len_crc;
end


//-------------- mode_numDev -------------
reg  [1:0] mode_numDev;
always @ (posedge clk_sys)	begin
	mode_numDev <= 	(cfg_numDev >= 8'd16) ? 2'h3 :
									(cfg_numDev >= 8'd8) ? 2'h1 : 2'h0;
end

//-------------- tbit_frq -------------
reg [15:0] tbit_frq;
always @ (posedge clk_sys)	begin
	if(mode_numDev == 2'h3)	begin
		tbit_frq <=	(cfg_sample == 8'd20) ? 16'd5000 :
								(cfg_sample == 8'd10) ? 16'd4000 :
								(cfg_sample == 8'd5) ? 16'd2000 :
								(cfg_sample == 8'd2) ? 16'd1000 :
								(cfg_sample == 8'd1) ? 16'd500 : 16'd5000;
	end
	else	if(mode_numDev == 2'h1)	begin
		tbit_frq <=	(cfg_sample == 8'd20) ? 16'd4000 :
								(cfg_sample == 8'd10) ? 16'd2000 :
								(cfg_sample == 8'd5) ? 16'd1000 :
								(cfg_sample == 8'd2) ? 16'd500 :
								(cfg_sample == 8'd1) ? 16'd200 : 16'd4000;
	end
	else begin
		tbit_frq <=	(cfg_sample == 8'd20) ? 16'd2000 :
								(cfg_sample == 8'd10) ? 16'd1000 :
								(cfg_sample == 8'd5) ? 16'd500 :
								(cfg_sample == 8'd2) ? 16'd200 :
								(cfg_sample == 8'd1) ? 16'd200 : 16'd2000;	
	end
end


//----------- tbit_period ------------
wire [19:0] tbit_period;
assign tbit_period =(tbit_frq == 16'd5000) ? 20'd20 :
										(tbit_frq == 16'd4000) ? 20'd25 :
										(tbit_frq == 16'd2000) ? 20'd50 :
										(tbit_frq == 16'd1000) ? 20'd1_00 :
										(tbit_frq == 16'd500) ? 20'd2_00 :
										(tbit_frq == 16'd200) ? 20'd5_00 :
										(tbit_frq == 16'd100) ? 20'd10_00 : 20'd20;
									

endmodule


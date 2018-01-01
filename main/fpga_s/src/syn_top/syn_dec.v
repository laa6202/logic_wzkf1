//syn_dec.v

module syn_dec(
rx_data,
rx_vld,
syn_vld,
utc_sec,
now_ns,
stu_err_syn,
//clk rst
clk_sys,
rst_n
);
input	[7:0]	rx_data;
input				rx_vld;
input 			syn_vld;
output [31:0]	utc_sec;
output [31:0]	now_ns;
output [7:0]	stu_err_syn;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------------
//-----------------------------------------------


reg [2:0] cnt_times;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_times <= 3'h0;
	else if(rx_vld)
		cnt_times <= syn_vld ? 3'h0 : (cnt_times + 3'h1);
	else ;
end


reg [31:0] cnt_ns;
always @ (posedge clk_sys or negedge rst_n)	begin	
	if(~rst_n)
		cnt_ns <= 32'h0;
	else if(syn_vld)
		cnt_ns <= 32'h0;
	else 
		cnt_ns <= cnt_ns + 32'd10;
end

reg [31:0] utc_org;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		utc_org <= 32'h0;
	else if(rx_vld) begin
		case(cnt_times)
			3'h0: utc_org[31:24] <= rx_data;
			3'h1: utc_org[23:16] <= rx_data;
			3'h2: utc_org[15:8]	 <= rx_data;
			3'h3: utc_org[7:0]	 <= rx_data;
			default : ;
		endcase
	end
	else ;
end


//-------------- output syn data --------
wire [31:0]	now_ns;
assign	now_ns = cnt_ns;
reg [31:0]	utc_sec;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		utc_sec <= 32'h0;
	else if(syn_vld)
		utc_sec <= utc_org;
	else ;
end


//------------- stu error -----------
reg [6:0] cnt_err_syn;
wire trig_err_syn;
`ifdef SIM
assign trig_err_syn = (cnt_ns == 32'd100_00) ? 1'b1 : 1'b0;
`else 
assign trig_err_syn = (cnt_ns == 32'd2000_000_00) ? 1'b1 : 1'b0;
`endif
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_err_syn <= 7'h0;
	else if(trig_err_syn) begin
		if(cnt_err_syn != 7'h7f)
			cnt_err_syn <= cnt_err_syn + 7'h1;
		else ;
	end
	else ;
end
wire [7:0] stu_err_syn;
assign stu_err_syn = {|cnt_err_syn,cnt_err_syn};


endmodule


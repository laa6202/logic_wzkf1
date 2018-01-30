//cspi_codec.v

module cspi_codec(
//all cmd path
cmd_dev,
cmd_mod,
cmd_addr,
cmd_data,
cmd_vld,
cmd_q,
cmd_qvld,
//internal control path
ctrl_data,
ctrl_dvld,
ctrl_q,
ctrl_qvld,
//clk rst
clk_sys,
rst_n
);
//all cmd path
output [7:0]	cmd_dev;
output [7:0]	cmd_mod;
output [7:0]	cmd_addr;
output [7:0]	cmd_data;
output				cmd_vld;
input  [7:0]	cmd_q;
input 				cmd_qvld;
//internal control path
input [7:0]	ctrl_data;
input				ctrl_dvld;
output  [7:0]	ctrl_q;
output				ctrl_qvld;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------



//---------- main FSM ----------
parameter S_IDLE = 3'h0;
parameter S_SET1 = 3'h1;
parameter S_SET2 = 3'h2;
parameter S_SET3 = 3'h3;
parameter S_DECODE = 3'h4;
parameter S_SCMD = 3'h5;
parameter S_LAST = 3'h6;
parameter S_DONE = 3'h7;
reg [2:0] st_cspi_codec;
wire to_codec;
always @ (posedge clk_sys or negedge rst_n) begin
	if(~rst_n)
		st_cspi_codec <= S_IDLE;
	else begin
		case(st_cspi_codec)
			S_IDLE : st_cspi_codec <= ctrl_dvld ? S_SET1 : S_IDLE;
			S_SET1 : st_cspi_codec <= to_codec ? S_IDLE:
																ctrl_dvld ? S_SET2 : S_SET1;
			S_SET2 : st_cspi_codec <= to_codec ? S_IDLE:
																ctrl_dvld ? S_SET3 : S_SET2;
			S_SET3 : st_cspi_codec <= to_codec ? S_IDLE:
																ctrl_dvld ? S_DECODE : S_SET3;
			S_DECODE : st_cspi_codec <= S_SCMD;
			S_SCMD : st_cspi_codec <= cmd_qvld ? S_LAST : S_SCMD;
			S_LAST : st_cspi_codec <= to_codec ? S_IDLE:
																ctrl_dvld ? S_DONE : S_LAST;
			S_DONE : st_cspi_codec <= S_IDLE;
			default :st_cspi_codec <= S_IDLE;
		endcase
	end
end


//---------- condiftion to_codec ---------

reg [2:0] st_cspi_codec_reg;
always @(posedge clk_sys)
	st_cspi_codec_reg <= st_cspi_codec;
wire st_keep = (st_cspi_codec_reg == st_cspi_codec) & (st_cspi_codec != S_IDLE);

reg [19:0] cnt_wd;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_wd <= 20'h0;
	else if(st_keep)
		cnt_wd <= cnt_wd + 20'h1;
	else 
		cnt_wd <= 20'h0;
end
assign to_codec = (cnt_wd == 20'd10_000_00) ? 1'b1 : 1'b0;


//-------- cmd decode ---------
reg [7:0] dev;
reg [7:0] mod;
reg [7:0] addr;
reg [7:0] data;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		dev <= 8'h0;
	else if(ctrl_dvld & (st_cspi_codec == S_IDLE))
		dev <= ctrl_data;
	else ;
end
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		mod <= 8'h0;
	else if(ctrl_dvld & (st_cspi_codec == S_SET1))
		mod <= ctrl_data;
	else ;
end
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		addr <= 8'h0;
	else if(ctrl_dvld & (st_cspi_codec == S_SET2))
		addr <= ctrl_data;
	else ;
end
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		data <= 8'h0;
	else if(ctrl_dvld & (st_cspi_codec == S_SET3))
		data <= ctrl_data;
	else ;
end
reg [7:0]	cmd_dev;
reg [7:0]	cmd_mod;
reg [7:0]	cmd_addr;
reg [7:0]	cmd_data;
reg				cmd_vld;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)	begin
		cmd_dev <= 8'h0;
		cmd_mod <= 8'h0;
		cmd_addr <= 8'h0;
		cmd_data <= 8'h0;
		cmd_vld <= 1'b0;
	end
	else if(st_cspi_codec == S_DECODE)	begin
		cmd_dev <= dev;
		cmd_mod <= mod;
		cmd_addr <= addr;
		cmd_data <= data;
		cmd_vld <= 1'b1;
	end
	else 
		cmd_vld <= 1'b0;
end


//--------- ctrl_q ------------
wire [7:0]	ctrl_q;
wire 				ctrl_qvld;
assign ctrl_qvld = (st_cspi_codec == S_SCMD) ? cmd_qvld : 1'b0;
assign ctrl_q = cmd_q;


endmodule

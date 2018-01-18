//fx_bc_m.v

module fx_bc_m(
cmdl_mod,
cmdl_addr,
cmdl_data,
cmdl_vld,
cmdl_q,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
//clk rst
clk_sys,
rst_n
);
input [7:0] cmdl_mod;
input [7:0] cmdl_addr;
input [7:0] cmdl_data;
input 			cmdl_vld;
output[7:0]	cmdl_q;
//fx bus
output [15:0]	fx_waddr;
output 				fx_wr;
output [7:0]	fx_data;
output				fx_rd;
output [15:0]	fx_raddr;
input  [7:0]	fx_q;
//clk rst
input clk_sys;
input rst_n;

//--------------------------------------
//--------------------------------------


wire en_wr = (cmdl_mod[7:6] == 2'b10) ? 1'b1 : 1'b0;
wire en_rd = (cmdl_mod[7:6] == 2'b00) ? 1'b1 : 1'b0;
wire [5:0] mod_id = cmdl_mod[5:0];
wire [15:0] waddr = en_wr ? {2'h0,mod_id,cmdl_addr} : 16'h0;
wire [15:0] raddr = en_rd ? {2'h0,mod_id,cmdl_addr} : 16'h0;
wire [7:0]	data = en_wr ? cmdl_data : 8'h0;

reg [15:0]	fx_waddr;
reg 				fx_wr;
reg [7:0]		fx_data;
reg					fx_rd;
reg [15:0]	fx_raddr;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)	begin
		fx_waddr <= 16'h0;
		fx_wr <= 1'b0;
		fx_data <= 8'h0;
		fx_rd <= 1'b0;
		fx_raddr <= 16'h0;
	end
	else  begin
		fx_wr <= cmdl_vld ? en_wr : 1'b0;
		fx_rd <= cmdl_vld ? en_rd : 1'b0;
		fx_waddr <= cmdl_vld ? waddr : 16'h0;
		fx_raddr <= cmdl_vld ? raddr : 16'h0;
		fx_data <= cmdl_vld ? data : 8'h0;
	end
end

endmodule

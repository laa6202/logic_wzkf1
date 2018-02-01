//cmd_factoty.v

module cmd_factory(
//all cmd path
cmd_dev,
cmd_mod,
cmd_addr,
cmd_data,
cmd_vld,
cmd_q,
cmd_qvld,
//cmd remote path
cmdr_dev,
cmdr_mod,
cmdr_addr,
cmdr_data,
cmdr_vld,
//cmd local path
cmdl_mod,
cmdl_addr,
cmdl_data,
cmdl_vld,
cmdl_q,
cmdl_qvld,
//clk rst
clk_sys,
rst_n
);
//all cmd path
input [7:0]	cmd_dev;
input [7:0]	cmd_mod;
input [7:0]	cmd_addr;
input [7:0]	cmd_data;
input				cmd_vld;
output[7:0]	cmd_q;
output			cmd_qvld;
//cmd remote path
output [7:0]	cmdr_dev;
output [7:0]	cmdr_mod;
output [7:0]	cmdr_addr;
output [7:0]	cmdr_data;
output				cmdr_vld;
//cmd local path
output [7:0]	cmdl_mod;
output [7:0]	cmdl_addr;
output [7:0]	cmdl_data;
output				cmdl_vld;
input  [7:0]	cmdl_q;
input   			cmdl_qvld;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------

wire hit_l = (cmd_dev == 8'h00) & cmd_vld;
wire hit_r = (cmd_dev != 8'h00) & cmd_vld;

//--------- remote path ---------
wire [7:0]	cmdr_dev;
wire [7:0]	cmdr_mod;
wire [7:0]	cmdr_addr;
wire [7:0]	cmdr_data;
wire				cmdr_vld;
assign cmdr_dev = hit_r ? cmd_dev : 8'h0;
assign cmdr_mod = hit_r ? cmd_mod : 8'h0;
assign cmdr_addr = hit_r ? cmd_addr : 8'h0;
assign cmdr_data = hit_r ? cmd_data : 8'h0;
assign cmdr_vld = hit_r;


//----------- local path -----------
wire [7:0]	cmdl_mod;
wire [7:0]	cmdl_addr;
wire [7:0]	cmdl_data;
wire				cmdl_vld;
//assign cmdl_mod = hit_l ? cmd_mod : 8'h0;
//assign cmdl_addr = hit_l ? cmd_addr : 8'h0;
//assign cmdl_data = hit_l ? cmd_data : 8'h0;
assign cmdl_mod =  cmd_mod ;
assign cmdl_addr = cmd_addr ;
assign cmdl_data = cmd_data ;
assign cmdl_vld = hit_l;


//----------- q path ---------
reg [1:0]	cmdr_vld_reg;
always @(posedge clk_sys)
	cmdr_vld_reg <= {cmdr_vld_reg[0],cmdr_vld};

wire cmdr_qvld = cmdr_vld_reg[1];

wire[7:0]	cmd_q;
wire			cmd_qvld;
assign cmd_q = cmdl_qvld ? cmdl_q : 8'h0;
assign cmd_qvld = cmdl_qvld | cmdr_qvld;


endmodule


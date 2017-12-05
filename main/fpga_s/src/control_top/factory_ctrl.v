//factory_ctrl.v

module factory_ctrl(
//cmd receive
cmdr_dev,
cmdr_mod,
cmdr_addr,
cmdr_data,
cmdr_vld,
//cmd transmit
cmdt_dev,
cmdt_mod,
cmdt_addr,
cmdt_data,
cmdt_vld,
//cmd local
cmdl_dev,
cmdl_mod,
cmdl_addr,
cmdl_data,
cmdl_vld,
//configuration
dev_id,
//clk rst
clk_sys,
pluse_us,
rst_n
);
//cmd receive
input [7:0]	cmdr_dev;
input [7:0]	cmdr_mod;
input [7:0]	cmdr_addr;
input [7:0]	cmdr_data;
input 			cmdr_vld;
//cmd transmit
output [7:0]	cmdt_dev;
output [7:0]	cmdt_mod;
output [7:0]	cmdt_addr;
output [7:0]	cmdt_data;
output				cmdt_vld;
//cmd local
output [7:0]	cmdl_dev;
output [7:0]	cmdl_mod;
output [7:0]	cmdl_addr;
output [7:0]	cmdl_data;
output 				cmdl_vld;
//configuration
output [7:0]	dev_id;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//---------------------------------------
//---------------------------------------

reg [7:0] dev_id;
wire broadcast = (cmdr_dev == 8'hff) ? 1'b1 : 1'b0;
wire localhost = (cmdr_dev == dev_id) ? 1'b1 : 1'b0;
wire cmd_setid = broadcast & (cmdr_mod == 8'h0) & (cmdr_addr == 8'h0) ;

//----------set dev id ---------
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		dev_id <= 8'h0;
	else if(cmdr_vld & cmd_setid)
		dev_id <= cmdr_data + 8'h1;
	else ;
end


//----------- output --------
//cmd transmit
reg [7:0]	cmdt_dev;
reg [7:0]	cmdt_mod;
reg [7:0]	cmdt_addr;
reg [7:0]	cmdt_data;
reg				cmdt_vld;
//cmd local
reg [7:0]	cmdl_dev;
reg [7:0]	cmdl_mod;
reg [7:0]	cmdl_addr;
reg [7:0]	cmdl_data;
reg 			cmdl_vld;
always @ (posedge clk_sys)	begin
	cmdt_dev <= cmdr_dev;
	cmdt_mod <= cmdr_mod;
	cmdt_addr <= cmdr_addr;
	cmdt_data <= cmd_setid ? (cmdr_data + 8'h1) : cmdr_data;
	cmdl_dev <= cmdr_dev;
	cmdl_mod <= cmdr_mod;
	cmdl_addr <= cmdr_addr;
	cmdl_data <= cmdr_data;
end

always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cmdl_vld <= 1'b0;
	else if((broadcast | localhost) & cmdr_vld) 
		cmdl_vld <= 1'b1;
	else 
		cmdl_vld <= 1'b0;
end

always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cmdt_vld <= 1'b0;
	else if(~localhost & cmdr_vld) 
		cmdt_vld <= 1'b1;
	else 
		cmdt_vld <= 1'b0;
end


endmodule


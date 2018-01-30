
module cmd_gen(
dev_id,
mod_id,
cmd_addr,
cmd_data,
cmd_vld
);
output [7:0]	dev_id;
output [7:0]	mod_id;
output [7:0]	cmd_addr;
output [7:0]	cmd_data;
output 				cmd_vld;
//-------------------------------
reg [7:0]	dev_id;
reg [7:0]	mod_id;
reg [7:0]	cmd_addr;
reg [7:0]	cmd_data;
reg 			cmd_vld;
//---------- cmd action ------------
initial begin
	#0
	cmd_vld <= 1'b0;
	#3000
	dev_id <= 8'h0;
	mod_id <= 8'h12;
	cmd_addr <= 8'h34;
	cmd_data <= 8'h56;
	cmd_vld <= 1'b1;
	#100 
	cmd_vld <= 1'b0;
	#17000
	dev_id <= 8'h01;
	mod_id <= 8'h91;
	cmd_addr <= 8'h47;
	cmd_data <= 8'h02;
	cmd_vld <= 1'b1;
	#100
	cmd_vld <= 1'b0;
	#17000
	dev_id <= 8'h02;
	mod_id <= 8'h91;
	cmd_addr <= 8'h78;
	cmd_data <= 8'h90;
	cmd_vld <= 1'b1;
	#100
	cmd_vld <= 1'b0;
end


endmodule

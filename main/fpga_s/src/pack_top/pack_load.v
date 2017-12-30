//pack_load.v


module pack_load(
fire_load,
done_load,
//data path
load_data,
load_vld,
buf_waddr,
buf_raddr,
q_x,
q_y,
q_z,
//configuration
cfg_sample,
//clk rst
clk_sys,
rst_n
);
input		fire_load;
output	done_load;
//data path
output [7:0]	load_data;
output				load_vld;
input  [11:0]	buf_waddr;
output [11:0]	buf_raddr;
input  [31:0]	q_x;
input  [31:0]	q_y;
input  [31:0]	q_z;
//configuration
input [7:0]	cfg_sample;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------


parameter S_IDLE = 4'h0;
parameter S_X1 = 4'h1;
parameter S_X2 = 4'h2;
parameter S_X3 = 4'h3;
parameter S_Y1 = 4'h4;
parameter S_Y2 = 4'h5;
parameter S_Y3 = 4'h6;
parameter S_Z1 = 4'h7;
parameter S_Z2 = 4'h8;
parameter S_Z3 = 4'h9;
parameter S_CHECK = 4'ha;
parameter S_DONE = 4'hf;
reg [3:0] st_pack_load;
wire finish_load;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_pack_load <= S_IDLE;
	else begin
		case(st_pack_load)
			S_IDLE : st_pack_load <= fire_load ? S_X1 : S_IDLE;
			S_X1 : st_pack_load <= S_X2;
			S_X2 : st_pack_load <= S_X3;
			S_X3 : st_pack_load <= S_Y1;
			S_Y1 : st_pack_load <= S_Y2;
			S_Y2 : st_pack_load <= S_Y3;
			S_Y3 : st_pack_load <= S_Z1;
			S_Z1 : st_pack_load <= S_Z2;
			S_Z2 : st_pack_load <= S_Z3;
			S_Z3 : st_pack_load <= S_CHECK;
			S_CHECK : st_pack_load <= finish_load ? S_DONE : S_X1;
			S_DONE :  st_pack_load <= S_IDLE;
			default : st_pack_load <= S_IDLE;
		endcase
	end
end


endmodule


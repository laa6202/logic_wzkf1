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
len_load,
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
input [11:0]	len_load;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------




//------------ main FSM ----------
parameter S_IDLE = 4'h0;
parameter S_PREP = 4'he; 
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
			S_IDLE : st_pack_load <= fire_load ? S_PREP : S_IDLE;
			S_PREP : st_pack_load <= S_X1;
			S_X1 : st_pack_load <= S_X2;
			S_X2 : st_pack_load <= S_X3;
			S_X3 : st_pack_load <= S_Y1;
			S_Y1 : st_pack_load <= S_Y2;
			S_Y2 : st_pack_load <= S_Y3;
			S_Y3 : st_pack_load <= S_Z1;
			S_Z1 : st_pack_load <= S_Z2;
			S_Z2 : st_pack_load <= S_Z3;
			S_Z3 : st_pack_load <= S_CHECK;
			S_CHECK : st_pack_load <= finish_load ? S_DONE : S_PREP;
			S_DONE :  st_pack_load <= S_IDLE;
			default : st_pack_load <= S_IDLE;
		endcase
	end
end


//--------- FSM cnt_load and finish_load---------


reg [11:0] cnt_load;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_load <= 12'h0;
	else if(st_pack_load == S_CHECK)
		cnt_load <= cnt_load + 12'h1;
	else if(st_pack_load == S_DONE)
		cnt_load <= 12'h0;
	else ;
end

assign finish_load = (cnt_load == (len_load - 12'h1)) ? 1'b1 : 1'b0;


//------------ control signal ------------
wire done_load;
assign done_load = (st_pack_load == S_DONE) ? 1'b1 : 1'b0;

	
//------------- read address ------------
wire addr_ov;
assign addr_ov = (buf_waddr >= len_load) ? 1'b0 : 1'b1;

reg [11:0]	buf_raddr;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		buf_raddr <= 12'h0;
	else begin
		if(st_pack_load == S_IDLE)
			buf_raddr <= addr_ov ? 	(buf_waddr + 12'd4000 - len_load) : 
															(buf_waddr - len_load) ;
		else if(st_pack_load == S_CHECK)	begin
			if(buf_raddr == 12'd3999)
				buf_raddr <= 12'h0;
			else 
				buf_raddr <= buf_raddr + 12'h1;
		end
		else ;
	end
end


//----------- load data output --------
wire now_send = (st_pack_load == S_X1) | (st_pack_load == S_X2) |
								(st_pack_load == S_X3) | (st_pack_load == S_Y1) |
								(st_pack_load == S_Y2) | (st_pack_load == S_Y3) |
								(st_pack_load == S_Z1) | (st_pack_load == S_Z2) |
								(st_pack_load == S_Z3) ;
reg [7:0] 	load_data;
reg 				load_vld;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		load_vld <= 1'b0;
	else 
		load_vld <= now_send;
end
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		load_data <= 8'h0;
	else begin
		case(st_pack_load)
			S_X1 : load_data <= q_x[23:16];
			S_X2 : load_data <= q_x[15:8];
			S_X3 : load_data <= q_x[7:0];
			S_Y1 : load_data <= q_y[23:16];
			S_Y2 : load_data <= q_y[15:8];
			S_Y3 : load_data <= q_y[7:0];
			S_Z1 : load_data <= q_z[23:16];
			S_Z2 : load_data <= q_z[15:8];
			S_Z3 : load_data <= q_z[7:0];
			default : load_data <= 8'h0;
		endcase
	end
end


endmodule


//pack_head.v


module pack_head(
fire_head,
done_head,
//data path
head_data,
head_vld,
q_utc,
q_ns,
//configuration
cfg_sample,
len_load,
//clk rst
clk_sys,
rst_n
);
input		fire_head;
output	done_head;
//data path
output [7:0]	head_data;
output				head_vld;
input [31:0]	q_utc;
input [31:0]	q_ns;
//configuration
input [7:0]		cfg_sample;
input [11:0]	len_load;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------



//------------ main FSM -----------
parameter S_IDLE = 4'h0;
parameter S_VER  = 4'h1;
parameter S_PID  = 4'h2;
parameter S_LEN1 = 4'h3;
parameter S_LEN2 = 4'h4;
parameter S_UTC1 = 4'h5;
parameter S_UTC2 = 4'h6;
parameter S_UTC3 = 4'h7;
parameter S_UTC4 = 4'h8;
parameter S_NS1 = 4'h9;
parameter S_NS2 = 4'ha;
parameter S_NS3 = 4'hb;
parameter S_NS4 = 4'hc;
parameter S_DONE = 4'hf;
reg [3:0] st_pack_head;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_pack_head <= S_IDLE;
	else begin
		case(st_pack_head)
			S_IDLE : st_pack_head <= fire_head ? S_VER : S_IDLE;
			S_VER  : st_pack_head <= S_PID;
			S_PID  : st_pack_head <= S_LEN1;
			S_LEN1 : st_pack_head <= S_LEN2;
			S_LEN2 : st_pack_head <= S_UTC1;
			S_UTC1 : st_pack_head <= S_UTC2;
			S_UTC2 : st_pack_head <= S_UTC3;
			S_UTC3 : st_pack_head <= S_UTC4;
			S_UTC4 : st_pack_head <= S_NS1;
			S_NS1  : st_pack_head <= S_NS2;
			S_NS2  : st_pack_head <= S_NS3;
			S_NS3  : st_pack_head <= S_NS4;
			S_NS4  : st_pack_head <= S_DONE;
			S_DONE :  st_pack_head <= S_IDLE;
			default : st_pack_head <= S_IDLE;
		endcase
	end
end


//--------- control singal ----------
wire done_head = (st_pack_head == S_DONE) ? 1'b1 : 1'b0; 


//---------- head data output -----------
reg [7:0] head_data;
reg				head_vld;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		head_data <= 8'h0;
	else begin
		case(st_pack_head)
			S_VER  : head_data <= 8'h51;
			S_PID  : head_data <= cfg_sample;
			S_LEN1 : head_data <= {4'h0,len_load[11:8]};
			S_LEN2 : head_data <= len_load[7:0];
			S_UTC1 : head_data <= q_utc[31:24];
			S_UTC2 : head_data <= q_utc[23:16];
			S_UTC3 : head_data <= q_utc[15:8];
			S_UTC4 : head_data <= q_utc[7:0];
			S_NS1  : head_data <= q_ns[31:24];
			S_NS2  : head_data <= q_ns[23:16];
			S_NS3  : head_data <= q_ns[15:8];
			S_NS4  : head_data <= q_ns[7:0];
			default : head_data <= 8'h0;
		endcase
	end
end

always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		head_vld <= 1'h0;
	else 
		head_vld <= (st_pack_head != S_IDLE) & (st_pack_head != S_DONE);		
end

endmodule


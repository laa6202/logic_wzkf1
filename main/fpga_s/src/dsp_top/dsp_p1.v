//dsp_p1.v

module dsp_p1(
//data path in
ad1_data,
ad1_vld,
ad2_data,
ad2_vld,
ad3_data,
ad3_vld,
//data path output
dp_data,
dp_vld,
dp_utc,
dp_ns,
//clk rst
utc_sec,
now_ns,
clk_sys,
rst_n
);
//data path in
input [23:0]	ad1_data;
input					ad1_vld;
input [23:0]	ad2_data;
input					ad2_vld;
input [23:0]	ad3_data;
input					ad3_vld;
//data path output
output [23:0]	dp_data;
output				dp_vld;
output [31:0]	dp_utc;
output [31:0]	dp_ns;
//clk rst
input [31:0]	utc_sec;
input [31:0]	now_ns;
input clk_sys;
input rst_n;
//--------------------------------
//--------------------------------


//-------- lock time ------
reg [31:0]	lock_utc;
reg [31:0]	lock_ns;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)	begin
		lock_utc <= 32'h0;
		lock_ns <= 32'h0;
	end
	else if(ad1_vld) begin
		lock_utc <= utc_sec;
		lock_ns <= now_ns;
	end
end


//----------- main FSM --------
parameter S_IDLE = 3'h0;
parameter S_P1 = 3'h1;
parameter S_P2 = 3'h2;
parameter S_P3 = 3'h3;
parameter S_P4 = 3'h4;
parameter S_DONE = 3'h7;
reg [2:0] st_dsp_p1;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_dsp_p1 <= S_IDLE;
	else begin
		case(st_dsp_p1)
			S_IDLE : st_dsp_p1 <= ad1_vld ? S_P1 : S_IDLE;
			S_P1 : st_dsp_p1 <= S_P2;
			S_P2 : st_dsp_p1 <= S_P3;
			S_P3 : st_dsp_p1 <= S_P4;
			S_P4 : st_dsp_p1 <= S_DONE;
			S_DONE : st_dsp_p1 <= S_IDLE;
			default : st_dsp_p1 <= S_IDLE;
		endcase
	end
end


//-------- data push ---------
wire [23:0] dp_data;
wire 				dp_vld;
wire [31:0]	dp_utc;
wire [31:0]	dp_ns;
assign dp_data = 	(st_dsp_p1 == S_P1) ? ad1_data : 
									(st_dsp_p1 == S_P2) ? ad2_data : 
									(st_dsp_p1 == S_P3) ? ad3_data : 
									(st_dsp_p1 == S_P4) ? 24'h4444 : 24'h0;
assign dp_vld = (st_dsp_p1 == S_P1) | (st_dsp_p1 == S_P2) | 
								(st_dsp_p1 == S_P3) | (st_dsp_p1 == S_P4);
assign dp_utc = lock_utc;
assign dp_ns  = lock_ns;


endmodule


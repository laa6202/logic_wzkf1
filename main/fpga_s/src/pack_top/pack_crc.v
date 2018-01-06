//pack_crc.v

module pack_crc(
fire_crc,
done_crc,
//data path
head_data,
head_vld,
load_data,
load_vld,
tail_data,
tail_vld,
crc_data,
crc_vld,
//clk rst
clk_sys,
rst_n
);
input		fire_crc;
output	done_crc;
//data path
input [7:0]	head_data;
input				head_vld;
input [7:0]	load_data;
input				load_vld;
input [7:0]	tail_data;
input				tail_vld;
output [7:0]	crc_data;
output				crc_vld;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------


//---------- FSM ------------
parameter S_IDLE = 2'h0;
parameter S_PUSH = 2'h1;
parameter S_PUSH2= 2'h2;
parameter S_DONE = 2'h3;
reg [1:0] st_pack_crc;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_pack_crc <= S_IDLE;
	else begin
		case(st_pack_crc)
			S_IDLE : st_pack_crc <= fire_crc ? S_PUSH : S_IDLE;
			S_PUSH : st_pack_crc <= S_PUSH2;
			S_PUSH2: st_pack_crc <= S_DONE;
			S_DONE : st_pack_crc <= S_IDLE;
			default : st_pack_crc <= S_IDLE;
		endcase
	end
end


//----------control signal ------------
wire done_crc = (st_pack_crc == S_DONE) ? 1'b1 : 1'b0;


//---------- output crc data -----------
reg [15:0] crc;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		crc <= 16'h0;
	else if(st_pack_crc == S_DONE) 
		crc <= 16'h0;
	else if(head_vld)
		crc <= crc + {8'h0,head_data};
	else if(load_vld)
		crc <= crc + {8'h0,load_data};
	else if(tail_vld)
		crc <= crc + {8'h0,tail_data};
	else ;
end

reg [7:0] crc_data;
reg				crc_vld;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		crc_data <= 8'h0;
	else if(st_pack_crc == S_PUSH)
		crc_data <= crc[15:8];
	else if(st_pack_crc == S_PUSH2)
		crc_data <= crc[7:0];
	else 
		crc_data <= 8'h0;
end
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		crc_vld <= 1'h0;
	else 
		crc_vld <= (st_pack_crc == S_PUSH) | (st_pack_crc == S_PUSH2);
end

endmodule


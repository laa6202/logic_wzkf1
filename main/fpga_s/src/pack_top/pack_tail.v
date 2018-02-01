//pack_tail.v


module pack_tail(
fire_tail,
done_tail,
//data path
bm_q,
bm_req,
exp_data,
tail_data,
tail_vld,
//clk rst
clk_sys,
rst_n
);
input		fire_tail;
output	done_tail;
//data path
input [7:0]	bm_q;
output			bm_req;
input [127:0]	exp_data;
output [7:0]	tail_data;
output				tail_vld;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------


//----------- main FSM ---------
parameter S_IDLE = 3'h0;
parameter S_PREP = 3'h1;
parameter S_RBMF = 3'h2;	//read bm first
parameter S_RDBM = 3'h3;	//read bm
parameter S_RBML = 3'h4;	//read bm last
parameter S_RDEP = 3'h6;
parameter S_DONE = 3'h7;
reg [2:0] st_pack_tail;
wire finish_bm;
wire finish_ep;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_pack_tail <= S_IDLE;
	else begin
		case(st_pack_tail)
			S_IDLE : st_pack_tail <= fire_tail ? S_PREP : S_IDLE ;
			S_PREP : st_pack_tail <= S_RBMF;
			S_RBMF : st_pack_tail <= S_RDBM;
			S_RDBM : st_pack_tail <= finish_bm ? S_RBML : S_RDBM;
			S_RBML : st_pack_tail <= S_RDEP;
			S_RDEP : st_pack_tail <= finish_ep ? S_DONE : S_RDEP;
			S_DONE : st_pack_tail <= S_IDLE;
			default : st_pack_tail <= S_IDLE;
		endcase
	end
end


//---------- FSM condition --------
reg [4:0] cnt_bm;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_bm <= 5'h0;
	else if(st_pack_tail == S_RDBM)
		cnt_bm <= cnt_bm + 5'h1;
	else 
		cnt_bm <= 5'h0;
end
assign finish_bm = (cnt_bm == 5'd14) ? 1'b1 : 1'b0;
reg [7:0] cnt_ep;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_ep <= 8'h0;
	else if(st_pack_tail == S_RDEP)
		cnt_ep <= cnt_ep + 8'h1;
	else 
		cnt_ep <= 8'h0;
end
assign finish_ep = (cnt_ep == 8'd15) ? 1'b1 : 1'b0;



//---------- control signal -----------
wire bm_req = (st_pack_tail == S_RDBM) | (st_pack_tail == S_RBMF);
wire done_tail = (st_pack_tail == S_DONE) ? 1'b1 : 1'b0;


//---------- prepare swift register -------
reg [127:0] lock_ep;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		lock_ep <= 128'h0;
	else if(st_pack_tail == S_PREP)
		lock_ep <= exp_data;
	else if(st_pack_tail == S_RDEP)
		lock_ep <= {lock_ep[119:0],8'h0};
	else ;
end


//---------- data output ------------
wire [7:0] 	tail_data;
wire 				tail_vld = 	(st_pack_tail == S_RDBM) | 
												(st_pack_tail == S_RBML) |
												(st_pack_tail == S_RDEP);
assign tail_data = 	(st_pack_tail == S_RDEP) ? lock_ep[127:120] :
										(st_pack_tail == S_RDBM) ? bm_q : 8'h0;
endmodule


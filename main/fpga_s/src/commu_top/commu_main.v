//commu_main.v

module commu_main(
//control signal
fire_head,
fire_push,
fire_tail,
done_head,
done_push,
done_tail,
//env
pk_frm,
slot_rdy,
slot_begin,
//clk rst
clk_sys,
rst_n
);
//control signal
output fire_head;
output fire_push;
output fire_tail;
input done_head;
input done_push;
input done_tail;
//env
input pk_frm;
input slot_rdy;
output slot_begin;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------



//------------ main FSM -------------
parameter S_IDLE = 4'h0;
parameter S_BUF = 4'ha;
parameter S_BUF2 = 4'hb;
parameter S_SLOT = 4'hc;
parameter S_FIRE_H = 4'h1;
parameter S_WAIT_H = 4'h2;
parameter S_FIRE_P = 4'h3;
parameter S_WAIT_P = 4'h4;
parameter S_FIRE_T = 4'h5;
parameter S_WAIT_T = 4'h6;
parameter S_DONE = 4'hf;
reg [3:0] st_commu_main;
wire finish_buf2;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_commu_main <= S_IDLE;
	else begin
		case(st_commu_main)
			S_IDLE : st_commu_main <= pk_frm ? S_BUF : 
																slot_rdy ? S_FIRE_H : S_IDLE;
			S_FIRE_H : st_commu_main <= S_WAIT_H;
			S_FIRE_P : st_commu_main <= S_WAIT_P;
			S_FIRE_T : st_commu_main <= S_WAIT_T;
			S_WAIT_H : st_commu_main <= done_head ? S_FIRE_P : S_WAIT_H;
			S_WAIT_P : st_commu_main <= done_push ? S_FIRE_T : S_WAIT_P;
			S_WAIT_T : st_commu_main <= done_tail ? S_DONE : S_WAIT_T;
			S_BUF  : st_commu_main <= (~pk_frm) ? S_BUF2 : S_BUF;
			S_BUF2 : st_commu_main <= finish_buf2 ? S_SLOT : S_BUF2;
			S_SLOT : st_commu_main <= S_IDLE;
			S_DONE : st_commu_main <= S_IDLE;
			default : st_commu_main <= S_IDLE;
		endcase
	end
end


//--------- FSM buf2 -------
reg [31:0] cnt_buf2;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_buf2 <= 32'h0;
	else if(st_commu_main == S_BUF2)
		cnt_buf2 <= cnt_buf2 + 32'h1;
	else 
		cnt_buf2 <= 32'h0;
end
`ifdef SIM
assign finish_buf2 = (cnt_buf2 == 32'd1_00) ? 1'b1 :1'b0;
`else 
assign finish_buf2 = (cnt_buf2 == 32'd1_000_00) ? 1'b1 : 1'b0;
`endif 


//--------- slot begin ---------
wire slot_begin;
assign slot_begin = (st_commu_main == S_SLOT) ? 1'b1 : 1'b0;


//---------- control singal ----------
wire fire_head;
wire fire_push;
wire fire_tail; 
assign fire_head = (st_commu_main == S_FIRE_H) ? 1'b1 : 1'b0;
assign fire_push = (st_commu_main == S_FIRE_P) ? 1'b1 : 1'b0;
assign fire_tail = (st_commu_main == S_FIRE_T) ? 1'b1 : 1'b0;



endmodule

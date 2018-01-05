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
cmd_retry,
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
input [7:0]	cmd_retry;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------

wire cmd_re;
assign cmd_re = cmd_retry[0] & cmd_retry[1];


//------------ main FSM -------------
parameter S_IDLE = 4'h0;
parameter S_BUF = 4'ha;
parameter S_FIRE_H = 4'h1;
parameter S_WAIT_H = 4'h2;
parameter S_FIRE_P = 4'h3;
parameter S_WAIT_P = 4'h4;
parameter S_FIRE_T = 4'h5;
parameter S_WAIT_T = 4'h6;
parameter S_DONE = 4'hf;
reg [3:0] st_commu_main;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_commu_main <= S_IDLE;
	else begin
		case(st_commu_main)
			S_IDLE : st_commu_main <= pk_frm ? S_BUF : 
																slot_rdy ? S_FIRE_H :
																cmd_re ? S_FIRE_H : S_IDLE;
			S_FIRE_H : st_commu_main <= S_WAIT_H;
			S_FIRE_P : st_commu_main <= S_WAIT_P;
			S_FIRE_T : st_commu_main <= S_WAIT_T;
			S_WAIT_H : st_commu_main <= done_head ? S_FIRE_P : S_WAIT_H;
			S_WAIT_P : st_commu_main <= done_push ? S_FIRE_T : S_WAIT_P;
			S_WAIT_T : st_commu_main <= done_tail ? S_DONE : S_WAIT_T;
			S_BUF  : st_commu_main <= (~pk_frm) ? S_IDLE : S_BUF;
			S_DONE : st_commu_main <= S_IDLE;
			default : st_commu_main <= S_IDLE;
		endcase
	end
end

endmodule

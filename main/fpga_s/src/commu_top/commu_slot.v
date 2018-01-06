//commu_slot.v


module commu_slot(
slot_begin,
slot_rdy,
mode_numDev,
dev_id,
cmd_retry,
//clk rst
clk_sys,
rst_n
);
input 	slot_begin;
output 	slot_rdy;
input [1:0]	mode_numDev;
input [7:0]	dev_id;
input [7:0]	cmd_retry;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------




//---------- total slot and slot period ---------
wire [7:0] total_slot;
assign total_slot = (mode_numDev == 2'h3) ? 8'd25 :
										(mode_numDev == 2'h1) ? 8'd20 : 
										(mode_numDev == 2'h0) ? 8'd10 : 8'd25;
wire [23:0] slot_period;
`ifdef SIM
assign slot_period =(mode_numDev == 2'h3) ? 24'd3_84 :
										(mode_numDev == 2'h1) ? 24'd4_80 :
										(mode_numDev == 2'h0) ? 24'd9_60 : 24'd3_84;
`else 
assign slot_period =(mode_numDev == 2'h3) ? 24'd39_950_00 :
										(mode_numDev == 2'h1) ? 24'd49_940_00 :
										(mode_numDev == 2'h0) ? 24'd99_880_00 : 24'd39_950_00;
`endif


//----------- main FSM ---------
parameter S_IDLE = 3'h0;
parameter S_HEAD = 3'h1;
parameter S_MARK = 3'h2;
parameter S_SLOT = 3'h3;
parameter S_CHECK = 3'h4;
parameter S_DONE = 3'h7;
reg [2:0] st_commu_slot;
wire finish_slot;
wire finish_all;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_commu_slot <= S_IDLE;
	else begin
		case(st_commu_slot)
			S_IDLE : st_commu_slot <= slot_begin ? S_HEAD : S_IDLE;
			S_HEAD : st_commu_slot <= S_MARK;
			S_MARK : st_commu_slot <= S_SLOT;
			S_SLOT : st_commu_slot <= finish_slot ? S_CHECK : S_SLOT;
			S_CHECK: st_commu_slot <= finish_all ? S_DONE : S_HEAD;
			S_DONE : st_commu_slot <= S_IDLE;
			default: st_commu_slot <= S_IDLE;
		endcase
	end
end
wire slot_head = (st_commu_slot == S_HEAD) ? 1'b1 : 1'b0;



//---------- FSM finish_slot --------
reg [23:0] cnt_slot_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_slot_cycle <= 24'h0;
	else if( st_commu_slot == S_SLOT)
		cnt_slot_cycle <= cnt_slot_cycle + 24'h1;
	else 
		cnt_slot_cycle <= 24'h0;
end
assign finish_slot = (cnt_slot_cycle == (slot_period - 24'h1)) ? 1'b1 : 1'b0;


//------------- FMS finish_all --------
reg [7:0] cnt_slot_id;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_slot_id <= 8'h0;
	else if(st_commu_slot == S_HEAD)
		cnt_slot_id <= cnt_slot_id + 8'h1;
	else if(st_commu_slot == S_DONE)
		cnt_slot_id <= 8'h0;
	else ;
end
assign finish_all = (cnt_slot_id == total_slot) ? 1'b1 : 1'b0;


//-------- slot_fix -----------
wire slot_fix;
assign slot_fix = (cnt_slot_id == dev_id) & (st_commu_slot == S_MARK);


//--------- slot_cmd -----------
wire slot_cmd;
wire cmd_re;
assign cmd_re = cmd_retry[7];
reg [7:0] cmd_slot_id;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cmd_slot_id <= 8'h0;
	else if(cmd_re)
		cmd_slot_id = {1'b0,cmd_retry[6:0]};
	else ;
end
reg lock_cmd_re;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		lock_cmd_re <= 1'b0;
	else if(cmd_re)
		lock_cmd_re <= 1'b1;
	else if(finish_all)
		lock_cmd_re <= 1'b0;
	else ;
end
assign slot_cmd = lock_cmd_re & 
									(cnt_slot_id == cmd_slot_id) & (st_commu_slot == S_MARK);

//------------ slot_rdy ----------
wire slot_rdy  = slot_fix | slot_cmd;


endmodule


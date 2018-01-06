//commu_tail.v

`define TW_TAIL 8'd10
`define TIMOUT_TX_SIM 16'd6
`define TIMOUT_TX 		16'hC0

module commu_tail(
fire_tail,
done_tail,
//data path
fire_tx,
done_tx,
data_tx,
//clk rst
clk_sys,
rst_n
);
input		fire_tail;
output	done_tail;
//data path
output				fire_tx;
input					done_tx;
output [15:0]	data_tx;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------


wire [7:0] total_tail = `TW_TAIL;

//---------- main FSM ---------
parameter S_IDLE = 3'h0;
parameter S_TAIL = 3'h1;
parameter S_FIRE = 3'h2;
parameter S_WAIT = 3'h3;
parameter S_NEXT = 3'h4;
parameter S_DONE = 3'h7;
reg [2:0] st_commu_tail;
wire finish_tail;
wire timeout_tx;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_commu_tail <= S_IDLE;
	else begin
		case(st_commu_tail)
			S_IDLE : st_commu_tail <= fire_tail ? S_TAIL : S_IDLE;
			S_TAIL : st_commu_tail <= S_FIRE;
			S_FIRE : st_commu_tail <= S_WAIT;
			S_WAIT : st_commu_tail <= (done_tx | timeout_tx)? S_NEXT : S_WAIT;
			S_NEXT : st_commu_tail <= finish_tail ? S_DONE : S_TAIL;
			S_DONE : st_commu_tail <= S_IDLE;
			default : st_commu_tail <= S_IDLE;
		endcase
	end
end

reg [7:0] cnt_tail;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_tail <= 8'h0;
	else if(st_commu_tail == S_TAIL)
		cnt_tail <= cnt_tail + 8'h1;
	else if(st_commu_tail == S_DONE)
		cnt_tail <= 8'h0;
	else ;
end
assign finish_tail = (cnt_tail == total_tail) ? 1'b1 : 1'b0;


//----------  FSM timeout_tx -----------
reg [15:0] cnt_wait;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_wait <= 16'h0;
	else if(st_commu_tail == S_WAIT)
		cnt_wait <= cnt_wait + 16'h1;
	else 
		cnt_wait <= 16'h0;
end
`ifdef SIM
assign timeout_tx = (cnt_wait == `TIMOUT_TX_SIM) ? 1'b1 : 1'b0;
`else 
assign timeout_tx = (cnt_wait == `TIMOUT_TX) ? 1'b1 : 1'b0;
`endif


//---------- control signal -----------
wire done_tail;
assign done_tail = (st_commu_tail == S_DONE) ? 1'b1 : 1'b0;


//---------- data output ----------
wire				fire_tx;
wire [15:0]	data_tx;
assign fire_tx = (st_commu_tail == S_FIRE) ? 1'b0 : 1'b0;	//no send head bit
assign data_tx = (st_commu_tail == S_FIRE) ? 16'hFFFF : 16'h0;



endmodule


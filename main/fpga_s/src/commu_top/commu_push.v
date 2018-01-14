//commu_push.v

module commu_push(
fire_push,
done_push,
//data path
buf_rd,
buf_q,
buf_frm,
fire_tx,
done_tx,
data_tx,
//configuration
len_pkg,
//clk rst
clk_sys,
rst_n
);
input		fire_push;
output	done_push;
//data path
output buf_rd;
output buf_frm;
input [7:0]	buf_q;
output				fire_tx;
input					done_tx;
output [15:0]	data_tx;
//configuration
input [15:0]	len_pkg;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------

wire [15:0] lenw_pkg = {1'b0,len_pkg[15:1]};


//---------- main FSM ---------
parameter S_IDLE = 3'h0;
parameter S_READ = 3'h1;
parameter S_PUSH = 3'h2;
parameter S_FIRE = 3'h4;
parameter S_WAIT = 3'h5;
parameter S_NEXT = 3'h6;
parameter S_DONE = 3'h7;
reg [2:0] st_commu_push;
wire finish_push;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_commu_push <= S_IDLE;
	else begin
		case(st_commu_push)
			S_IDLE : st_commu_push <= fire_push ? S_READ : S_IDLE;
			S_READ : st_commu_push <= S_PUSH;
			S_PUSH : st_commu_push <= S_FIRE;
			S_FIRE : st_commu_push <= S_WAIT;
			S_WAIT : st_commu_push <= done_tx ? S_NEXT : S_WAIT;
			S_NEXT : st_commu_push <= finish_push ? S_DONE : S_READ;
			S_DONE : st_commu_push <= S_IDLE;
			default : st_commu_push <= S_IDLE;
		endcase
	end
end


//----------- FSM finish_push --------
reg [15:0] cnt_push;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_push <= 16'h0;
	else if(st_commu_push == S_PUSH) 
		cnt_push <= cnt_push + 16'h1;
	else if(st_commu_push == S_DONE)
		cnt_push <= 16'h0;
	else ;
end
assign finish_push = (cnt_push == lenw_pkg) ? 1'b1 : 1'b0; 


//---------- control signal -----------
wire done_push;
assign done_push = (st_commu_push == S_DONE) ? 1'b1 : 1'b0;


//---------- read data path --------
wire buf_rd;
wire buf_frm;
assign buf_rd = (st_commu_push == S_READ) | (st_commu_push == S_PUSH);
assign buf_frm = (st_commu_push != S_IDLE) ? 1'b1 : 1'b0;


//---------- data output ----------
reg [7:0] buf_q_reg;
always @ (posedge clk_sys)
	buf_q_reg <= buf_q;

//wire				fire_tx;
//assign fire_tx = (st_commu_push == S_FIRE) ? 1'b1 : 1'b0;
//wire [15:0]	data_tx;
//assign data_tx = (st_commu_push == S_FIRE) ? {buf_q_reg,buf_q}: 16'h0;
reg fire_tx;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		fire_tx <= 1'b0;
	else 
		fire_tx <= (st_commu_push == S_FIRE) ? 1'b1 : 1'b0;
end


reg [15:0]	data_tx;
always  @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		data_tx <= 16'h0;
	else if(st_commu_push == S_DONE)
		data_tx <= 16'h0;
	else if(st_commu_push == S_FIRE)
		data_tx <= {buf_q_reg,buf_q};
	else ;
end


endmodule


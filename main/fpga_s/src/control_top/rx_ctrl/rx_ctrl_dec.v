//rx_ctrl_dec.v

//`define EN_SIG_DEBUG		//no timeout 

module rx_ctrl_dec(
//cmd decode
cmdr_dev,
cmdr_mod,
cmdr_addr,
cmdr_data,
cmdr_vld,
//raw data
rx_vld,
rx_data,
//clk rst
clk_sys,
rst_n
);
//cmd decode
output [7:0]	cmdr_dev;
output [7:0]	cmdr_mod;
output [7:0]	cmdr_addr;
output [7:0]	cmdr_data;
output 				cmdr_vld;
//raw data
input				rx_vld;
input [7:0]	rx_data;
//clk rst
input clk_sys;
input rst_n;

//--------------------------------------


//------------- main FSM ------------
parameter S_IDLE = 3'h0;
parameter S_S1 = 3'h1;
parameter S_S2 = 3'h2;
parameter S_S3 = 3'h3;
parameter S_FAIL = 3'h6;
parameter S_DONE = 3'h7;
reg [2:0] st_rx_dec;
wire timeout_rx;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_rx_dec <= S_IDLE;
	else begin
		case(st_rx_dec)
			S_IDLE : st_rx_dec <= rx_vld ? S_S1 : S_IDLE;
			S_S1 : st_rx_dec <= timeout_rx ? S_FAIL : (rx_vld ? S_S2 : S_S1);
			S_S2 : st_rx_dec <= timeout_rx ? S_FAIL : (rx_vld ? S_S3 : S_S2);
			S_S3 : st_rx_dec <= timeout_rx ? S_FAIL : (rx_vld ? S_DONE : S_S3);
			S_FAIL : st_rx_dec <= S_IDLE;
			S_DONE : st_rx_dec <= S_IDLE;
			default : st_rx_dec <= S_IDLE;
		endcase
	end
end


//----------- FSM timeout ----------
reg [19:0] cnt_cycle;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 20'h0;
	else if((st_rx_dec == S_S1) | (st_rx_dec == S_S2) |(st_rx_dec == S_S3))
		cnt_cycle <= cnt_cycle + 20'h1;
	else 
		cnt_cycle <= 20'h0;
end
`ifdef EN_SIG_DEBUG
assign timeout_rx = 1'b0;
`else 
assign timeout_rx = (cnt_cycle == 20'd1_000_00) ? 1'b1 : 1'b0;
`endif

//--------- output data ---------
reg [7:0] cmdr_dev;
reg [7:0]	cmdr_mod;
reg [7:0]	cmdr_addr;
reg [7:0]	cmdr_data;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n) begin
		cmdr_dev <= 8'h0;
		cmdr_mod <= 8'h0;
		cmdr_addr <= 8'h0;
		cmdr_data <= 8'h0;
	end
	else if(rx_vld)	begin
		case(st_rx_dec)
			S_IDLE : cmdr_dev <=  rx_data ;
			S_S1 : cmdr_mod <= rx_data;
			S_S2 : cmdr_addr <= rx_data;
			S_S3 : cmdr_data <= rx_data;
			default : ;
		endcase
	end
	else ;
end
wire cmdr_vld;
assign cmdr_vld = (st_rx_dec == S_DONE) ? 1'b1 : 1'b0;

endmodule

//tx_ctrl_enc.v

module tx_ctrl_enc(
fire_tx,
done_tx,
data_tx,
//cmd transmit
cmdt_dev,
cmdt_mod,
cmdt_addr,
cmdt_data,
cmdt_vld,
//clk rst
clk_sys,
rst_n
);
output	fire_tx;
input		done_tx;
output [7:0]	data_tx;
//cmd transmit
input [7:0]	cmdt_dev;
input [7:0]	cmdt_mod;
input [7:0]	cmdt_addr;
input [7:0]	cmdt_data;
input 			cmdt_vld;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------------
//--------------------------------------------


//-------- lock data ------
reg [31:0] lock_data;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		lock_data <=  32'h0;
	else if(cmdt_vld)
		lock_data <= {cmdt_dev,cmdt_mod,cmdt_addr,cmdt_data};
	else ;
end
	


//----------- main FSM -----------
parameter S_IDLE = 4'h0;
parameter S_FS1 = 4'h1;
parameter S_WS1 = 4'h2;
parameter S_FS2 = 4'h3;
parameter S_WS2 = 4'h4;
parameter S_FS3 = 4'h5;
parameter S_WS3 = 4'h6;
parameter S_FS4 = 4'h7;
parameter S_WS4 = 4'h8;
parameter S_DONE = 4'hf;
reg [3:0] st_tx_enc;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_tx_enc <= S_IDLE;
	else begin
		case(st_tx_enc)
			S_IDLE : st_tx_enc <= cmdt_vld ? S_FS1 : S_IDLE;
			S_FS1 : st_tx_enc <= S_WS1;
			S_WS1 : st_tx_enc <= done_tx ? S_FS2 : S_WS1;
			S_FS2 : st_tx_enc <= S_WS2;
			S_WS2 : st_tx_enc <= done_tx ? S_FS3 : S_WS2;
			S_FS3 : st_tx_enc <= S_WS3;
			S_WS3 : st_tx_enc <= done_tx ? S_FS4 : S_WS3;
			S_FS4 : st_tx_enc <= S_WS4;
			S_WS4 : st_tx_enc <= done_tx ? S_DONE : S_WS4;
			S_DONE : st_tx_enc <= S_IDLE;
			default : st_tx_enc <= S_IDLE;
		endcase
	end
end


//---------- output ----------
wire fire_tx = 	(st_tx_enc == S_FS1) | (st_tx_enc == S_FS2) |
								(st_tx_enc == S_FS3) | (st_tx_enc == S_FS4) ;
wire [7:0]	data_tx;
assign data_tx = 	(st_tx_enc == S_FS1) ? lock_data[31:24] :
									(st_tx_enc == S_FS2) ? lock_data[23:16] :
									(st_tx_enc == S_FS3) ? lock_data[15:8] :
									(st_tx_enc == S_FS4) ? lock_data[7:0] : 8'h0;
									
									
endmodule


//arm_ctrl_mac.v

module arm_ctrl_mac(
fire_cspi,
done_cspi,
//data path
set_data,
set_vld,
get_q,
get_vld,
//configuration
dev_id,
mod_id,
cmd_addr,
cmd_data,
cmd_vld,
//clk rst
clk_sys,
rst_n
);
output fire_cspi;
input  done_cspi;
//data path
input [7:0]	set_data;
input				set_vld;
output[7:0]	get_q;
output 			get_vld;
//configuration
input [7:0]	dev_id;
input [7:0]	mod_id;
input	[7:0]	cmd_addr;
input	[7:0]	cmd_data;
input 			cmd_vld;
//clk rst
input clk_sys;
input rst_n;

//--------------------------------------
//--------------------------------------


//----------- main FSM -----------
parameter S_IDLE = 4'h0;
parameter S_FIRE1 = 4'h1;
parameter S_WAIT1 = 4'h2;
parameter S_FIRE2 = 4'h3;
parameter S_WAIT2 = 4'h4;
parameter S_FIRE3 = 4'h5;
parameter S_WAIT3 = 4'h6;
parameter S_FIRE4 = 4'h7;
parameter S_WAIT4 = 4'h8;
parameter S_FIRE5 = 4'h9;
parameter S_WAIT5 = 4'ha;
parameter S_DONE = 4'hf;
reg [3:0] st_actrl_mac;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_actrl_mac <= S_IDLE;
	else begin
		case(st_actrl_mac)
			S_IDLE : st_actrl_mac <= cmd_vld ? S_FIRE1 : S_IDLE;
			S_FIRE1: st_actrl_mac <= S_WAIT1;
			S_WAIT1: st_actrl_mac <= done_cspi ? S_FIRE2 : S_WAIT1;
			S_FIRE2: st_actrl_mac <= S_WAIT2;
			S_WAIT2: st_actrl_mac <= done_cspi ? S_FIRE3 : S_WAIT2;
			S_FIRE3: st_actrl_mac <= S_WAIT3;
			S_WAIT3: st_actrl_mac <= done_cspi ? S_FIRE4 : S_WAIT3;
			S_FIRE4: st_actrl_mac <= S_WAIT4;
			S_WAIT4: st_actrl_mac <= done_cspi ? S_FIRE5 : S_WAIT4;
			S_FIRE5: st_actrl_mac <= S_WAIT5;
			S_WAIT5: st_actrl_mac <= done_cspi ? S_DONE : S_WAIT5;
			S_DONE : st_actrl_mac <= S_IDLE;
			default :st_actrl_mac <= S_IDLE;
		endcase
	end
end


//------------ output ------------
wire fire_cspi =  (st_actrl_mac == S_FIRE1) | (st_actrl_mac == S_FIRE2) |
									(st_actrl_mac == S_FIRE3) | (st_actrl_mac == S_FIRE4) |
									(st_actrl_mac == S_FIRE5);


wire [7:0] set_data = (st_actrl_mac == S_FIRE1) ? dev_id :
											(st_actrl_mac == S_FIRE2) ? mod_id :
											(st_actrl_mac == S_FIRE3) ? cmd_addr :
											(st_actrl_mac == S_FIRE4) ? cmd_data :
											(st_actrl_mac == S_FIRE5) ? 8'hff : 8'h0;
wire set_vld = fire_cspi;
											
endmodule

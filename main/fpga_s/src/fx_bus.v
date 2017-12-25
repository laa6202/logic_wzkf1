//fx_bus.v

module fx_bus(
fx_q,
fx_q_syn,
fx_q_ad1,
fx_q_ad2,
fx_q_ad3,
//clk rst
clk_sys,
rst_n
);
output [7:0]	fx_q;
input [7:0]	fx_q_syn;
input [7:0]	fx_q_ad1;
input [7:0]	fx_q_ad2;
input [7:0]	fx_q_ad3;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------

wire [7:0] fx_q;
assign fx_q = fx_q_syn |
							fx_q_ad1 | fx_q_ad2 | fx_q_ad3 |
							8'h0;

endmodule

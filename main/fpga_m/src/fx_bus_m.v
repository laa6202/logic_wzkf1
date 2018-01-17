//fx_bus_m.v

module fx_bus_m(
fx_q,
fx_q_fetch,
fx_q_repkg,
fx_q_commu,
//clk rst
clk_sys,
rst_n
);
output [7:0]	fx_q;
input [7:0]	fx_q_fetch;
input [7:0]	fx_q_repkg;
input [7:0]	fx_q_commu;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------

wire [7:0] fx_q;
assign fx_q = fx_q_fetch |
							fx_q_repkg | 
							fx_q_commu |
							8'h0;

endmodule

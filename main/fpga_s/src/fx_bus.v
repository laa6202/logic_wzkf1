//fx_bus.v

module fx_bus(
fx_q,
fx_q_syn,
//clk rst
clk_sys,
rst_n
);
output [7:0]	fx_q;
input [7:0]	fx_q_syn;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------

wire [7:0] fx_q;
assign fx_q = fx_q_syn ;

endmodule

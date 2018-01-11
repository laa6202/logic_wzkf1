//commu_m_mux.v

module commu_m_mux(
real_rd,
real_q,
tp_rd,
tp_q,
req_rd,
req_q,
//configuratiuon
cfg_tp,
//clk rst
clk_sys,
rst_n
);
output 			real_rd;
input [7:0]	real_q;
output 			tp_rd;
input [7:0]	tp_q;
input				req_rd;
output [7:0]req_q;
//configuratiuon
input [7:0]	cfg_tp;
//clk rst
input	clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------

wire tp_rd = req_rd;
wire [7:0] req_q = tp_q;


endmodule

//bm_buf.v

module bm_buf(
bm_data,
bm_vld,
bm_q,
bm_req,
//clk rst
clk_sys,
rst_n
);
input [31:0]	bm_data;
input					bm_vld;
output [7:0]	bm_q;
input					bm_req;
//clk rst
input	clk_sys;
input	rst_n;
//---------------------------------------
//---------------------------------------




endmodule

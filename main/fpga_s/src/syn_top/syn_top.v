//syn_top.v

module syn_top(
rx_syn,
utc_sec,
now_ns,
//clk rst
clk_sys,
rst_n
);
input	rx_syn;
output [31:0]	utc_sec;
output [31:0]	now_ns;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------



endmodule


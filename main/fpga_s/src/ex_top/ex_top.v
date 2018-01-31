//ex_top.v

module ex_top(
exp_data,
//clk rst
clk_sys,
rst_n
);
output [127:0]	exp_data;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------

//no logic
wire [127:0]	exp_data = 128'h1234567890abcdef55aa55aa55aa55aa;


endmodule

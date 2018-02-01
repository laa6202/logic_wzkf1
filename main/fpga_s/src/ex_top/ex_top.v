//ex_top.v

module ex_top(
exp_data,
//clk rst
clk_sys,
rst_n
);
output [255:0]	exp_data;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------

//no logic
wire [255:0]	exp_data = 255'h1234567890abcdef55aa55aa55aa55aa;


endmodule

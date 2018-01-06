//commu_slot.v


module commu_slot(
slot_begin,
slot_rdy,
mode_numDev,
dev_id,
cmd_retry,
//clk rst
clk_sys,
rst_n
);
input 	slot_begin;
output 	slot_rdy;
input [1:0]	mode_numDev;
input [7:0]	dev_id;
input [7:0]	cmd_retry;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------



wire cmd_re;
assign cmd_re = cmd_retry[0] & cmd_retry[1];


wire slot_rdy  = 1'b0;

endmodule


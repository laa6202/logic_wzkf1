//commu_push.v

module commu_push(
fire_push,
done_push,
//data path
buf_rd,
buf_q,
buf_frm,
fire_tx,
done_tx,
data_tx,
//clk rst
clk_sys,
rst_n
);
input		fire_push;
output	done_push;
//data path
output buf_rd;
output buf_frm;
input [7:0]	buf_q;
output				fire_tx;
input					done_tx;
output [15:0]	data_tx;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------



endmodule


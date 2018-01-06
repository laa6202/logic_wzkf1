//commu_mux.v

module commu_mux(
fire_tx_head,
done_tx_head,
data_tx_head,
fire_tx_push,
done_tx_push,
data_tx_push,
fire_tx_tail,
done_tx_tail,
data_tx_tail,
fire_tx,
done_tx,
data_tx,
//clk rst
clk_sys,
rst_n
);
input 			fire_tx_head;
output			done_tx_head;
input [15:0]data_tx_head;
input 			fire_tx_push;
output			done_tx_push;
input [15:0]data_tx_push;
input 			fire_tx_tail;
output			done_tx_tail;
input [15:0]data_tx_tail;
output			fire_tx;
input 			done_tx;
output[15:0]data_tx;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------

wire done_tx_head;
wire done_tx_push;
wire done_tx_tail;
assign done_tx_head = done_tx;
assign done_tx_push = done_tx;
assign done_tx_tail = done_tx;

wire fire_tx;
assign fire_tx = fire_tx_head | fire_tx_push | fire_tx_tail;
wire [15:0] data_tx;
assign data_tx = data_tx_head | data_tx_push | data_tx_tail;

endmodule


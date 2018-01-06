//commu_tail.v

module commu_tail(
fire_tail,
done_tail,
//data path
fire_tx,
done_tx,
data_tx,
//clk rst
clk_sys,
rst_n
);
input		fire_tail;
output	done_tail;
//data path
output				fire_tx;
input					done_tx;
output [15:0]	data_tx;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------



endmodule


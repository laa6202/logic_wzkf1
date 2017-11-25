//commu_top.v



module commu_top(
tx,
rx,
//configuration
tbit_fre,
tx_total,
tx_pattern,
rx_total,
now_send,
//clk rst
clk_sys,
rst_n
);
output tx;
input  rx;
//configuration
input [15:0]	tbit_fre;
input [31:0]	tx_total;
input					tx_pattern;
output[31:0]  rx_total;
output now_send;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------

wire [19:0] tbit_period;
base u_base(
.tbit_period(tbit_period),
.tbit_fre(tbit_fre)
);

tx_top u_tx_top(
.tx(tx),
//configuration
.tbit_period(tbit_period),
.tx_total(tx_total),
.tx_pattern(tx_pattern),
.now_send(now_send),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


rx_top u_rx_top(
.rx(rx),
.rx_total(rx_total),
.tbit_period(tbit_period),
.tx_pattern(tx_pattern),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


endmodule


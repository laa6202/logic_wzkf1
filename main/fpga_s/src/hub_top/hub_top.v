//hub.top.v

module hub_top(
tx_a,
re_a,
rx_a,
tx_a_local,
//clk rst
clk_sys,
rst_n
);
output tx_a;
input re_a;
input rx_a;
input tx_a_local;
//clk rst
input clk_sys;
input rst_n;
//-------------------------------------------
//-------------------------------------------

wire tx_recovry;
wire [19:0] tbit_period = 20'd20;

wire [15:0]	rx_data;
wire				rx_vld;
fetch_rx_inf u_hub_rx(
.rx(rx_a),
.tbit_period(tbit_period),
.rx_vld(rx_vld),
.rx_data(rx_data),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

commu_tx_inf u_hub_tx(
.tx(tx_recovry),
//control 
.fire_tx(rx_vld),
.done_tx(),
.data_tx(rx_data),
.tbit_period(tbit_period),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- output ----------
wire tx_a;
assign tx_a = (re_a == 1'b1) ? tx_a_local : tx_recovry;


endmodule


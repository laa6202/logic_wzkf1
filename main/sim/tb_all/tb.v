module tb;

wire mclk0;		//clk50m
wire mclk1;		//clk100m
wire mclk2;		//clk1m
wire rst_n;

clk_gen u_clk_gen(
.clk_50m(mclk0),
.clk_100m(mclk1),
.clk_1m(mclk2)
);

rst_gen u_rst_gen(
.rst_n(rst_n)
);

wire clk_sys = mclk1;

//------------ source ------------
wire tx_ctrl;
tx_ctrl_top u_tx_ctrl(
.tx_ctrl(tx_ctrl),
//configuration
.dev_id(),
.mod_id(),
.addr(),
.data(),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

//---------- DUT -----------
wire ctrl_0_1 = tx_ctrl;
wire ctrl_1_2;
wire syn_0_1;
wire syn_1_2;
top_s top_s1(
//485 line
.rx_ctrl(ctrl_0_1),
.tx_ctrl(ctrl_1_2),
.rx_syn(syn_0_1),
.tx_syn(syn_1_2),
.tx_a(),
.rx_a(),
.tx_b(),
.rx_b(),
//clk rst 
.mclk0(mclk0),
.mclk1(mclk1),
.mclk2(mclk2),
.hrst_n(rst_n)
);


top_s top_s2(
//485 line
.rx_ctrl(ctrl_1_2),
.tx_ctrl(),
.rx_syn(syn_1_2),
.tx_syn(),
.tx_a(),
.rx_a(),
.tx_b(),
.rx_b(),
//clk rst 
.mclk0(mclk0),
.mclk1(mclk1),
.mclk2(mclk2),
.hrst_n(rst_n)
);

endmodule

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


//---------- DUT -----------
top_s top_s1(
//clk rst 
.mclk0(mclk0),
.mclk1(mclk1),
.mclk2(mclk2),
.hrst_n(rst_n)
);


endmodule

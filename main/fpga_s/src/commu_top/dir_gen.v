//dir_gen.v


module dir_gen(
//data path
te_a,
re_a,
tx_a,
de_a,
tx_commu,
//clk rst
dev_id,
clk_sys,
rst_n
);
//data path
output te_a;
output re_a;
output tx_a;
input de_a;
input tx_commu;
//clk rst
input [7:0]	dev_id;
input	clk_sys;
input	rst_n;
//--------------------------------------
//--------------------------------------

wire id_error;
assign id_error = (dev_id == 8'h0) | (dev_id == 8'hff) |
									(dev_id >= 8'd20) ;

wire te_a;
wire re_a;
wire tx_a;	

assign te_a = 1'b1;
assign re_a = id_error ? 1'b0 :
							de_a ? 1'b1 : 1'b0;
assign tx_a = id_error ? 1'bz :
							de_a ? tx_commu : 1'bz;
/*
assign te_a = 1'b1;
assign re_a = 1'b0;
assign tx_a = 1'bz;
	*/					

endmodule

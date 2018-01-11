//commu_m_tp.v

module commu_m_tp(
tp_rd,
tp_q,
//configuratiuon
cfg_tp,
//clk rst
clk_sys,
rst_n
);
input					tp_rd;
output [7:0]	tp_q;
//configuratiuon
input [7:0]	cfg_tp;
//clk rst
input	clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------

reg [1:0] swift;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		swift <= 2'h0;
	else if(tp_rd)
		swift <= swift + 2'h1;
end

wire [7:0]	tp_q;
assign tp_q = (swift == 2'h0) ? 8'h55 : 
							(swift == 2'h1) ? 8'hAA : 
							(swift == 2'h2) ? 8'h5A : 
							(swift == 2'h3) ? 8'hA5 : 8'h55;


endmodule

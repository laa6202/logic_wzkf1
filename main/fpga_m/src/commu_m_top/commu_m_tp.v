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


wire [1:0]	tp_mode;
assign tp_mode = cfg_tp[1:0];


reg [7:0] swift;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		swift <= 8'h0;
	else if(tp_rd)
		swift <= swift + 8'h1;
end

wire [7:0]	tp_q;
assign tp_q = (tp_mode == 2'h1) ? 8'hff :
							(tp_mode == 2'h2) ? 8'h55 :
							(tp_mode == 2'h3) ?  swift : 8'h0;




endmodule

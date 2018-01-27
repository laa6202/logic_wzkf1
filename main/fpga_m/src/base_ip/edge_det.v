//edge_det.v

module edge_det(
din,
dr,
df,
//clk rst
clk_sys,
rst_n
);
input din;
output dr;
output df;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------

reg dreg;
always @(posedge clk_sys)	
	dreg <= din;
wire dr = (~dreg) & din;
wire df = dreg & (~din);

endmodule

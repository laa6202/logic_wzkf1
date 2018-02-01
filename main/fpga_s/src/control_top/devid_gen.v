//dev_id.v

module devid_gen(
dev_id,
//clk rst
clk_sys,
rst_n
);
output [7:0]	dev_id;
//clk rst
input	clk_sys;
input	rst_n;
//--------------------------------------
//--------------------------------------

//----------set dev id ---------
reg [7:0]	dev_id;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		dev_id <= 8'hff;
	else 
		dev_id <= 8'h1;
end


endmodule

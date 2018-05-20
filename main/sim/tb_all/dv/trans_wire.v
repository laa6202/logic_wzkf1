//trans_wire.v

module trans_wire(
din,
dout,
//clk
clk_sys
);
input  din;
output dout;
//clk
input clk_sys;
//----------------------------------------
//----------------------------------------

reg [31:0]	dbuf;
always @(posedge clk_sys)
	dbuf <= {dbuf[30:0],din};

wire dout = dbuf[31];

	
endmodule


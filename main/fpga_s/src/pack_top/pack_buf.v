//pack_buf.v


module pack_buf(
//data path input
dp_data,
dp_vld,
dp_utc,
dp_ns,
//clk rst
clk_sys,
rst_n
);
//data path output
input [23:0]	dp_data;
input					dp_vld;
input [31:0]	dp_utc;
input [31:0]	dp_ns;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------


reg dp_vld_reg;
always @(posedge clk_sys)	
	dp_vld_reg <= dp_vld;
wire dp_vld_rasing = (~dp_vld_reg) & dp_vld;
wire wren_x = dp_vld_rasing;
reg  wren_y,wren_z;
always @ (posedge clk_sys) begin
	wren_y <= wren_x;
	wren_z <= wren_y;
end


wire [11:0] waddr = 12'h0;

ram32x4k dram_pkX(
.clock(clk_sys),
.data({8'h0,dp_data}),
.rdaddress(),
.wraddress(waddr),
.wren(wren_x),
.q()
);
ram32x4k dram_pkY(
.clock(clk_sys),
.data({8'h0,dp_data}),
.rdaddress(),
.wraddress(waddr),
.wren(wren_y),
.q()
);
ram32x4k dram_pkZ(
.clock(clk_sys),
.data({8'h0,dp_data}),
.rdaddress(),
.wraddress(waddr),
.wren(wren_z),
.q()
);
ram32x4k dram_pkUTC(
.clock(clk_sys),
.data(dp_utc),
.rdaddress(),
.wraddress(waddr),
.wren(wren_x),
.q()
);
ram32x4k dram_pkNS(
.clock(clk_sys),
.data(dp_ns),
.rdaddress(),
.wraddress(waddr),
.wren(wren_x),
.q()
);



endmodule

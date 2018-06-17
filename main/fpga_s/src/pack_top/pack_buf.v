//pack_buf.v


module pack_buf(
//data path input
dp_data,
dp_vld,
dp_utc,
dp_ns,
//data path output
buf_waddr,
buf_raddr,
q_x,
q_y,
q_z,
q_utc,
q_ns,
//clk rst
syn_vld,
clk_sys,
rst_n
);
//data path input
input [23:0]	dp_data;
input					dp_vld;
input [31:0]	dp_utc;
input [31:0]	dp_ns;
//data path output
output [11:0]	buf_waddr;
input	 [11:0]	buf_raddr;
output [31:0]	q_x;
output [31:0]	q_y;
output [31:0]	q_z;
output [31:0]	q_utc;
output [31:0]	q_ns;
//clk rst
input syn_vld;
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------


reg dp_vld_reg;
always @(posedge clk_sys)	
	dp_vld_reg <= dp_vld;
wire dp_vld_rasing = (~dp_vld_reg) & dp_vld;
wire dp_vld_falling = dp_vld_reg & (~dp_vld);
wire wren_x = dp_vld_rasing;
reg  wren_y,wren_z;
always @ (posedge clk_sys) begin
	wren_y <= wren_x;
	wren_z <= wren_y;
end

/*
reg [11:0] waddr;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		waddr <= 12'h0;
	else if(dp_vld_falling)	begin
		if(waddr == 12'd3999)
			waddr <= 12'h0;
		else 
			waddr <= waddr + 12'h1;
	end
	else ;
end
*/
// only handle 2000 sample rate
reg [11:0] waddr;
reg whit_chip;
always @ (posedge clk_sys or negedge rst_n)begin
	if(~rst_n)
		whit_chip <= 1'b0;
	else if(syn_vld)
		whit_chip <= ~whit_chip;
	else ;
end
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		waddr <= 12'h0;
	else if(syn_vld)
		waddr <= {whit_chip,11'b0};
	else if(dp_vld_falling)	
		waddr <= waddr + 12'h1;
	else ;
end
		
		
		

wire [11:0]	raddr = buf_raddr; 
ram32x4k dram_pkX(
.clock(clk_sys),
.data({8'h0,dp_data}),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_x),
.q(q_x)
);
ram32x4k dram_pkY(
.clock(clk_sys),
.data({8'h0,dp_data}),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_y),
.q(q_y)
);
ram32x4k dram_pkZ(
.clock(clk_sys),
.data({8'h0,dp_data}),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_z),
.q(q_z)
);
ram32x4k dram_pkUTC(
.clock(clk_sys),
.data(dp_utc),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_x),
.q(q_utc)
);
ram32x4k dram_pkNS(
.clock(clk_sys),
.data(dp_ns),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_x),
.q(q_ns)
);

wire [11:0]	buf_waddr;
assign buf_waddr = waddr;

endmodule

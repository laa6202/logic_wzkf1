//bm_buf.v

module bm_buf(
bm_data,
bm_vld,
bm_q,
bm_req,
//clk rst
clk_sys,
rst_n
);
input [31:0]	bm_data;
input					bm_vld;
output [7:0]	bm_q;
input					bm_req;
//clk rst
input	clk_sys;
input	rst_n;
//---------------------------------------
//---------------------------------------


//--------- buf bm -------
wire [7:0]	data;
reg [14:0]	waddr;
wire 				wren;
reg [14:0]	raddr;
wire [7:0]	q;
ram8x32k u_buf_bm(
.clock(clk_sys),
.data(data),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren),
.q(q)
);
	
	

//--------- write path --------
reg [3:0] vld_reg;
reg [31:0]	data_reg;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		vld_reg <= 4'h0;
	else 
		vld_reg <= {vld_reg[2:0],bm_vld};
end
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		data_reg <= 32'h0;
	else if(bm_vld)
		data_reg <= bm_data;
	else ;
end
assign wren = |vld_reg;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		waddr <= 15'h0;
	else if(wren)
		waddr <= waddr + 15'h1;
	else ;
end
assign data = vld_reg[0] ? bm_data[31:24] :
							vld_reg[1] ? bm_data[23:16] :
							vld_reg[2] ? bm_data[15:8] :
							vld_reg[3] ? bm_data[7:0] : 8'h0;

							
//---------- read path ---------
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		raddr <= 15'h0;
	else if(bm_req)
		raddr <= (raddr != waddr) ? (raddr + 15'h1) : raddr;
	else;
end
wire [7:0] bm_q = q;


endmodule

//commu_buf.v


module commu_buf(
//data path
pk_data,
pk_vld,
pk_frm,
buf_rd,
buf_q,
buf_frm,
//parmeter 
len_pkg,
//clk rst
clk_sys,
rst_n
);
//data path
input [7:0]	pk_data;
input				pk_vld;
input				pk_frm;
input buf_rd;
input buf_frm;
output [7:0]	buf_q;
//parmeter 
input [15:0]	len_pkg;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------


//--------- write path -----------
reg [14:0]	cnt_buf;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_buf <= 15'h0;
	else if(~pk_frm)
		cnt_buf <= 15'h0;
	else if(pk_frm & pk_vld)
		cnt_buf <= cnt_buf + 15'h1;
	else ;
end


wire [14:0] waddr = cnt_buf;
wire				wren = pk_frm & pk_vld;
wire [14:0] raddr;
wire [7:0]	q;
ram8x32k u_ram8x32k(
.clock(clk_sys),
.data(pk_data),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren),
.q(q)
);


//----------- read path --------
reg [14:0]	cnt_rd;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_rd <= 15'h0;
	else if(~buf_frm)
		cnt_rd <= 15'h0;
	else if(buf_frm & buf_rd)
		cnt_rd <= cnt_rd + 15'h1;
	else ;
end

assign raddr = cnt_rd;
assign buf_q = q;

endmodule

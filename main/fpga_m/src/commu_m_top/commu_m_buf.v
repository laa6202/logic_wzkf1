//commu_m_buf.v

module commu_m_buf(
//pkg data
repk_data,
repk_vld,
repk_frm,
//read path
buf_rd,
buf_frm,
buf_q,
//status 
cnt_pkg_buf,
//clk rst
clk_sys,
rst_n
);
//pkg data
input [15:0]	repk_data;
input					repk_vld;
input					repk_frm;
//read path
input 				buf_rd;
input 				buf_frm;
output [7:0]	buf_q;
//status 
output [3:0] cnt_pkg_buf;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------


//--------- prepare ---------
reg repk_frm_reg;
always @ (posedge clk_sys)
	repk_frm_reg <= repk_frm;
wire repk_frm_falling = (~repk_frm) & repk_frm_reg;
reg [7:0] repk_frm_falling_dly;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		repk_frm_falling_dly <= 8'h0;
	else 
		repk_frm_falling_dly <= {repk_frm_falling_dly[6:0],repk_frm_falling};
end
	
wire repk_frm_ok/*synthesis keep*/;
assign repk_frm_ok = repk_frm_falling_dly[7];
	
reg[2:0] whit_chip;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		whit_chip <= 3'b0;
	else if(repk_frm_ok)	begin
//		if(whit_chip == 2'h2)
//			whit_chip <= 2'h0;
//		else 
			whit_chip <= whit_chip + 3'h1;
	end else ;
end
		



//----------- ram for buf ----------
wire [7:0] 	wdata;
reg  [14:0] waddr;
wire				wren_0;
wire				wren_1;
wire				wren_2;
wire				wren_3;
wire				wren_4;
wire				wren_5;
wire				wren_6;
wire				wren_7;
reg  [14:0] raddr;
wire [7:0]	q_0;
wire [7:0]	q_1;
wire [7:0]	q_2;
wire [7:0]	q_3;
wire [7:0]	q_4;
wire [7:0]	q_5;
wire [7:0]	q_6;
wire [7:0]	q_7;
ram8x32k u_ram8x32k_0(
.clock(clk_sys),
.data(wdata),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_0),
.q(q_0)
);
ram8x32k u_ram8x32k_1(
.clock(clk_sys),
.data(wdata),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_1),
.q(q_1)
);
ram8x32k u_ram8x32k_2(
.clock(clk_sys),
.data(wdata),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_2),
.q(q_2)
);
ram8x32k u_ram8x32k_3(
.clock(clk_sys),
.data(wdata),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_3),
.q(q_3)
);
ram8x32k u_ram8x32k_4(
.clock(clk_sys),
.data(wdata),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_4),
.q(q_4)
);
ram8x32k u_ram8x32k_5(
.clock(clk_sys),
.data(wdata),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_5),
.q(q_5)
);
ram8x32k u_ram8x32k_6(
.clock(clk_sys),
.data(wdata),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_6),
.q(q_6)
);
ram8x32k u_ram8x32k_7(
.clock(clk_sys),
.data(wdata),
.rdaddress(raddr),
.wraddress(waddr),
.wren(wren_7),
.q(q_7)
);

//---------- write path ----------
wire wd_wr;
reg [7:0] repk_vld_reg;
always @(posedge clk_sys)
	repk_vld_reg <= repk_vld;
wire wren = repk_vld | repk_vld_reg;

assign wren_0 = (whit_chip[2:0] == 3'h0) & wren;
assign wren_1 = (whit_chip[2:0] == 3'h1) & wren;
assign wren_2 = (whit_chip[2:0] == 3'h2) & wren;
assign wren_3 = (whit_chip[2:0] == 3'h3) & wren;
assign wren_4 = (whit_chip[2:0] == 3'h4) & wren;
assign wren_5 = (whit_chip[2:0] == 3'h5) & wren;
assign wren_6 = (whit_chip[2:0] == 3'h6) & wren;
assign wren_7 = (whit_chip[2:0] == 3'h7) & wren;
/*
assign wren_0 = (whit_chip[1:0] == 2'h0) & wren;
assign wren_1 = (whit_chip[1:0] == 2'h1) & wren;
assign wren_2 = (whit_chip[1:0] == 2'h2) & wren;
assign wren_3 = (whit_chip[1:0] == 2'h3) & wren;
*/
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		waddr <= 15'h0;
	else if(wren)
		waddr <= waddr + 15'h1;
	else if(~repk_frm)
		waddr <= 15'h0;
	else if(wd_wr)
		waddr <= 15'h0;
	else ;
end
assign wdata = 	repk_vld ? repk_data[15:8] :
								repk_vld_reg ? repk_data[7:0] : 8'h0;


//---------- read path ----------
wire wd_rd;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		raddr <= 15'h0;
	else if(buf_rd)
		raddr <= raddr + 15'h1;
	else if(~buf_frm)
		raddr <= 15'h0;
	else if(wd_rd)
		raddr <= 15'h0;
	else ;
end

reg buf_frm_reg;
always @ (posedge clk_sys) buf_frm_reg <= buf_frm;
wire buf_frm_falling/*synthesis keep*/;
assign buf_frm_falling = (buf_frm_reg) & (~buf_frm);
wire buf_frm_rasing = (~buf_frm_reg) & (buf_frm);	


reg[2:0] read_chip;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		read_chip <= 3'b0;
	else if(buf_frm_falling) begin
//		if(read_chip == 2'h2)
//			read_chip <= 2'h0;
//		else 
			read_chip <= read_chip + 3'h1;
	//else if()  //强制转换
	end else ;
end


reg [3:0] cnt_pkg_buf;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_pkg_buf <= 4'h0;
	else if(repk_frm_ok) begin
		cnt_pkg_buf <= (cnt_pkg_buf != 4'h7) ? (cnt_pkg_buf + 4'h1) : 4'h7;
	end
	else if(buf_frm_rasing)	begin
		cnt_pkg_buf <= (cnt_pkg_buf != 4'h0) ? (cnt_pkg_buf - 4'h1) : 4'h0;
	end
	else ;
end


wire [7:0] buf_q;
assign buf_q = 	(read_chip[2:0] == 3'h0) ? q_0 : 
								(read_chip[2:0] == 3'h1) ? q_1 : 
								(read_chip[2:0] == 3'h2) ? q_2 : 
								(read_chip[2:0] == 3'h3) ? q_3 : 
								(read_chip[2:0] == 3'h4) ? q_4 : 
								(read_chip[2:0] == 3'h5) ? q_5 : 
								(read_chip[2:0] == 3'h6) ? q_6 : 
								(read_chip[2:0] == 3'h7) ? q_7 : 8'h0;

/*
assign buf_q = 	(read_chip[1:0] == 2'h0) ? q_0 : 
								(read_chip[1:0] == 2'h1) ? q_1 : 
								(read_chip[1:0] == 2'h2) ? q_2 : 
								(read_chip[1:0] == 2'h3) ? q_3 : 8'h0;
*/


//---------- wd ----------
assign wd_wr = 1'b0;
assign wd_rd = 1'b0;
/*
reg [31:0] cnt_wr;
reg [31:0] cnt_rd;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_wr <= 32'h0;
	else 

*/



endmodule

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
	
reg[3:0] whit_chip;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		whit_chip <= 3'b0;
	else if(repk_frm_falling_dly[7])	begin
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
reg  [14:0] raddr;
wire [7:0]	q_0;
wire [7:0]	q_1;
wire [7:0]	q_2;
wire [7:0]	q_d;
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
.q(q_d)
);

//---------- write path ----------
wire wd_wr;
reg [7:0] repk_vld_reg;
always @(posedge clk_sys)
	repk_vld_reg <= repk_vld;
wire wren = repk_vld | repk_vld_reg;
assign wren_0 = (whit_chip[1:0] == 2'h0) & wren;
assign wren_1 = (whit_chip[1:0] == 2'h1) & wren;
assign wren_2 = (whit_chip[1:0] == 2'h2) & wren;
assign wren_3 = (whit_chip[1:0] == 2'h3) & wren;
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
wire buf_frm_falling = (buf_frm_reg) & (~buf_frm);
		


reg[1:0] read_chip;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		read_chip <= 2'b0;
	else if(buf_frm_falling) begin
//		if(read_chip == 2'h2)
//			read_chip <= 2'h0;
//		else 
			read_chip <= read_chip + 2'h1;
	//else if()  //强制转换
	end else ;
end


wire [7:0] buf_q;
assign buf_q = 	(read_chip[1:0] == 2'h0) ? q_0 : 
								(read_chip[1:0] == 2'h1) ? q_1 : 
								(read_chip[1:0] == 2'h2) ? q_2 : 
								(read_chip[1:0] == 2'h3) ? q_d : 8'h0;


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

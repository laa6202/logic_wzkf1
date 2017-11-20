//commu_top.v

//`define TX_FEQ  16'd10000		//10Mbps
//`define TX_FEQ  16'd5000		//5Mbps
//`define TX_FEQ  16'd2000		//5Mbps
//`define TX_FEQ  16'd1000		//1Mbps
//`define TX_FEQ  16'd500			//500kbps
//`define TX_FEQ  16'd100			//100kbps
//`define TX_FEQ  16'd50		 	//50kbps
//`define TX_FEQ  16'd10		 	//10kbps
//`define TX_FEQ  16'd1			  //1kbps
`define TX_FEQ  		32'd10000
`define TX_COUNT		32'd10

module commu_top(
tx,
rx,
//clk rst
clk_sys,
rst_n
);
output tx;
input  rx;

//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------

wire [15:0] tbit_fre = `TX_FEQ;
wire [19:0] tbit_period;
wire [31:0] tx_total = `TX_COUNT;
assign tbit_period =(tbit_fre == 16'd10000) ? 20'd10 :
										(tbit_fre == 16'd5000) ? 20'd20 :
										(tbit_fre == 16'd2000) ? 20'd50 :
										(tbit_fre == 16'd1000) ? 20'd100 :
										(tbit_fre == 16'd500) ? 20'd200 :
										(tbit_fre == 16'd100) ? 20'd1000 :
										(tbit_fre == 16'd50) ? 20'd2000 :
										(tbit_fre == 16'd10) ? 20'd10000 :
										(tbit_fre == 16'd1) ? 20'd100000 : 20'd10;

reg [31:0] cnt_tx;
wire tbit_vld;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_tx <= 32'h0;
	else if(tbit_vld)
		cnt_tx <= cnt_tx + 32'h1;
	else ;
end
										
reg [19:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 20'h0;
	else if(cnt_cycle == tbit_period)
		cnt_cycle <= 20'h1;
	else if(cnt_tx < tx_total)
		cnt_cycle <= cnt_cycle + 20'h1;
	else ;
end

assign tbit_vld =  (cnt_cycle == tbit_period) ? 1'b1 : 1'b0;

reg tx;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		tx <= 1'b1;
	else if(tbit_vld)
		tx <= ~tx;
	else ;
end
										
endmodule


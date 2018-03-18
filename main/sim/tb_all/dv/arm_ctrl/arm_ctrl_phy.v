//arm_ctrl_phy.v

`define NO_CSN



module arm_ctrl_phy(
fire_cspi,
done_cspi,
//cspi interface
cspi_csn,
cspi_sck,
cspi_miso,
cspi_mosi,
//data path
set_data,
set_vld,
get_q,
get_vld,
//clk rst
clk_sys,
rst_n
);
input		fire_cspi;
output	done_cspi;
//cspi interface
output cspi_csn;
output cspi_sck;
input  cspi_miso;
output cspi_mosi;
//configuration
input [7:0]	set_data;
input				set_vld;
output[7:0]	get_q;
output 			get_vld;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------
//-----------------------------------


//------------ mian FSM ------------
parameter S_IDLE = 3'h0;
parameter S_BIT  = 3'h1;
parameter S_LOW  = 3'h2;
parameter S_HIGH = 3'h3;
parameter S_CHECK= 3'h4;
parameter S_DELAY= 3'h5;
parameter S_DONE = 3'h7;
reg [2:0] st_actrl_phy;
wire finish_low;
wire finish_high;
wire finish_byte;
wire finish_delay;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)	
		st_actrl_phy <= S_IDLE;
	else begin
		case(st_actrl_phy)
			S_IDLE : st_actrl_phy <= fire_cspi ? S_BIT : S_IDLE;
			S_BIT  : st_actrl_phy <= S_LOW;
			S_LOW  : st_actrl_phy <= finish_low ? S_HIGH : S_LOW;
			S_HIGH : st_actrl_phy <= finish_high ? S_CHECK : S_HIGH;
			S_CHECK: st_actrl_phy <= finish_byte ? S_DELAY : S_BIT;
			S_DELAY: st_actrl_phy <= finish_delay ? S_DONE : S_DELAY;
			S_DONE : st_actrl_phy <= S_IDLE;
			default :st_actrl_phy <= S_IDLE;
		endcase
	end
end


//----------- FSM switch condition ---------
reg [7:0] cnt_low;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_low <= 8'h0;
	else if(st_actrl_phy == S_LOW)
		cnt_low <= cnt_low + 8'h1;
	else 
		cnt_low <= 8'h0;
end
assign finish_low = (cnt_low == 8'h9) ? 1'b1 : 1'b0;

reg [7:0] cnt_high;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_high <= 8'h0;
	else if(st_actrl_phy == S_HIGH)
		cnt_high <= cnt_high + 8'h1;
	else 
		cnt_high <= 8'h0;
end
assign finish_high = (cnt_high == 8'h9) ? 1'b1 : 1'b0;

reg [3:0] cnt_bits;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_bits <= 4'h0;
	else if(st_actrl_phy == S_CHECK)
		cnt_bits <= cnt_bits + 4'h1;
	else if(st_actrl_phy == S_DONE)
		cnt_bits <= 4'h0;
	else ;
end
assign finish_byte = (cnt_bits == 4'h7) ? 1'b1 : 1'b0;

reg [7:0] cnt_delay;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_delay <= 8'h0;
	else if(st_actrl_phy == S_DELAY)
		cnt_delay <= cnt_delay + 8'h1;
	else 
		cnt_delay <= 8'h0;
end
assign finish_delay = (cnt_delay == 8'h40) ? 1'b1 : 1'b0;


//---------- control signal -----
wire done_cspi = (st_actrl_phy == S_DONE) ? 1'b1 : 1'b0;

	
//--------- output spi bus --------
`ifndef NO_CSN
wire cspi_csn = (st_actrl_phy == S_IDLE) | (st_actrl_phy == S_DELAY) |
								(st_actrl_phy == S_DONE);
`else
wire cspi_csn	= 1'b1;
`endif

wire cspi_sck = (st_actrl_phy != S_BIT) & (st_actrl_phy != S_LOW);

reg [7:0] lock_set;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		lock_set <= 8'h0;
	else if(set_vld)
		lock_set <= set_data;
	else if(st_actrl_phy == S_CHECK)
		lock_set <= {lock_set[6:0],1'b0};
	else ;
end
wire cspi_mosi = lock_set[7];


//------------ get data to mac -------
reg [7:0] lock_get;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		lock_get <= 8'h0;
	else if(finish_low)
		lock_get <= {lock_get[6:0],cspi_miso};
	else ;
end
wire get_vld = (st_actrl_phy == S_DONE) ? 1'b1 : 1'b0;
wire [7:0] get_q = lock_get;
	

endmodule

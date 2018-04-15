//fetch_rx_inf.v

module fetch_rx_inf(
rx,
tbit_period,
rx_vld,
rx_data,
//clk rst
clk_sys,
rst_n
);
input 				rx;
input  [19:0]	tbit_period;
output 				rx_vld;
output [15:0]	rx_data;
//clk rst
input clk_sys;
input rst_n;

//----------------------------------
//----------------------------------

//--------- rx prepare ---------
reg [7:0]	rx_reg;
always @ (posedge clk_sys) 
	rx_reg <= {rx_reg[6:0],rx};

reg rx_real;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_real <= rx;	//maybe 0 or 1
	else if(rx_reg == 8'hff)
		rx_real <= 1'b1;
	else if(rx_reg == 8'h0)
		rx_real <= 1'b0;
	else ;
end
reg rx_real_reg;
always @(posedge clk_sys)
	rx_real_reg <= rx_real;


//---------- main FSM ----------
parameter S_IDLE = 5'h0;
parameter S_START = 5'h1;
parameter S_S7 = 5'h2;
parameter S_S6 = 5'h3;
parameter S_S5 = 5'h4;
parameter S_S4 = 5'h5;
parameter S_S3 = 5'h6;
parameter S_S2 = 5'h7;
parameter S_S1 = 5'h8;
parameter S_S0 = 5'h9;
parameter S_STOP = 5'ha;
parameter S_DONE = 5'hf;
parameter S_S15 = 5'h12;
parameter S_S14 = 5'h13;
parameter S_S13 = 5'h14;
parameter S_S12 = 5'h15;
parameter S_S11 = 5'h16;
parameter S_S10 = 5'h17;
parameter S_S9 = 5'h18;
parameter S_S8 = 5'h19;
reg [4:0] st_rx_phy;
wire rx_falling;
wire finish_bit;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_rx_phy <= S_IDLE;
	else begin
		case (st_rx_phy)
			S_IDLE : st_rx_phy <= rx_falling ? S_START : S_IDLE;
			S_START: st_rx_phy <= finish_bit ? S_S15 : S_START;
			S_S15	 : st_rx_phy <= finish_bit ? S_S14 : S_S15;
			S_S14	 : st_rx_phy <= finish_bit ? S_S13 : S_S14;
			S_S13	 : st_rx_phy <= finish_bit ? S_S12 : S_S13;
			S_S12	 : st_rx_phy <= finish_bit ? S_S11 : S_S12;
			S_S11	 : st_rx_phy <= finish_bit ? S_S10 : S_S11;
			S_S10	 : st_rx_phy <= finish_bit ? S_S9 : S_S10;
			S_S9	 : st_rx_phy <= finish_bit ? S_S8 : S_S9;
			S_S8	 : st_rx_phy <= finish_bit ? S_S7 : S_S8;
			S_S7	 : st_rx_phy <= finish_bit ? S_S6 : S_S7;
			S_S6	 : st_rx_phy <= finish_bit ? S_S5 : S_S6;
			S_S5	 : st_rx_phy <= finish_bit ? S_S4 : S_S5;
			S_S4	 : st_rx_phy <= finish_bit ? S_S3 : S_S4;
			S_S3	 : st_rx_phy <= finish_bit ? S_S2 : S_S3;
			S_S2	 : st_rx_phy <= finish_bit ? S_S1 : S_S2;
			S_S1	 : st_rx_phy <= finish_bit ? S_S0 : S_S1;
			S_S0	 : st_rx_phy <= finish_bit ? S_STOP : S_S0;
			S_STOP : st_rx_phy <= finish_bit ? S_DONE : S_STOP;
			S_DONE : st_rx_phy <= S_IDLE;
			default : st_rx_phy <= S_IDLE;
		endcase
	end
end
wire send_bit = (st_rx_phy != S_IDLE) & (st_rx_phy != S_DONE);


//--------- FSM finish_bit ----------
assign rx_falling = (~rx_real) & rx_real_reg;

reg [19:0] cnt_cycle;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 20'h0;
	else if(cnt_cycle == (tbit_period - 20'h1))
		cnt_cycle <= 20'h0;
	else if(send_bit)
		cnt_cycle <= cnt_cycle + 20'h1;
	else 
		cnt_cycle <= 20'h0;
end
assign finish_bit = (cnt_cycle == (tbit_period - 20'h1)) ? 1'b1 : 1'b0;


//--------- rx data -----------
wire [19:0] point_get = {1'b0,tbit_period[19:1]} - 20'h1;
reg [15:0] rx_data_int;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_data_int <= 16'h0;
	else if(cnt_cycle == point_get)	begin
		case(st_rx_phy)
			S_S15 : rx_data_int[15] <= rx_real;
			S_S14 : rx_data_int[14] <= rx_real;
			S_S13 : rx_data_int[13] <= rx_real;
			S_S12 : rx_data_int[12] <= rx_real;
			S_S11 : rx_data_int[11] <= rx_real;
			S_S10 : rx_data_int[10] <= rx_real;
			S_S9 : rx_data_int[9] <= rx_real;
			S_S8 : rx_data_int[8] <= rx_real;	
			S_S7 : rx_data_int[7] <= rx_real;
			S_S6 : rx_data_int[6] <= rx_real;
			S_S5 : rx_data_int[5] <= rx_real;
			S_S4 : rx_data_int[4] <= rx_real;
			S_S3 : rx_data_int[3] <= rx_real;
			S_S2 : rx_data_int[2] <= rx_real;
			S_S1 : rx_data_int[1] <= rx_real;
			S_S0 : rx_data_int[0] <= rx_real;			
			default : ;
		endcase
	end
	else ;
end

reg [15:0] rx_data;
reg rx_vld;
always @ (posedge clk_sys)	
	rx_vld <= (st_rx_phy == S_DONE) ? 1'b1 : 1'b0;
	
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_data <= 16'h0;
	else if(st_rx_phy == S_DONE)
		rx_data <= rx_data_int;
	else ;
end


endmodule


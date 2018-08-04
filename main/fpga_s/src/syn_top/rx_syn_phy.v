//rx_ctrl_phy.v

module rx_syn_phy(
rx,
tbit_period,
syn_vld,
rx_vld,
rx_data,
//clk rst
clk_sys,
clk_slow,
rst_n
);
input 				rx;
input  [19:0]	tbit_period;
output				syn_vld;
output 				rx_vld;
output [7:0]	rx_data;
//clk rst
input clk_sys;
input clk_slow;
input rst_n;

//----------------------------------
//----------------------------------

//--------- rx prepare ---------
reg [3:0]	rx_reg;
always @ (posedge clk_slow) 
	rx_reg <= {rx_reg[2:0],rx};

reg rx_real;
always @ (posedge clk_slow or negedge rst_n)	begin
	if(~rst_n)
		rx_real <= 1'b1;
	else if(rx_reg == 4'hf)
		rx_real <= 1'b1;
	else if(rx_reg == 4'h0)
		rx_real <= 1'b0;
	else ;
end



//wire rx_real = rx;

reg[1:0] rx_real_reg;
always @(posedge clk_sys)
	rx_real_reg <= {rx_real_reg[0],rx_real};


//---------- main FSM ----------
parameter S_IDLE = 4'h0;
parameter S_START = 4'h1;
parameter S_S7 = 4'h2;
parameter S_S6 = 4'h3;
parameter S_S5 = 4'h4;
parameter S_S4 = 4'h5;
parameter S_S3 = 4'h6;
parameter S_S2 = 4'h7;
parameter S_S1 = 4'h8;
parameter S_S0 = 4'h9;
parameter S_STOP = 4'ha;
parameter S_STOP2 = 4'hb;
parameter S_DONE = 4'hf;
reg [3:0] st_rx_phy;
wire rx_f;
wire finish_bit;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_rx_phy <= S_IDLE;
	else begin
		case (st_rx_phy)
			S_IDLE : st_rx_phy <= rx_f ? S_START : S_IDLE;
			S_START: st_rx_phy <= finish_bit ? S_S7 : S_START;
			S_S7	 : st_rx_phy <= finish_bit ? S_S6 : S_S7;
			S_S6	 : st_rx_phy <= finish_bit ? S_S5 : S_S6;
			S_S5	 : st_rx_phy <= finish_bit ? S_S4 : S_S5;
			S_S4	 : st_rx_phy <= finish_bit ? S_S3 : S_S4;
			S_S3	 : st_rx_phy <= finish_bit ? S_S2 : S_S3;
			S_S2	 : st_rx_phy <= finish_bit ? S_S1 : S_S2;
			S_S1	 : st_rx_phy <= finish_bit ? S_S0 : S_S1;
			S_S0	 : st_rx_phy <= finish_bit ? S_STOP : S_S0;
			S_STOP : st_rx_phy <= finish_bit ? S_STOP2 : S_STOP;
			S_STOP2: st_rx_phy <= finish_bit ? S_DONE : S_STOP2;
			S_DONE : st_rx_phy <= S_IDLE;
			default : st_rx_phy <= S_IDLE;
		endcase
	end
end
wire send_bit = (st_rx_phy != S_IDLE) & (st_rx_phy != S_DONE);


//--------- FSM finish_bit ----------
assign rx_f = (~rx_real_reg[0]) & rx_real_reg[1];


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
reg [7:0] rx_data_int;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_data_int <= 8'h0;
	else if(cnt_cycle == point_get)	begin
		case(st_rx_phy)
			S_S7 : rx_data_int[7] <= rx_real_reg[0];
			S_S6 : rx_data_int[6] <= rx_real_reg[0];
			S_S5 : rx_data_int[5] <= rx_real_reg[0];
			S_S4 : rx_data_int[4] <= rx_real_reg[0];
			S_S3 : rx_data_int[3] <= rx_real_reg[0];
			S_S2 : rx_data_int[2] <= rx_real_reg[0];
			S_S1 : rx_data_int[1] <= rx_real_reg[0];
			S_S0 : rx_data_int[0] <= rx_real_reg[0];			
			default : ;
		endcase
	end
	else ;
end

reg stop_bit;
always @ (posedge clk_sys or negedge rst_n) begin
	if(~rst_n)
		stop_bit <= 1'b1;
	else if(cnt_cycle == point_get)	
		stop_bit <= (st_rx_phy == S_STOP2) ? rx_real : stop_bit;
	else ;
end
	
	
	

reg [7:0] rx_data;
reg rx_vld;
reg syn_vld;
always @ (posedge clk_sys)	
	rx_vld <= (st_rx_phy == S_DONE) ? 1'b1 : 1'b0;
	
always @ (posedge clk_sys)
	syn_vld <= (st_rx_phy == S_DONE) ? (stop_bit == 1'b0) : 1'b0;
	
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_data <= 8'h0;
	else if(st_rx_phy == S_DONE)
		rx_data <= rx_data_int;
	else ;
end


endmodule


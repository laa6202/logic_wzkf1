//led_pkg.v


module led_pkg(
led_ch_n,
//input signal
pkg_data,
pkg_vld,
pkg_frm,
//clk rst
clk_sys,
pluse_us,
rst_n
);
output [7:0]	led_ch_n;
//input signal
input [15:0]	pkg_data;
input				pkg_vld;
input				pkg_frm;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//------------------------------------
//------------------------------------


reg [1:0] st_read;
parameter S_IDLE = 2'h0;
parameter S_RDY  = 2'h1;
parameter S_TRIG = 2'h2;
parameter S_LOCK = 2'h3;
always @ (posedge clk_sys or negedge rst_n) begin
	if(~rst_n)
		st_read <= S_IDLE;
	else begin
		case(st_read)
			S_IDLE : st_read <= pkg_frm ? S_RDY : S_IDLE;
			S_RDY  : st_read <= pkg_vld ? S_TRIG : S_RDY;
			S_TRIG : st_read <= S_LOCK;
			S_LOCK : st_read <= pkg_frm ? S_LOCK : S_IDLE;
			default : st_read <= S_IDLE;
		endcase
	end
end

reg [7:0] trig_ch;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		trig_ch <= 8'h0;
	else if((st_read == S_RDY) & pkg_vld)
		trig_ch <= pkg_data[7:0];
	else ;
end


wire led_on;
wire con_led_on = (st_read == S_TRIG) && (trig_ch [2:0] != 3'h0);

reg [31:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 32'h0;
	else if(con_led_on)
		cnt_cycle <= 32'd300_000_00;
	else if(cnt_cycle != 32'h0)
		cnt_cycle <= cnt_cycle - 32'h1;
	else ;
end
assign led_on = (cnt_cycle != 32'h0) ? 1'b1 : 1'b0;


reg [7:0] led_ch_n;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		led_ch_n <= 8'hff;
	else begin
		case(trig_ch)
			8'h1 : led_ch_n <= led_on ? 8'b1111_1110 : 8'hff;
			8'h2 : led_ch_n <= led_on ? 8'b1111_1101 : 8'hff;
			8'h3 : led_ch_n <= led_on ? 8'b1111_1011 : 8'hff;
			8'h4 : led_ch_n <= led_on ? 8'b1111_0111 : 8'hff;
			8'h5 : led_ch_n <= led_on ? 8'b1110_1111 : 8'hff;
			8'h6 : led_ch_n <= led_on ? 8'b1101_1111 : 8'hff;
			8'h7 : led_ch_n <= led_on ? 8'b1011_1111 : 8'hff;
			8'h8 : led_ch_n <= led_on ? 8'b0111_1111 : 8'hff;		
			default : led_ch_n <= 8'hff;
		endcase
	end
end



endmodule


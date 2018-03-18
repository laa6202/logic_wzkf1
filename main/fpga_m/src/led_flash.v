module led_flash(
mclk0,
hrst_n,

led1,
led2,
led3
);

input mclk0;
input hrst_n;
output led1;
output led2;
output led3;

reg [23:0] cnt;
always @(posedge mclk0 or negedge hrst_n)
if(~hrst_n)
	cnt<= 16'd0;
else
	cnt <= cnt + 16'd1;
	
assign led1 = cnt[23];
assign led2 = cnt[18];

endmodule

//ad_sample.v
//ad_sample.v

module ad_clk_gen(
//adc clk
clk_5M,
clk_2_5M, //2.5MHz
clk_2M,
clk_2kHz,
//clk rst
clk_sys,
pluse_us,
rst_n
);

output clk_5M;
output clk_2_5M;
output clk_2M;
output clk_2kHz;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//--------------------------------------------------
//--------------------------------------------------
reg [15:0]cnt_250us; 
reg [7:0]  cnt_400ns;
reg [7:0]  cnt_250ns;
reg [3:0] cnt_100ns;
wire pluse_us;	




always @(posedge clk_sys or negedge rst_n)	
begin	
	if(~rst_n)
		cnt_100ns <= 4'd0;
	else 
	begin
	   if(cnt_100ns < 4'd9)
			cnt_100ns <= cnt_100ns + 4'd1;
		else
			cnt_100ns <= 4'd0;
	end
end

	
always @(posedge clk_sys or negedge rst_n)	
begin	
	if(~rst_n)
		cnt_250us <= 16'd0;
	else if(pluse_us)
	begin
	   if(cnt_250us < 16'd249)
			cnt_250us <= cnt_250us + 16'd1;
		else
			cnt_250us <= 16'd0;
	end
end


always @(posedge clk_sys or negedge rst_n)	
begin	
	if(~rst_n)
		cnt_250ns <= 8'd0;
	else if(cnt_250ns < 8'd24)
			cnt_250ns <= cnt_250ns + 8'd1;
	else
			cnt_250ns <= 8'd0;
end

always @(posedge clk_sys or negedge rst_n)	
begin	
	if(~rst_n)
		cnt_400ns <= 8'd0;
	else if(cnt_400ns < 8'd19)
			cnt_400ns <= cnt_400ns + 8'd1;
	else
			cnt_400ns <= 8'd0;
end

reg clk_5M;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		clk_5M <= 1'b0;
	else if(cnt_100ns == 8'd0)
   	clk_5M <= ~clk_5M;
	else ;
end

//assign clk_2M = clk_2097152Hz;

reg clk_2M;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		clk_2M <= 1'b0;
	else if(cnt_250ns == 8'd0)
   	clk_2M <= ~clk_2M;
	else ;
end

reg clk_2_5M;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		clk_2_5M <= 1'b0;
	else if(cnt_400ns == 8'd0)
   	clk_2_5M <= ~clk_2_5M;
	else ;
end
		
reg clk_2kHz_reg;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		clk_2kHz_reg <= 1'b0;
	else if((pluse_us)&&(cnt_250us == 16'd0))
		clk_2kHz_reg <= ~clk_2kHz_reg;
	else ;
end


//assign ad_clk     = clk_2_5M;
assign clk_2kHz = clk_2kHz_reg;

endmodule

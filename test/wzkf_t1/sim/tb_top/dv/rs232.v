//rs232.v

module rs232(
uart_tx,
uart_rx
);
output uart_tx;
input  uart_rx;
//------------------------------------

reg uart_tx;


task send_utx;
input [7:0] tx_data;
reg xor_tx;
begin
				xor_tx <= ^tx_data;
				uart_tx <= 1'b1;		//idle
#86.8		uart_tx <= 1'b0;		//start
#86.8		uart_tx <= tx_data[0];		//bit0
#86.8		uart_tx <= tx_data[1];		//bit1
#86.8		uart_tx <= tx_data[2];		//bit2
#86.8		uart_tx <= tx_data[3];		//bit3
#86.8		uart_tx <= tx_data[4];		//bit4
#86.8		uart_tx <= tx_data[5];		//bit5
#86.8		uart_tx <= tx_data[6];		//bit6
#86.8		uart_tx <= tx_data[7];		//bit7
#86.8		uart_tx <= 1'b1;	//xor_tx;		// no bit xor
#86.8		uart_tx <= 1'b1;		//stop
#86.8		uart_tx <= 1'b1;		//idle
end
endtask



initial begin
				uart_tx <= 1'b1;
//iic devid = 0x42
#700		send_utx(8'h82);
#200		send_utx(8'h00);
#200		send_utx(8'h02);
#200		send_utx(8'h42);
//iic addr = 0x30
#500		send_utx(8'h82);
#200		send_utx(8'h00);
#200		send_utx(8'h03);
#200		send_utx(8'h20);
//iic wdata = 0x55
#500		send_utx(8'h82);
#200		send_utx(8'h00);
#200		send_utx(8'h04);
#200		send_utx(8'h55);
//iic action write
#500		send_utx(8'h82);
#200		send_utx(8'h00);
#200		send_utx(8'h06);
#200		send_utx(8'h03);
end



endmodule


/*
//backup for rs232 core op
initial begin
				uart_tx <= 1'b1;
#700		send_utx(8'h02);
#200		send_utx(8'h00);
#200		send_utx(8'h85);
#200		send_utx(8'h00);

end

*/
//pack_tail.v


module pack_tail(
fire_tail,
done_tail,
//data path
tail_data,
tail_vld,
//clk rst
clk_sys,
rst_n
);
input		fire_tail;
output	done_tail;
//data path
output [7:0]	tail_data;
output				tail_vld;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------


//----------- main FSM ---------
parameter S_IDLE = 3'h0;
parameter S_PREP = 3'h1;
parameter S_DONE = 3'h7;
reg [2:0] st_pack_tail;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_pack_tail <= S_IDLE;
	else begin
		case(st_pack_tail)
			S_IDLE : st_pack_tail <= fire_tail ? S_PREP : S_IDLE ;
			S_PREP : st_pack_tail <= S_DONE;
			S_DONE : st_pack_tail <= S_IDLE;
			default : st_pack_tail <= S_IDLE;
		endcase
	end
end


//---------- control signal -----------
wire done_tail = (st_pack_tail == S_DONE) ? 1'b1 : 1'b0;


//---------- data output ------------
wire [7:0] 	tail_data = 8'h0;
wire 				tail_vld = 1'b0;

endmodule


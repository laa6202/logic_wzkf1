//pack_main.v


module pack_main(
fire_head,
fire_load,
fire_tail,
done_head,
done_load,
done_tail,
pk_frm,
//configuration
cfg_pkg_en,
//clk rst
utc_sec,
clk_sys,
rst_n
);
output	fire_head;
output	fire_load;
output	fire_tail;
input 	done_head;
input 	done_load;
input 	done_tail;
output	pk_frm;
//configuration
input [7:0] cfg_pkg_en;
//clk rst
input [31:0]	utc_sec;
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------


wire pack_en = cfg_pkg_en[0];


//------------ main FSM of pack --------
parameter S_IDLE = 3'h0;
parameter S_FIRE_HEAD = 3'h1;
parameter S_WAIT_HEAD = 3'h2;
parameter S_FIRE_LOAD = 3'h3;
parameter S_WAIT_LOAD = 3'h4;
parameter S_FIRE_TAIL = 3'h5;
parameter S_WAIT_TAIL = 3'h6;
parameter S_DONE = 3'h7;
reg [2:0] st_pack_main;
wire utc_sec_change;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_pack_main <= S_IDLE;
	else begin
		case(st_pack_main)
			S_IDLE : st_pack_main <= pack_en & utc_sec_change ? 
																S_FIRE_HEAD : S_IDLE;
			S_FIRE_HEAD : st_pack_main <= S_WAIT_HEAD;
			S_WAIT_HEAD : st_pack_main <= done_head ? S_FIRE_LOAD : S_WAIT_HEAD;
			S_FIRE_LOAD : st_pack_main <= S_WAIT_LOAD;
			S_WAIT_LOAD : st_pack_main <= done_load ? S_FIRE_TAIL : S_WAIT_LOAD;
			S_FIRE_TAIL : st_pack_main <= S_WAIT_TAIL;
			S_WAIT_TAIL : st_pack_main <= done_tail ? S_DONE : S_WAIT_TAIL;
			S_DONE : st_pack_main <= S_IDLE;
			default : st_pack_main <= S_IDLE;
		endcase
	end
end

reg [31:0] utc_sec_reg;
always @ (posedge clk_sys)
	utc_sec_reg <= utc_sec;
assign utc_sec_change = (utc_sec_reg != utc_sec) ? 1'b1 : 1'b0;


//--------- control output -----------
wire	fire_head;
wire	fire_load;
wire	fire_tail;
assign fire_head = (st_pack_main == S_FIRE_HEAD) ? 1'b1 : 1'b0;
assign fire_load = (st_pack_main == S_FIRE_LOAD) ? 1'b1 : 1'b0;
assign fire_tail = (st_pack_main == S_FIRE_TAIL) ? 1'b1 : 1'b0;


wire pk_frm;
assign pk_frm = (st_pack_main != S_IDLE) ? 1'b1 : 1'b0;


endmodule


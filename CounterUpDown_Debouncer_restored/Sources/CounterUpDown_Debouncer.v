module CounterUpDown_Debouncer #(parameter NBITS = 4) (
input clk, nrst, enable_pb, Up_Down, 
output [NBITS - 1 : 0] Q );


wire rst_w, one_shot_w;

assign rst_w = ~ nrst;


Debouncer DB_i (.clk(clk), .rst (rst_w) , // for DE10-Standard implementation
    .sw (~ enable_pb), .one_shot (one_shot_w)    );

CounterUpDown_Param # ( .n(NBITS) ) U_D_Counter_i ( .clk(clk), .rst(rst_w), 
							   .enable(one_shot_w), .Up_Down(Up_Down), .Q(Q)  );


endmodule
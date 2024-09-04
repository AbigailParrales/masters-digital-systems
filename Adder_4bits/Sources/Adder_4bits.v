// ITESO
// Daniela Abigail Parrales Mejia
// 4-bit 2's Complement Full Adder
// Using Structured Verilog
//
// (◕ᴗ◕✿) (◍•ᴗ•◍)✧*。


module Adder_4bits(
	input [3:0] A, B,
	input cin,
	output [3:0] Sum,
	output cout, overflow
);

wire [3:0] w_cout;

Full_Adder FA_0 (.a(A[0]), .b(B[0]), .cin(cin), .s(Sum[0]), .cout(w_cout[0]));
Full_Adder FA_1 (.a(A[1]), .b(B[1]), .cin(w_cout[0]), .s(Sum[1]), .cout(w_cout[1]));
Full_Adder FA_2 (.a(A[2]), .b(B[2]), .cin(w_cout[1]), .s(Sum[2]), .cout(w_cout[2]));
Full_Adder FA_3 (.a(A[3]), .b(B[3]), .cin(w_cout[2]), .s(Sum[3]), .cout(w_cout[3]));

assign overflow = w_cout[3] ^ w_cout[2];
assign cout = w_cout[3];

endmodule
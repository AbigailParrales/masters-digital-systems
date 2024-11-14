module Adder_8bits(
	input [7:0] A, B,
	input cin,
	output [7:0] Sum,
	output cout,
	output overflow
);
	wire cout_L, cout_H;
	wire overflow_L, overflow_H;

	// Lower half
	Adder_4bits Adder_L (.A(A[3:0]), .B(B[3:0]), .cin(cin),
								.Sum(Sum[3:0]), .cout(cout_L), .overflow(overflow_L));

	// Upper half
	Adder_4bits Adder_H (.A(A[7:4]), .B(B[7:4]), .cin(cout_L),
								 .Sum(Sum[7:4]), .cout(cout_H), .overflow(overflow_H));

	// cout logic
	assign cout = cout_H;
	// overflow logic
	assign overflow = cout_L ^ cout_H;

endmodule

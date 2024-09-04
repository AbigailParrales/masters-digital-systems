`timescale 1ns/1ps

module Adder_4bits_TB();

/***
module Adder_4bits(
	input [3:0] A, B,
	input cin,
	output [3:0] Sum,
	output cout, overflow
);***/

// Signals for inputs
reg [3:0] s_A, s_B;
reg s_cin;
// Signals for outputs
wire [3:0] s_Sum;
wire s_cout, s_overflow;

// UUT
Adder_4bits UUT(.A(s_A), .B(s_B), .cin(s_cin), .Sum(s_Sum), .cout(s_cout), .overflow(s_overflow));

// Initialization
initial begin
s_A = 1'b0;
s_B = 1'b0;
s_cin = 1'b0;
end

always begin
// positive numbers
// 1+0=1
#10	s_A = 4'h1;
	s_B = 4'h0;
	s_cin = 1'b0;
// 2+1=3
#10	s_A = 4'h2;
	s_B = 4'h1;
	s_cin = 1'b0;
// 3+4=7
#10	s_A = 4'h3;
	s_B = 4'h4;
	s_cin = 1'b0;
// 5+1=6
#10	s_A = 4'h5;
	s_B = 4'h1;
	s_cin = 1'b0;

//Return to 0s
// 0+0=0
#10	s_A = 4'h0;
	s_B = 4'h0;
	s_cin = 1'b0;

// negative numbers
// (-1)+(-5)=(-6)
#10	s_A = 4'b1111;
	s_B = 4'b1001;
	s_cin = 1'b0;
// (-4)+(-4)=(-8)
#10	s_A = 4'b1100;
	s_B = 4'b1100;
	s_cin = 1'b0;

//Return to 0s
// 0+0=0
#10	s_A = 4'h0;
	s_B = 4'h0;
	s_cin = 1'b0;

// Testing carry and overflow
// -(1)+1=0
// carry = 1
// overflow = 0
#10	s_A = 4'b1111;
	s_B = 4'b0001;
	s_cin = 1'b0;
// 7 + 2 = 9 or (-7)
// carry = 0
// overflow = 1
#10	s_A = 4'b0111;
	s_B = 4'b0010;
	s_cin = 1'b0;
// (-8) + (-8) = 24 or (-16)
// carry = 1
// overflow = 1
#10 s_A = 4'b1000;
    s_B = 4'b1000;



end

endmodule

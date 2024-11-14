// Iteso
// Daniela Abigail Parrales Mejia
//
// ? ??? ?    U???U    ? ?? ? ?? ?
//
// ??(*´???)??(???`*)??
//
// (????????)????????


`timescale 1ns/1ps

module Adder_8bits_TB();

// Signals for inputs
reg [7:0] s_A, s_B;
reg s_cin;
// Signals for outputs
wire [7:0] s_Sum;
wire s_cout, s_overflow;

// UUT
Adder_8bits UUT(.A(s_A), .B(s_B), .cin(s_cin), .Sum(s_Sum), .cout(s_cout), .overflow(s_overflow));

// Initialization
initial begin
s_A = 1'b0;
s_B = 1'b0;
s_cin = 1'b0;
end

// Increase B first
always begin
# 10 s_B = s_B + 1'b1;
     s_cin = 1'b0;
end

// Increase A after
always begin
# 10 s_A = s_A + 1'b1;
      s_cin = 1'b0;
end


endmodule


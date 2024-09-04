module my_ALU #(parameter LENGTH = 5) (
	input [LENGTH-1:0] A, B,
	input [3:0] Control,

	output reg [7:0] Result,

	output reg f_carry, f_overflow, f_negativo, f_zero
);

endmodule
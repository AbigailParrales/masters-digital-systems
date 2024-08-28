module basic_gates(
	input a, b,
	output y_and, y_or, y_not_a, y_not_b
);

assign y_and = a & b;
assign y_or = a | b;
assign y_not_a = ~a;
assign y_not_b = ~b;

endmodule
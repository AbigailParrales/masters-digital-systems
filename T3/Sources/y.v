module y(
	input a, b, c,
	output y
);

assign y= (a & ~c) | (b & c) | (a & b);

endmodule
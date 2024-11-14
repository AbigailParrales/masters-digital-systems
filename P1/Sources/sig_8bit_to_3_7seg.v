module sig_8bit_to_3_7seg (
	input [7:0] signed_num,         // 8-bit signed input number
	output [6:0] hundreds_7segment, // 7-segment output for hundreds digit
	output [6:0] tens_7segment,     // 7-segment output for tens digit
	output [6:0] units_7segment,    // 7-segment output for units digit
	output sign                     // Sign flag: 1 if negative, 0 if positive
);

	// Intermediate wires for BCD digits
	wire [3:0] hundreds;
	wire [3:0] tens;
	wire [3:0] units;

	// Instance of the sign_8bits_to_digits module
	sign_8bits_to_digits sign_to_digits (
		.signed_num(signed_num),
		.hundreds(hundreds),
		.tens(tens),
		.units(units),
		.sign(sign)
	);

	// Instance of the hex_to_7seg module for hundreds digit
	hex_to_7seg hundreds_display (
		.in_hex(hundreds),
		.out_7seg(hundreds_7segment)
	);

	// Instance of the hex_to_7seg module for tens digit
	hex_to_7seg tens_display (
		.in_hex(tens),
		.out_7seg(tens_7segment)
	);

	// Instance of the hex_to_7seg module for units digit
	hex_to_7seg units_display (
		.in_hex(units),
		.out_7seg(units_7segment)
	);

endmodule

module sign_8bits_to_digits (
	input [7:0] signed_num,     // 8-bit signed input number
	output reg [3:0] hundreds,  // Hundreds digit (4-bit)
	output reg [3:0] tens,      // Tens digit (4-bit)
	output reg [3:0] units,     // Units digit (4-bit)
	output reg sign             // Sign flag: 1 if negative, 0 if positive
);

	reg [7:0] abs_value; // Absolute value of the input number
	reg [7:0] remainder; // Temporary variable for calculations
	reg [7:0] tmp_hundreds, tmp_tens, tmp_units;

	always @(signed_num) begin
	// Determine sign and absolute value
	if (signed_num[7] == 1) begin
		sign = 1'b1;             // Negative number
		abs_value = -signed_num; // Take the absolute value
	end else begin
		sign = 1'b0;             // Positive number
		abs_value = signed_num;
	end

	// Convert absolute value to decimal digits using repeated subtraction
	// Extract the hundreds digit
	tmp_hundreds = (abs_value / 8'd100) % 8'd10;
	remainder = abs_value % 8'd100;

	// Extract the tens digit
	tmp_tens = (remainder / 8'd10) % 8'd10;
	tmp_units = remainder % 8'd10;

	// Assign the values to the outputs
	hundreds = tmp_hundreds[3:0];
	tens = tmp_tens[3:0];
	units = tmp_units[3:0];
	end
endmodule

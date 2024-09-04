module Compount_Gates (
	input a, b,
	output	y_xor,
				y_nand,
				y_nor,
				y_xnor
);

assign y_xor = a ^ b;
assign y_nand = ~(a & b);
assign y_nor = ~(a | b);
assign y_xnor = ~(a ^ b);

endmodule
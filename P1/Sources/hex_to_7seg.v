module hex_to_7seg (
	input [3:0] in_hex,
	output reg [6:0] out_7seg
);

localparam hex_7seg_0x0 = 7'h3F;
localparam hex_7seg_0x1 = 7'h06;
localparam hex_7seg_0x2 = 7'h5B;
localparam hex_7seg_0x3 = 7'h4F;
localparam hex_7seg_0x4 = 7'h66;
localparam hex_7seg_0x5 = 7'h6D;
localparam hex_7seg_0x6 = 7'h7D;
localparam hex_7seg_0x7 = 7'h07;
localparam hex_7seg_0x8 = 7'h7F;
localparam hex_7seg_0x9 = 7'h67;
localparam hex_7seg_0xA = 7'h77;
localparam hex_7seg_0xB = 7'h7C;
localparam hex_7seg_0xC = 7'h39;
localparam hex_7seg_0xD = 7'h5E;
localparam hex_7seg_0xE = 7'h79;
localparam hex_7seg_0xF = 7'h71;

always@ (in_hex) begin
	case (in_hex)
		4'h0:
			out_7seg <= ~hex_7seg_0x0;
		4'h1:
			out_7seg <= ~hex_7seg_0x1;
		4'h2:
			out_7seg <= ~hex_7seg_0x2;
		4'h3:
			out_7seg <= ~hex_7seg_0x3;
		4'h4:
			out_7seg <= ~hex_7seg_0x4;
		4'h5:
			out_7seg <= ~hex_7seg_0x5;
		4'h6:
			out_7seg <= ~hex_7seg_0x6;
		4'h7:
			out_7seg <= ~hex_7seg_0x7;
		4'h8:
			out_7seg <= ~hex_7seg_0x8;
		4'h9:
			out_7seg <= ~hex_7seg_0x9;
		4'hA:
			out_7seg <= ~hex_7seg_0xA;
		4'hB:
			out_7seg <= ~hex_7seg_0xB;
		4'hC:
			out_7seg <= ~hex_7seg_0xC;
		4'hD:
			out_7seg <= ~hex_7seg_0xD;
		4'hE:
			out_7seg <= ~hex_7seg_0xE;
		4'hF:
			out_7seg <= ~hex_7seg_0xF;
		default:
			out_7seg <= 7'b0000000;
	endcase
end

endmodule
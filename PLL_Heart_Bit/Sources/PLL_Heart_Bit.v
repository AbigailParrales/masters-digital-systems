// ITESO
// Cuauhtemoc Aguilera
// Top level design to test the Intel PLL IP 
module PLL_Heart_Bit (
input n_rst,
input clk,
input enable,
output heart_bit_out,
output locked
);

wire clk_100M_w;
wire rst_w;

assign rst_w = ~n_rst;

PLL_100MHz_Intel_IP PLL_100MHz_i (.refclk(clk), .rst(rst_w), .outclk_0(clk_100M_w), .locked(locked) );

Heart_Bit # (.Half_Period_Counts(50_000_000) ) // half second for a clk of 100 MHz 
		HB_ins(	.clk(clk_100M_w), .rst(rst_w), .enable(enable),
				.heart_bit_out(heart_bit_out) );
			
endmodule

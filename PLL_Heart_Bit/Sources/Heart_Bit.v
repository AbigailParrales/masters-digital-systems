`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO 
// Engineer:  Cuauhtemoc Aguilera
// Heart bit design to see a alive-system signal after synthesis for new design in the DE10-Standard board.
//////////////////////////////////////////////////////////////////////////////////

module Heart_Bit
 # (parameter Half_Period_Counts = 50_000_000 ) // half second for a clk of 100 MHz 
   (
    input clk,
    input rst,
    input enable,
    output reg heart_bit_out
    );
localparam Delay_Bits = $clog2(Half_Period_Counts);
    
reg [Delay_Bits-1:0] Delay_Count;
  
wire end_half_delay;    
    // Comparator
assign end_half_delay = (Delay_Count == Half_Period_Counts-1)? 1'b1 : 1'b0;


// Contador

always @(posedge rst, posedge clk)
    begin
        if (rst)
       
            Delay_Count <= {Delay_Bits{1'b0}};
        else 
            if (enable)
                if (end_half_delay)
                         Delay_Count <= {Delay_Bits{1'b0}};
                else 
                        Delay_Count <= Delay_Count + 1'b1;
             else
                Delay_Count <= Delay_Count;
     end
    
// Flip Flop T
always @(posedge rst, posedge clk)
    begin
        if (rst)
       
            heart_bit_out <= 1'b0;
        else 
            if (enable) 
                if (end_half_delay)
                    heart_bit_out <= ~heart_bit_out;
                else 
                    heart_bit_out <= heart_bit_out;
            else 
                heart_bit_out <= heart_bit_out;
     end
endmodule

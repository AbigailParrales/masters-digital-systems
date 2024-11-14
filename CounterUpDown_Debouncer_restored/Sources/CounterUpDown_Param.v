`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Cuauhtemoc Aguilera
// Module 2^n Up-Down Counter
//////////////////////////////////////////////////////////////////////////////////
module CounterUpDown_Param
 # (parameter n = 2)
(   input clk,
    input rst,
    input enable, Up_Down,
    output reg [ n - 1 : 0 ] Q  );

 always @( posedge rst, posedge clk) 
    begin
        if (rst)
            Q <= { n {1'b0} };
        else
            if (enable)
            	if (Up_Down)
                	Q <= Q + 1'b1;
                else 	
					   Q <= Q - 1'b1;
            else
                Q <= Q;
    end 
endmodule


//==============================================================================
//  Module:       deco_keyboard
//  Description:  This module determines whether the data coming from the 
//                matrix keyboard is valid or if it is just a pulse to send 
//                the data.
//  Author:       Rodriguez Delfin, Elias
//  Date:         2024-10-28
//==============================================================================

module deco_keyboard(
  input clk,
  input [7:0] data,
  output reg [7:0] oData,
  output reg oValid,
  output reg send_data
 );
  
  always @(posedge clk) begin
    case(data)
      8'h46: begin send_data <= 'b1; oData <= oData; oValid <= 'b0; end
      default: begin send_data <= 'b0; oData <= data; oValid <= 'b1; end
    endcase
  end
  
  
endmodule
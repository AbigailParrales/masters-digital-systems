module ascci2bcd(
  input [7:0]      iData,
  input            iValid,
  input            iRst,
  output reg [6:0] oSeg
  );
  
  always @* begin
    if(!iRst) oSeg <= 7'b111_1111;
    else if(iValid) begin
      case(iData)
        'h30: oSeg <= 7'b000_0001;
        'h31: oSeg <= 7'b100_1111;
        'h32: oSeg <= 7'b0010010;
        'h33: oSeg <= 7'b0000110;
        'h34: oSeg <= 7'b1001100;
        'h35: oSeg <= 7'b0100100;
        'h36: oSeg <= 7'b0100000;
        'h37: oSeg <= 7'b0001111;
        'h38: oSeg <= 7'b0000000;
        'h39: oSeg <= 7'b0001100;
        'h41: oSeg <= 7'b0001000;
        'h62: oSeg <= 7'b1100000;
        'h43: oSeg <= 7'b0110001;
        'h64: oSeg <= 7'b1000010;
        'h45: oSeg <= 7'b0110000;
        'h46: oSeg <= 7'b0111000;
        'h48: oSeg <= 7'b1001000;
        'h49: oSeg <= 7'b1111001;
        'h4A: oSeg <= 7'b1000011;
        'h4C: oSeg <= 7'b1110001;
        'h50: oSeg <= 7'b0011000;
        'h55: oSeg <= 7'b1000001;
        'h59: oSeg <= 7'b1000100;
        'h40: oSeg <= 7'b0000010;
        'h5F: oSeg <= 7'b1111110;
        default: oSeg <= 7'b111_0111;
       endcase
    end
    else oSeg <= oSeg;
  end
  
endmodule
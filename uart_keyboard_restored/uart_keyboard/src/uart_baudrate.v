module uart_baudrate#(parameter BAUD_RATE = 9600)(
  input iClk,
  input iRst,
  output oBaud_tick
);
  localparam BAUD_RATE_DIV = 50000000/BAUD_RATE;
  
  reg [12:0] baud_counter;
  reg        baud_tick;
  
  assign oBaud_tick = baud_tick;
  
  always @(posedge iClk or negedge iRst) begin
      if (!iRst) begin
          baud_counter <= 0;
          baud_tick <= 0;
      end else if (baud_counter == BAUD_RATE_DIV - 1) begin
          baud_counter <= 0;
          baud_tick <= 1;
      end else begin
          baud_counter <= baud_counter + 1;
          baud_tick <= 0;
      end
  end
endmodule
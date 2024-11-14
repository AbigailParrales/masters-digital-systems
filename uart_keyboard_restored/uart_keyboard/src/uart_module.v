module uart_module#(parameter BAUD_RATE = 9600)(
  input        clk,         //CLOCK
  input        n_rst,       //RESET
  input        tx_send,     //SEND BUTTON
  input        rx,          //INPUT SERIAL FROM PC
  input        rx_flag_clr, //CLEAR FLAG
  input  [7:0] Tx_Data,     // DATA INPUT
  
  output [7:0] Rx_Data,
  output       rx_flag,
  output       parity_error,
  output       busy_bit,
  output       tx
);
  
  uart_tx#(.BAUD_RATE(BAUD_RATE)) uart_send (
    .iClk(clk),
    .iRst(n_rst),
    .iStart(tx_send),
    .iData_tx(Tx_Data),
    .oTx(tx),
    .oBusy_tx(busy_bit)
  );

  uart_rx#(.BAUD_RATE(BAUD_RATE)) uart_rece(
    .iClk(clk),
    .iRst(n_rst),
    .iRx(rx),
    .iCTS(~rx_flag_clr),
    .oData_rx(Rx_Data),
    .oPar_err(parity_error),
    .oData_valid(rx_flag)
  );
  
endmodule
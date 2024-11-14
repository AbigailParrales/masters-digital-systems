//==============================================================================
//  Module:       uart_module
//  Description:  This module contains instances of both RX and TX UART for 
//                full-duplex communication.
//  Author:       Rodriguez Delfin, Elias
//  Date:         2024-10-28
//==============================================================================

module uart_module#(parameter BAUD_RATE   = 9600,
                    parameter BIT_LENGHT  = 8,
                    parameter PARITY_TYPE = 0,
                    parameter STOP_BITS   = 1)(
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
  
  uart_tx#(.BAUD_RATE(BAUD_RATE),
               .BIT_LENGHT(BIT_LENGHT),
               .PARITY_TYPE(PARITY_TYPE),
               .STOP_BITS(STOP_BITS)) uart_send (
    .iClk(clk),
    .iRst(n_rst),
    .iStart(tx_send),
    .iData_tx(Tx_Data),
    .oTx(tx),
    .oBusy_tx(busy_bit)
  );

  uart_rx#(.BAUD_RATE(BAUD_RATE),
               .BIT_LENGHT(BIT_LENGHT),
               .PARITY_TYPE(PARITY_TYPE),
               .STOP_BITS(STOP_BITS)) uart_rece(
    .iClk(clk),
    .iRst(n_rst),
    .iRx(rx),
    .iCTS(~rx_flag_clr),
    .oData_rx(Rx_Data),
    .oPar_err(parity_error),
    .oData_valid(rx_flag)
  );
  
endmodule
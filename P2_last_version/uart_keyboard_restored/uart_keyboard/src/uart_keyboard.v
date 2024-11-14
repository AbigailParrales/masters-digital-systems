//==============================================================================
//  Module:       uart_keyboard
//  Description:  This module contains a full-duplex UART instance, decoders 
//                for sending data to 7-segment displays, a matrix keyboard 
//                interpreter, frequency dividers, and debouncers for buttons.
//  Author:       Rodriguez Delfin, Elias
//						Parrales Mejia, Daniela Abigail
//  Date:         2024-10-28
//==============================================================================
//
//  Parameters:
//    - BAUD_RATE   : Sets the baud rate for UART communication (default: 9600).
//    - BIT_LENGTH  : Specifies the size of messages in bits (default: 8).
//    - PARITY_TYPE : Defines parity mode (0 = none, 1 = odd, 2 = even).
//    - STOP_BITS   : Number of stop bits in UART transmission (default: 1).
//==============================================================================

module uart_keyboard#(parameter BAUD_RATE   = 9600,
                      parameter BIT_LENGHT  = 8,
                      parameter PARITY_TYPE = 2,
                      parameter STOP_BITS   = 1)(
  input        clk,           //CLOCK
  input        n_rst,         //RESET - when pressed is 0
  input        rx,            //INPUT SERIAL FROM PC
  input        rx_flag_clr,   //CLEAR FLAG
  input  [3:0] row_keyboard,  //Input matrix keyboard
   
  output       parity_error,  //Parity error flag
  output       rx_flag,       //Received flag
  output [6:0] oSeg,          //Segment output for data
  output [6:0] oSeg_r,        //Segment output for data
  output       busy,          //Busy flag for TX, if tx sending data, this flag is 1
  output [3:0] col_keyboard,  //Salidas matrix keyboard
  output       tx             //Output serial to PC
);

  wire [7:0] Rx_Data;
  wire       send_button;
  wire [7:0] Tx_Data;
  wire [7:0] deco_data;
  wire tx_send2;
  wire Valid_data;

  uart_module#(.BAUD_RATE(BAUD_RATE),      //Module UART FULL DUPLEX
               .BIT_LENGHT(BIT_LENGHT),
               .PARITY_TYPE(PARITY_TYPE),
               .STOP_BITS(STOP_BITS)) 
               uart_instance(
    .clk(clk),
    .n_rst(n_rst),
    .tx_send(send_button),
    .rx(rx),
    .rx_flag_clr(rx_flag_clr),
    .Tx_Data(deco_data),
    .busy_bit(busy),

    .Rx_Data(Rx_Data),
    .rx_flag(rx_flag),
    .parity_error(parity_error),
    .tx(tx)
  );
  
  ascci2bcd display_receive( //Module that displays received data
  .iData(Rx_Data),
  .clk(clk),
  .iValid(rx_flag),
  .iRst(n_rst),
  .oSeg(oSeg)
  );
  
  ascci2bcd display_send(    //Module that displays sent data
  .iData(Tx_Data),
  .clk(clk),
  .iValid(Valid_data),
  .iRst(n_rst),
  .oSeg(oSeg_r)
  );
  
  Debouncer send_button_m(   //Module that debouncers the send button
    .clk(clk),
    .rst(n_rst), 
    .sw(tx_send2),
    .one_shot(send_button)
    );
    
  matrix_keyboard keyboard(  //Module that decodes data from the matrix
    .clk(clk),
    .rst(~n_rst),
    .row(row_keyboard),
    .col(col_keyboard),
    .key_val(Tx_Data)
);

 deco_keyboard keyabord_t(   //Module that sends data from the matrix or sends a send pulse
  .clk(clk),
  .data(Tx_Data),
  .oData(deco_data),
  .oValid(Valid_data),
  .send_data(tx_send2)
 );
  
    
endmodule
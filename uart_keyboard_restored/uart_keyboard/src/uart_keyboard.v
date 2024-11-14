module uart_keyboard(
  input        clk,         //CLOCK
  input        n_rst,       //RESET - when pressed is 0
  input        tx_send,     //SEND BUTTON
  input        rx,          //INPUT SERIAL FROM PC
  input        rx_flag_clr, //CLEAR FLAG
  input  [3:0] row_keyboard, //Input matrix keyboard
   
  output       parity_error, //Parity error flag
  output [6:0] oSeg, //Segment output for data
  output [6:0] oSeg_r,//Segment output for data
  output       busy, //Busy flag for TX, if tx sending data, this flag is 1
  output [3:0] col_keyboard,//Salidas matrix keyboard
  output       tx           //Output serial to PC
);

  wire [7:0] Rx_Data;
  wire       rx_flag;
  wire       send_button;
  wire [7:0] Tx_Data;      // DATA INPUT

  uart_module uart_instance(
    .clk(clk),
    .n_rst(n_rst),
    .tx_send(send_button),
    .rx(rx),
    .rx_flag_clr(rx_flag_clr),
    .Tx_Data(/*Tx_Data*/'h41), //hardcoded data to A
    .busy_bit(busy),

    .Rx_Data(Rx_Data),
    .rx_flag(rx_flag),
    .parity_error(parity_error),
    .tx(tx)
  );
  
  ascci2bcd display_receive(
  .iData(Rx_Data),
  .iValid(rx_flag),
  .iRst(n_rst),
  .oSeg(oSeg)
  );
  
  ascci2bcd display_send(
  .iData(Tx_Data),
  .iValid(1'b1),
  .iRst(n_rst),
  .oSeg(oSeg_r)
  );
  
  Debouncer(
    .clk(clk),
    .rst(n_rst), 
    .sw(tx_send),
    .one_shot(send_button)
    );
    
endmodule
//==============================================================================
//  Module:       uart_tx
//  Description:  This module is used to send serial data. It contains a 
//                finite state machine (FSM) that manages communication with 
//                support for parity checking, configurable stop bit length, 
//                and variable bit length for data frames.
//  Author:       Rodriguez Delfin, Elias
//  Date:         2024-10-28
//==============================================================================

module uart_tx#(parameter BAUD_RATE   = 9600,
                parameter BIT_LENGHT  = 8,
                parameter PARITY_TYPE = 0,
                parameter STOP_BITS   = 1)(
	input                  iClk,      //Clock input
	input                  iRst,      //Reset input
	input                  iStart,    //Signal to send data
	input [BIT_LENGHT-1:0] iData_tx,  //Data to send
	output reg             oTx,       //Data out
  output reg             oBusy_tx   //Busy flag
);

  //Local FSM Parameter
  localparam IDLE = 0, START = 1, TRANSMIT = 2, ODD = 3, EVEN = 4, STOP = 5;
  localparam P_NONE = 0, P_ODD = 1, P_EVE = 2;

  reg [3:0]  bit_idx;
  reg [2:0]  bit_stop;
  reg [2:0]  state;
  reg [7:0]  tx_data;
  
  wire       baud_tick;

	//Instance of baudrate controller
  uart_baudrate#(.BAUD_RATE(BAUD_RATE)) bd_controller(
    .iClk(iClk),
    .iRst(iRst),
    .oBaud_tick(baud_tick)
  );

  always @(posedge iClk or negedge iRst) begin
      if (!iRst) begin
          state <= IDLE;
          bit_idx <= 0;
          bit_stop <= 0;
          oTx <= 1;
          oBusy_tx <= 0;
      end else if (baud_tick || iStart) begin
          case (state)
              IDLE: begin
                  if (iStart) begin
                      tx_data <= iData_tx;
                      oBusy_tx <= 1;
                      state <= START;
                  end
              end
              START: begin
                //$display("%0t - TX - Starting Sending data",$time);
                  oTx <= 0;
                  state <= TRANSMIT;
                  bit_idx <= 0;
									bit_stop <= 0;
              end
              TRANSMIT: begin
                  oTx <= tx_data[bit_idx];
                //$display("%0t - TX - Data %0h",$time,  oTx);
                  if (bit_idx == (BIT_LENGHT - 1)) begin
                      case(PARITY_TYPE)
                        P_NONE: state <= STOP;
                        P_ODD:  state <= ODD;
                        P_EVE:  state <= EVEN;
                      endcase
                  end else begin
                      bit_idx <= bit_idx + 1'b1;
                  end
              end
              ODD: begin
                  oTx <= ~(^tx_data);
                  state <= STOP;
              end
              EVEN: begin
                  oTx <= ^tx_data;
                  state <= STOP;
              end
              STOP: begin
                //$display("%0t - TX - Stop",$time);
                  oTx <= 1;
                  if(bit_stop == STOP_BITS) begin
                    oBusy_tx <= 0;
                    state <= IDLE;
                  end
                  else 
                    bit_stop = bit_stop + 1'b1;
              end
          endcase
      end
  end
endmodule
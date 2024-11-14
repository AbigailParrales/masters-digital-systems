//==============================================================================
//  Module:       uart_rx
//  Description:  This module is used to receive serial data. It contains a 
//                finite state machine (FSM) that manages communication with 
//                support for parity checking, configurable stop bit length, 
//                and variable bit length for data frames.
//  Author:       Rodriguez Delfin, Elias
//						Parrales, Daniela
//  Date:         2024-10-28
//==============================================================================

module uart_rx#(parameter BAUD_RATE   = 9600,
                parameter BIT_LENGHT  = 8,
                parameter PARITY_TYPE = 0,
                parameter STOP_BITS   = 1)(
    input iClk,
    input iRst,
    input iRx,
    input iCTS,
    output reg [7:0] oData_rx,
    output oPar_err,
    output oData_valid
);

    // Baud rate configuration (9600 baud on 50MHz clock)
		localparam IDLE = 0, START = 1, RECEIVE = 2, PARITY = 3, STOP = 4, CHECK = 5;
    localparam P_NONE = 0, P_ODD = 1, P_EVE = 2;
    localparam HALF_BD = (50_000_000/BAUD_RATE)/2;

    reg [3:0] bit_idx;         // Index to count bits
    reg [BIT_LENGHT-1:0] rx_data;         // Store received bits
    reg [2:0] state;           // State machine variable
		reg       parity;
		reg       valid_par;
		reg       stop_bit;
		reg       valid_stop;
		reg       finish_c;
    reg [12:0] baud_cnt;
    reg        start_cnt;
    reg        rst_cnt;
    
    wire baud_tick;             // Tick for baud rate

		assign oData_valid = valid_par & valid_stop & finish_c;
    assign oPar_err = finish_c ? ~valid_par : 1'b0;

  uart_baudrate#(.BAUD_RATE(BAUD_RATE),.IS_RX(1)) bd_controller(
    .iClk(iClk),
    .iRst(rst_cnt),
    .oBaud_tick(baud_tick)
  );

    // UART receiver state machine
    always @(posedge iClk or negedge iRst) begin
        if (!iRst) begin
            state <= IDLE;
            bit_idx <= 0;
            rx_data <= 8'b0;
            oData_rx <= 8'b0;
						parity <= 0;
						valid_par <= 0;
						stop_bit <= 0;
						finish_c <= 0;
            start_cnt <= 1'b0;
            rst_cnt <= 0;
        end else if (baud_tick || state == IDLE) begin
            if(iCTS) begin
              state <= IDLE;
              finish_c <= 0;
              oData_rx <= 0;
              rst_cnt <= 0;
            end
            case (state)
                IDLE: begin
                    if (iRx == 0) begin // Start bit detected
                        if (baud_cnt == HALF_BD) begin state <= RECEIVE; rst_cnt <= 1; end
                        bit_idx <= 0;
                        start_cnt <= 1'b1;
                  end
                end
                RECEIVE: begin
                    start_cnt <= 1'b0;
										valid_par <= 0;
										stop_bit <= 0;
										finish_c <= 0;
                    rx_data[bit_idx] <= iRx; // Shift in received bit
                  //$display("%0t - RX - Data %0h",$time,iRx);
                    if (bit_idx == (BIT_LENGHT - 1) ) begin
												case(PARITY_TYPE)
                        P_NONE: state <= STOP;
                        P_ODD:  state <= PARITY;
                        P_EVE:  state <= PARITY;
                      endcase
                    end else begin
                        bit_idx <= bit_idx + 1'b1;
                    end
                end
								PARITY: begin
									parity <= iRx;
                  state <= STOP;
								end
                STOP: begin
                     //$display("%0t - RX - Stop",$time);
										case(PARITY_TYPE)
											P_NONE: valid_par <= 1;
                      P_ODD: begin
												valid_par <= (~^rx_data == parity);
											end
                      P_EVE: begin
												valid_par <= (^rx_data == parity);
											end
										endcase

										
                    if (iRx == 1) begin // Stop bit must be 1
												valid_stop <= 1;
                    end
										else valid_stop <= 0;
                    if(stop_bit == STOP_BITS - 1) begin 
												state <= IDLE; // Go back to idle state after receiving a byte
												oData_rx <= rx_data;
												finish_c <= 1;
										end
										else begin
												state <= STOP;
												stop_bit <= stop_bit + 1'b1;
										end
                end
            endcase
        end
    end

    always @(posedge iClk or negedge iRst) begin
    if(!iRst) baud_cnt <= 0;
      else if(start_cnt) begin
        baud_cnt <= baud_cnt + 1;
      end
      else begin
        baud_cnt <= 'b0;
      end
    end

endmodule
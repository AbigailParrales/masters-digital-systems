//==============================================================================
//  Module:       matrix_keyboard
//  Description:  This module scans the buttons on a matrix keyboard and 
//                outputs the corresponding ASCII data. It includes a timer 
//                for debouncing the buttons.
//  Author:       Rodriguez Delfin, Elias
//  Date:         2024-10-28
//==============================================================================

module matrix_keyboard (
    input wire clk,
    input wire rst,
    input wire [3:0] row,
    output reg [3:0] col,
    output reg [7:0] key_val
);

    reg [1:0] current_col;
    reg [20:0] scan_cnt;
    reg [3:0] row_reg;

    parameter ASCII_0 = 8'h30; // '0'
    parameter ASCII_1 = 8'h31; // '1'
    parameter ASCII_2 = 8'h32; // '2'
    parameter ASCII_3 = 8'h33; // '3'
    parameter ASCII_4 = 8'h34; // '4'
    parameter ASCII_5 = 8'h35; // '5'
    parameter ASCII_6 = 8'h36; // '6'
    parameter ASCII_7 = 8'h37; // '7'
    parameter ASCII_8 = 8'h38; // '8'
    parameter ASCII_9 = 8'h39; // '9'
    parameter ASCII_A = 8'h41; // 'A'
    parameter ASCII_B = 8'h62; // 'B'
    parameter ASCII_C = 8'h43; // 'C'
    parameter ASCII_D = 8'h64; // 'D'
    parameter ASCII_E = 8'h45; // 'E'
    parameter ASCII_F = 8'h46; // 'F'

    // Debouncer / Timer
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            scan_cnt <= 0;
        end else begin
            scan_cnt <= scan_cnt + 1'b1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_col <= 0;
            col <= 4'b0000;  // Set all columns to high when not scanning
            row_reg <= 0;
        end else if (scan_cnt == 0) begin
            row_reg <= row;  // Capture the current row state
            current_col <= current_col + 1'b1;
            case (current_col)
                2'b00: col <= 4'b1110;  // Scan first column
                2'b01: col <= 4'b1101;  // Scan second column
                2'b10: col <= 4'b1011;  // Scan third column
                2'b11: col <= 4'b0111;  // Scan fourth column
            endcase
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            key_val <= 8'h0;  // No key pressed (default to 0xF)
        end else begin
            if (row_reg != 4'b0000) begin  // If a row is low, a key is pressed
                case ({current_col, row_reg})
                    8'b00_1110: key_val <= ASCII_0;  // First column, first row
                    8'b00_1101: key_val <= ASCII_8;  // First column, second row
                    8'b00_1011: key_val <= ASCII_5;  // First column, third row
                    8'b00_0111: key_val <= ASCII_2;  // First column, fourth row

                    8'b01_1110: key_val <= ASCII_E;  // Second column, first row
                    8'b01_1101: key_val <= ASCII_7;  // Second column, second row
                    8'b01_1011: key_val <= ASCII_4;  // Second column, third row
                    8'b01_0111: key_val <= ASCII_1;  // Second column, fourth row

                    8'b10_1110: key_val <= ASCII_D;  // Third column, first row
                    8'b10_1101: key_val <= ASCII_C;  // Third column, second row
                    8'b10_1011: key_val <= ASCII_B; // Third column, third row
                    8'b10_0111: key_val <= ASCII_A; // Third column, fourth row

                    8'b11_1110: key_val <= ASCII_F; // Fourth column, first row
                    8'b11_1101: key_val <= ASCII_9; // Fourth column, second row
                    8'b11_1011: key_val <= ASCII_6; // Fourth column, third row
                    8'b11_0111: key_val <= ASCII_3; // Fourth column, fourth row

                    default: key_val <= key_val;  // No key pressed
                endcase
            end else begin
            end
        end
    end

endmodule

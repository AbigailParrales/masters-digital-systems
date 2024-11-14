module ALU_Display (
    input rst, clk, enable,
    input [4:0] A, B,                 // Updated to 5-bit width for A and B
    output [6:0] hundreds_7segment,   // 7-segment output for hundreds digit
    output [6:0] tens_7segment,       // 7-segment output for tens digit
    output [6:0] units_7segment,      // 7-segment output for units digit
    output sign,                      // Sign flag: 1 if negative, 0 if positive
    output reg carry,                 // Carry flag
    output reg overflow,              // Overflow flag
    output reg negative,              // Negative flag
    output reg zero                   // Zero flag
);

    // Internal signals
    wire [2:0] alu_control;        // Control signal from CounterUpDown_Debouncer
    wire [9:0] alu_result;         // Result from ALU (for 5-bit inputs, max size is 2*5 = 10 bits)
    wire alu_carry, alu_overflow;  // Flags from ALU
    wire alu_negative, alu_zero;   // Flags from ALU

    // CounterUpDown_Debouncer instance to generate the Control signal
    CounterUpDown_Debouncer #( .NBITS(3) ) control_counter (
        .clk(clk),
        .nrst(rst),
        .enable_pb(enable),
        .Up_Down(1'b1),  // Assuming Up counting, you can adjust as needed
        .Q(alu_control)
    );

    // my_ALU instance
    my_ALU #( .LENGTH(5) ) alu_instance (
        .rst(rst),
        .clk(clk),
        .enable(enable),
        .A(A),
        .B(B),
        .Control(alu_control),
        .Result(alu_result),
        .carry(alu_carry),
        .overflow(alu_overflow),
        .negative(alu_negative),
        .zero(alu_zero)
    );

    // Update output flags from ALU
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            carry <= 1'b0;
            overflow <= 1'b0;
            negative <= 1'b0;
            zero <= 1'b0;
        end else begin
            carry <= alu_carry;
            overflow <= alu_overflow;
            negative <= alu_negative;
            zero <= alu_zero;
        end
    end

    // sig_8bit_to_3_7seg instance to display the ALU result
    sig_8bit_to_3_7seg display_converter (
        .signed_num(alu_result[7:0]), // Display the lower 8 bits of the ALU result
        .hundreds_7segment(hundreds_7segment),
        .tens_7segment(tens_7segment),
        .units_7segment(units_7segment),
        .sign(sign)
    );

endmodule

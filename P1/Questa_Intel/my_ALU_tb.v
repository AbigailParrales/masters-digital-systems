module my_ALU_tb;
    parameter LENGTH = 5;
    reg rst, clk, enable;
    reg [LENGTH-1:0] A, B;
    reg [3:0] Control;
    wire [2*LENGTH-1:0] Result; // Updated to 2*LENGTH
    wire carry;
    wire overflow;

    // Instantiate the ALU module
    my_ALU #(LENGTH) uut (
        .rst(rst),
        .clk(clk),
        .enable(enable),
        .A(A),
        .B(B),
        .Control(Control),
        .Result(Result),
        .carry(carry),
        .overflow(overflow)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test cases with corner cases included
    initial begin
        // Initialize signals
        rst = 1;
        enable = 0;
        A = 0;
        B = 0;
        Control = 0;

        // Apply reset
        #10 rst = 0;
        enable = 1;

        // Corner Case 1: SUM with maximum values (to test carry and overflow)
        #10 A = 5'b11111; B = 5'b11111; Control = 4'd0; // SUM
        #10 if (Result !== {{(2*LENGTH-6){1'b1}}, 6'b111110}) 
            $display("SUM max test failed, Result = %b", Result);

        // Corner Case 2: SUB with A = 0 and B = max value (to test negative result)
        #10 A = 5'b00000; B = 5'b11111; Control = 4'd1; // SUB
        #10 if (Result !== {{(2*LENGTH-LENGTH+1){1'b1}}, {LENGTH-1{1'b0}}, 1'b1}) 
            $display("SUB corner test failed, Result = %b", Result);

        // Corner Case 3: NEG_B with minimum value (to check behavior with 2's complement)
        #10 B = 5'b00001; Control = 4'd2; // NEG_B
        #10 if (Result !== {2'b11, {LENGTH-1{1'b0}}, 1'b1}) 
            $display("NEG_B with zeros failed, Result = %b", Result);

        // Corner Case 4: MULT with maximum positive values (to test large product)
        #10 A = 5'b01111; B = 5'b01111; Control = 4'd3; // MULT
        #10 if (Result !== {{(LENGTH){1'b0}}, A * B}) 
            $display("MULT max positive test failed, Result = %b", Result);

        // Corner Case 5: MULT with maximum negative values (to test large product)
        #10 A = 5'b10001; B = 5'b10001; Control = 4'd3; // MULT
        #10 if (Result !== {{(LENGTH){1'b1}}, A * B}) 
            $display("MULT max negative test failed, Result = %b", Result);

        // Additional corner cases
        // Test with zero inputs
        #10 A = 5'b00000; B = 5'b00000; Control = 4'd0; // SUM with zero
        #10 if (Result !== {2*LENGTH{1'b0}}) 
            $display("SUM with zero failed, Result = %b", Result);

        // Test with different shifts
        #10 A = 5'b10101; B = 5'b00010; Control = 4'd8; // SHIFT_L
        #10 if (Result !== (A << B[3:0])) 
            $display("SHIFT_L test failed, Result = %b", Result);

        #10 A = 5'b10101; B = 5'b00010; Control = 4'd9; // SHIFT_R
        #10 if (Result !== (A >> B[3:0])) 
            $display("SHIFT_R test failed, Result = %b", Result);

        // Finish the test
        #10 $stop;
    end
endmodule


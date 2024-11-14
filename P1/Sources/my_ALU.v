module my_ALU #(parameter LENGTH = 5) (
    input rst, clk, enable,
    input [LENGTH-1:0] A, B,
    input [3:0] Control,

    output reg [2*LENGTH-1:0] Result, // Updated to 2*LENGTH bits
    output reg carry,                 // Carry flag
    output reg overflow,              // Overflow flag
    output reg negative,              // Negative flag
    output reg zero                   // Zero flag
);

    // Control operation codes
    localparam SUM      = 4'd0;
    localparam SUB      = 4'd1;
    localparam NEG_B    = 4'd2;
    localparam MULT     = 4'd3;
    localparam AND      = 4'd4;
    localparam OR       = 4'd5;
    localparam NEG_A    = 4'd6;
    localparam XOR      = 4'd7;
    localparam SHIFT_L  = 4'd8;
    localparam SHIFT_R  = 4'd9;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Result <= {2*LENGTH{1'b0}};
            carry <= 1'b0;
            overflow <= 1'b0;
            negative <= 1'b0;
            zero <= 1'b0;
        end
        else if (enable) begin 
            case (Control)
                SUM: begin
                    {carry, Result} <= {{(2*LENGTH-LENGTH){A[LENGTH-1]}}, A} + {{(2*LENGTH-LENGTH){B[LENGTH-1]}}, B};
                    overflow <= ((A[LENGTH-1] == B[LENGTH-1]) && (Result[LENGTH-1] != A[LENGTH-1]));
                end
                SUB: begin
                    {carry, Result} <= {{(2*LENGTH-LENGTH){A[LENGTH-1]}}, A} - {{(2*LENGTH-LENGTH){B[LENGTH-1]}}, B};
                    overflow <= ((A[LENGTH-1] != B[LENGTH-1]) && (Result[LENGTH-1] != A[LENGTH-1]));
                end
                NEG_B: begin
                    Result <= -{{(2*LENGTH-LENGTH){B[LENGTH-1]}}, B};
                    carry <= 1'b0;
                    overflow <= 1'b0;
                end
                MULT: begin
                    Result <= {{(LENGTH){A[LENGTH-1]}}, A} * {{(LENGTH){B[LENGTH-1]}}, B};
                    carry <= 1'b0;
                    overflow <= ((A[LENGTH-1] == B[LENGTH-1]) && (Result[2*LENGTH-1] != A[LENGTH-1]));
                end
                AND: begin
                    Result <= {{(2*LENGTH-LENGTH){A[LENGTH-1]}}, A} & {{(2*LENGTH-LENGTH){B[LENGTH-1]}}, B};
                    carry <= 1'b0;
                    overflow <= 1'b0;
                end
                OR: begin
                    Result <= {{(2*LENGTH-LENGTH){A[LENGTH-1]}}, A} | {{(2*LENGTH-LENGTH){B[LENGTH-1]}}, B};
                    carry <= 1'b0;
                    overflow <= 1'b0;
                end
                NEG_A: begin
                    Result <= -{{(2*LENGTH-LENGTH){A[LENGTH-1]}}, A};
                    carry <= 1'b0;
                    overflow <= 1'b0;
                end
                XOR: begin
                    Result <= {{(2*LENGTH-LENGTH){A[LENGTH-1]}}, A} ^ {{(2*LENGTH-LENGTH){B[LENGTH-1]}}, B};
                    carry <= 1'b0;
                    overflow <= 1'b0;
                end
                SHIFT_L: begin
                    Result <= {{(2*LENGTH-LENGTH){A[LENGTH-1]}}, A} << B[3:0];
                    carry <= 1'b0;
                    overflow <= 1'b0;
                end
                SHIFT_R: begin
                    Result <= {{(2*LENGTH-LENGTH){A[LENGTH-1]}}, A} >> B[3:0];
                    carry <= 1'b0;
                    overflow <= 1'b0;
                end
                default: begin
                    Result <= {2*LENGTH{1'b0}};
                    carry <= 1'b0;
                    overflow <= 1'b0;
                end
            endcase

            // Update the negative and zero flags
            negative <= Result[2*LENGTH-1]; // Check the MSB of Result for signed negative
            zero <= (Result == {2*LENGTH{1'b0}});
        end
    end

endmodule

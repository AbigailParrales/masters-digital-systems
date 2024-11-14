module my_SUM_generate #(parameter LENGTH = 5)(
    input [LENGTH-1:0] A, B,
    output [7:0] Result,
    output f_carry, f_overflow, f_negativo, f_zero
);

localparam bits2extend = (8 > LENGTH)? 8-LENGTH : 0;

// wires
wire [7:0] w_A, w_B, w_Result, w_cout;

assign w_A = {{bits2extend{1'b0}}, A};
assign w_B = {{bits2extend{1'b0}}, B};

// Generate block to create LENGTH instances of my_FA
genvar i;
generate
    for (i = 0; i < LENGTH; i = i + 1) begin : FA_GEN
        my_FA FA(.a(w_A[i]), .b(w_B[i]), .cin(i == 0 ? 1'b0 : w_cout[i-1]), .s(w_Result[i]), .cout(w_cout[i]));
    end
endgenerate

// Assigning remaining bits of Result
generate
    for (i = LENGTH; i < 8; i = i + 1) begin : EXTEND_RESULT
        assign w_Result[i] = w_Result[LENGTH-1];
    end
endgenerate

// Assigning Result
assign Result = w_Result;

// Assigning flags
assign f_carry = w_cout[LENGTH-1];
assign f_overflow = w_cout[LENGTH-1] ^ w_cout[LENGTH-2];
assign f_negativo = w_Result[LENGTH-1];
assign f_zero = ~(|Result);

endmodule

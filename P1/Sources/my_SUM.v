module my_SUM #(parameter LENGTH = 5)(
    input [LENGTH-1:0] A, B,
    output [7:0] Result,
    output f_carry, f_overflow, f_negativo, f_zero
);

localparam bits2extend = (8 > LENGTH)? 8-LENGTH : 0;

// wires
wire [7:0] w_A, w_B, w_Result, w_cout;

assign w_A = {{bits2extend{1'b0}}, A};
assign w_B = {{bits2extend{1'b0}}, B};

// Instances of our FA
my_FA FA_0(.a(w_A[0]), .b(w_B[0]), .cin(1'b0), .s(w_Result[0]), .cout(w_cout[0]));
my_FA FA_1(.a(w_A[1]), .b(w_B[1]), .cin(w_cout[0]), .s(w_Result[1]), .cout(w_cout[1]));
my_FA FA_2(.a(w_A[2]), .b(w_B[2]), .cin(w_cout[1]), .s(w_Result[2]), .cout(w_cout[2]));
my_FA FA_3(.a(w_A[3]), .b(w_B[3]), .cin(w_cout[2]), .s(w_Result[3]), .cout(w_cout[3]));
my_FA FA_4(.a(w_A[4]), .b(w_B[4]), .cin(w_cout[3]), .s(w_Result[4]), .cout(w_cout[4]));
my_FA FA_5(.a(w_A[5]), .b(w_B[5]), .cin(w_cout[4]), .s(w_Result[5]), .cout(w_cout[5]));
my_FA FA_6(.a(w_A[6]), .b(w_B[6]), .cin(w_cout[5]), .s(w_Result[6]), .cout(w_cout[6]));
my_FA FA_7(.a(w_A[7]), .b(w_B[7]), .cin(w_cout[6]), .s(w_Result[7]), .cout(w_cout[7]));

// Assigning Result
assign Result = {{bits2extend{w_Result[LENGTH-1]}}, w_Result[LENGTH-1:0]};

// Assigning flags
assign f_carry = w_cout[LENGTH-1];
assign f_overflow = w_cout[LENGTH-1] ^ w_cout[LENGTH-2];
assign f_negativo = w_Result[LENGTH-1];
assign f_zero = ~(|Result);

endmodule
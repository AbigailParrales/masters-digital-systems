module Full_Adder (
	input a, b, cin,
	output s, cout
);

assign cout = (a & b) | (a & cin) | (b & cin);
assign s = a ^ b ^ cin;

endmodule
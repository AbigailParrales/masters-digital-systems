module FSM_VendingMachine(
	input clk, rst,
	input in_cinco, in_diez,
	output reg cambio, producto
);

// Creating state reg
reg [2:0] estado;

// Codes for the states of the FSM
// Using grey code for assigning the states
localparam INI    = 3'b000;
localparam CINCO  = 3'b001;
localparam DIEZ   = 3'b011;
localparam QUINCE = 3'b010;
localparam VEINTE = 3'b110;


// For *estado*
// Depends on clk
always@ (posedge clk or posedge rst) begin
	// *rst*
	if (rst)
		estado <= INI;

	// estado NOT *INI*
	else begin
		case (estado)
			// INI case
			INI: begin
				if (in_cinco)
					estado <= CINCO;

				else begin
					if (in_diez)
						estado <= DIEZ;
					else
						estado <= estado;
				end

			end

			// CINCO case
			CINCO: begin
				if (in_cinco)
					estado <= DIEZ;

				else begin
					if (in_diez)
						estado <= QUINCE;
					else
						estado <= estado;
				end
			end

			// DIEZ case
			DIEZ: begin
				if (in_cinco)
					estado <= QUINCE;

				else begin
					if (in_diez)
						estado <= VEINTE;
					else
						estado <= estado;
				end
			end

			// QUINCE case
			QUINCE:
				estado <= INI;

			// VEINTE case
			VEINTE:
				estado <= INI;

			default:
				estado <= INI;

		endcase
	end
end

// For *outputs*
// Depends on estado
always@ (estado) begin
	case (estado)
		INI: begin
			cambio   = 1'b0;
			producto = 1'b0;
		end

		CINCO: begin
			cambio   = 1'b0;
			producto = 1'b0;
		end

		DIEZ: begin
			cambio   = 1'b0;
			producto = 1'b0;
		end

		QUINCE: begin
			cambio   = 1'b0;
			producto = 1'b1;
		end

		VEINTE: begin
			cambio   = 1'b1;
			producto = 1'b1;
		end

		default: begin
			cambio   = 1'b0;
			producto = 1'b0;
		end
	endcase
end

endmodule
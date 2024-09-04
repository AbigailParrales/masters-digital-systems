module Alarma(
	input ta, tb, masa,
	output alarma
);

assign alarma = (~ta&tb)|(ta&~tb&masa);

endmodule
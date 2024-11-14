module debouncer(
  input iButton,
  input iRst,
  input iClk,
  output reg oButton
);

  reg enable;
  reg [24:0] count;
  
  // Sequential logic to control counting and enable signal
  always @(posedge iClk or negedge iRst) begin
    if (!iRst) begin
      count <= 0;
      enable <= 0;
    end else begin
      if (count == 12500000) begin  // If the counter reaches 12,500,000 (quarter second)
        count <= 0;
        enable <= 1;
      end else begin
        count <= count + 1;
        enable <= 0;
      end
    end
  end
  
  // Sequential logic to update button output based on enable
  always @(posedge iClk or negedge iRst) begin
    if (!iRst) begin
      oButton <= 0;
    end else begin
      if (enable) begin
        oButton <= iButton;
      end
    end
  end
  
endmodule

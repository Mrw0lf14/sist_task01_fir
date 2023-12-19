module fir (
  input signed [7:0] data_in,
  output signed [15:0] data_out,
  input clk
);

  reg signed [15:0] res = 0;
  reg [2:0] counter = 0;
  reg [1:0] data_valid = 0;
  reg signed [7:0] koef[0:2];
  reg [4:0] takts = 0;

  assign data_out = res;

  initial begin
    koef[0] = -1;
    koef[1] = 2;
    koef[2] = 3;
  end

  always @(posedge clk) begin
    takts <= takts + 1;
    if (takts == 9) begin
      takts <= 0;
    end
    if (takts == 0) begin
      data_valid <= 1;
    end
    if (data_valid) begin
      res <= res + data_in * koef[counter];
      $display("data_in = %d, data_out = %d", data_in, data_out);
      counter <= counter + 1;
      data_valid <= 0;
      if (counter == 2) begin
        counter <= 0;
      end
    end
  end

endmodule

module fir_tb;
  reg signed [7:0] data_in;
  wire signed [15:0] data_out;
  reg clk;

  fir dut (
    .data_in(data_in),
    .data_out(data_out),
    .clk(clk)
  );

  initial begin
    $dumpfile("fir.vcd");
    $dumpvars(0, fir_tb);
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    for (data_in = -10; data_in <= 10; data_in = data_in + 1) begin
      #100;
    end
    data_in = 0;
    #100;
    $finish;
  end

endmodule
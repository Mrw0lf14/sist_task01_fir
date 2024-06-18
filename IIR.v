module iir (
  input signed [7:0] data_in,
  output signed [15:0] data_out,
  input clk
);

  parameter signed [7:0] a = -1;
  parameter signed [7:0] b = 4;
	wire signed [15:0] ab = a * b;
	wire signed [23:0] a2b = a * a * b;

  reg signed [23:0] x0 = 0, x1 = 0, x2 = 0;
  reg signed [23:0] y0 = 0, y3 = 0;

  reg signed [23:0] temp_x0 = 0, temp_x1 = 0, temp_x2 = 0;
  reg signed [23:0] temp_y0 = 0, temp_y1 = 0, temp_y2 = 0;
  reg signed [23:0] res = 0;
  assign data_out = y0;

  always @(posedge clk) begin
    temp_x0 <= data_in;
    temp_x1 <= temp_x0;
    temp_x2 <= temp_x1;
    
    temp_y0 <= y0;

    // Compute y(n)
    y0 <= x0 + x1 + x2 + y3;

    // Update x(n) delays
    x0 <= b * data_in;
    x1 <= ab * temp_x0;
    x2 <= a2b * temp_x1;
    y3 <= a * temp_y0;
  end

endmodule

module iir_tb;
  reg signed [7:0] data_in;
  wire signed [15:0] data_out;
  reg clk;

  iir dut (
    .data_in(data_in),
    .data_out(data_out),
    .clk(clk)
  );

  initial begin
    $dumpfile("iir.vcd");
    $dumpvars(0, iir_tb);
    clk = 0;

    forever #5 clk = ~clk;
  end

  initial begin
    // Тестирование для данных от -7 до 7 с шагом 1
    for (data_in = -7; data_in <= 7; data_in = data_in + 1) begin
      #10;
    end
    data_in = 0;
    #100;
    $finish;
  end

endmodule
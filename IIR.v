module iir (
  input signed [7:0] data_in,
  output signed [15:0] data_out,
  input clk
);

  reg signed [15:0] res = 0;
  reg signed [15:0] x0 = 0;
  reg signed [15:0] x1 = 0;
  reg signed [15:0] x2 = 0;
  reg signed [15:0] y0 = 0;
  reg signed [15:0] y1 = 0;
  reg signed [15:0] y2 = 0;

  reg signed [15:0] temp_x0 = 0;
  reg signed [15:0] temp_x1 = 0;
  reg signed [15:0] temp_x2 = 0;
  reg signed [15:0] temp_y0 = 0;
  reg signed [15:0] temp_y1 = 0;
  reg signed [15:0] temp_y2 = 0;

  reg signed [7:0] b = 4;
  reg signed [7:0] a = -1;

  assign data_out = res;

  always @(posedge clk) begin
    // Обновление задержанных значений
    temp_x0 <= data_in;
    temp_x1 <= temp_x0;
    temp_x2 <= temp_x1;
    temp_y0 <= y0;
    temp_y1 <= y1;
    temp_y2 <= y2;

    // Вычисление y(n) с учетом задержек
    y0 <= a * a * a * temp_y2;
    y1 <= a * a * b * temp_x2 + temp_y0;
    y2 <= a * b * temp_x1 + temp_y1;

    // Вычисление x(n) с учетом задержек
    x0 <= b * temp_x0;
    x1 <= b * temp_x1;
    x2 <= b * temp_x2;

    // Обновление итогового значения
    res <= x0 + x1 + x2 + y0;
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
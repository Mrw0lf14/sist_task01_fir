module fir (
  input signed [7:0] data_in,
  output signed [17:0] data_out,
  input clk
);

  reg signed [17:0] res = 0;    //регистр для выхода
  reg signed [17:0] temp = 0;   //регистр для счета
  reg [2:0] counter = 0;        //счетчик для массива
  reg [1:0] data_valid = 0;     //флаг, что прошло 10 тактов и пришли данные на вход
  reg signed [7:0] koef[0:2];   //3 коэффициента
  reg signed [7:0] data[0:2];   //последние 3 значения входа
  reg [4:0] takts = 0;          //3 такта на умножение + 1 такт на перенос значения на выход

  assign data_out = res;

  initial begin
    koef[0] = -1;
    koef[1] = 2;
    koef[2] = 3;
    data[0] = 0;
    data[1] = 0;
    data[2] = 0;
  end

  always @(posedge clk) begin
    takts <= takts + 1;
    if (takts == 9) begin
      takts <= 0;
    end
    if (takts == 0) begin
      data_valid <= 1;
      data[2] <= data[1];
      data[1] <= data[0];
      data[0] <= data_in;
      temp <= 0;
    end
    if (data_valid) begin
      if (counter < 3) begin
        temp <= temp + data[counter] * koef[counter];    //когда counter = 3, получим валидный выход
        counter <= counter + 1;
      end
      if (counter == 3) begin
        res <= temp;
        counter <= 0;
        data_valid <= 0;
      end
    end
  end

endmodule

module fir_tb;
  reg signed [7:0] data_in;
  wire signed [17:0] data_out;
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
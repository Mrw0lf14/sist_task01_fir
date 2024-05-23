module iir (
  input signed [7:0] data_in,
  output signed [17:0] data_out,
  input clk
);

  reg signed [17:0] res = 0;    //регистр для выхода
  reg signed [17:0] temp = 0;   //регистр для счета
  reg signed [7:0] kx = 5;
  reg signed [7:0] ky = 1;

  assign data_out = res;

  always @(posedge clk) begin
    temp <= data_in*kx;
    res <= temp - data_out*ky; 
  end

endmodule

module iir_tb;
  reg signed [7:0] data_in;
  wire signed [17:0] data_out;
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
    for (data_in = -7; data_in <= 7; data_in = data_in + 1) begin
      #10;
    end
    data_in = 0;
    #100;
    $finish;
  end

endmodule
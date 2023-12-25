/*
Вход:
A = Ar + jAi
B = Br + jBi
Выход(4 умножения):
Pr = Ar*Br - Ai*Bi
Pi = Ar*Bi + Ai*Br
Выход(3 умножения):
Pr = Ar*(Br+Bi) - (Ar+Ai)*Bi = ArBr + ArBi - ArBi - AiBi = ArBr - AiBi
Pi = Ar*(Br+Bi) + (Ai-Ar)*Br = ArBr + ArBi - ArBr + AiBr = ArBi + AiBr
Используем:
Pr = Ar*(Br+Bi) - (Ar+Ai)*Bi = data1-data2
Pi = Ar*(Br+Bi) + (Ai-Ar)*Br = data1+data3
*/
module complex_mul (
    input signed [7:0] ar,
    input signed [7:0] ai,
    input signed [7:0] br,
    input signed [7:0] bi,

    output reg signed [18:0] pr,
    output reg signed [18:0] pi,
    input clk
);

    reg [2:0] counter = 0;       // счетчик тактов
    reg signed [16:0] data1;     // Ar*(Br+bi)   (сумма 9 бит) * 8 бит => 17 бит
    reg signed [16:0] data2;     // (Ar+Ai)*Bi
    reg signed [16:0] data3;     // (Ai-Ar)*Br

    always @(posedge clk) begin
        counter <= counter + 1;
        case (counter)
            0: begin
                pr <= data1-data2;
                pi <= data1+data3;
                data1 <= (br+bi)*ar;
            end
            1: data2 <= (ar+ai)*bi;
            2: begin
                data3 <= (ai-ar)*br;
                counter <= 0;
            end

        endcase
    end
endmodule

module complex_mul_tb;
    reg signed [7:0] ar;
    reg signed [7:0] ai;
    reg signed [7:0] br;
    reg signed [7:0] bi;
    wire signed [18:0] pr;
    wire signed [18:0] pi;
    reg clk;

    complex_mul dut (
        .ar(ar),
        .ai(ai),
        .br(br),
        .bi(bi),
        .pr(pr),
        .pi(pi),
        .clk(clk)
    );

  initial begin
    $dumpfile("complex_mul.vcd");
    $dumpvars(0, complex_mul_tb);
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $display("Ar Ai Br Bi Pr Pi");
    for (ar = -1; ar < 2; ar = ar + 1) begin
        for (ai = -1; ai < 2; ai = ai + 1) begin
            for (br = -1; br < 2; br = br + 1) begin
                for (bi = -1; bi < 2; bi = bi + 1) begin
                    #30;
                    $display("%2d %2d %2d %2d %2d %2d", ar, ai, br, bi, pr, pi);
                end
            end
        end
    end
    #30;
    $display("%2d %2d %2d %2d %2d %2d", ar, ai, br, bi, pr, pi);
    $finish;
  end
endmodule
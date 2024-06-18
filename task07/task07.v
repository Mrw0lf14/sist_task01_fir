`timescale 1ns / 1ps

module priority_cd(in, out);  
    parameter IN_WIDTH = 4;
    localparam OUT_WIDTH = $clog2(IN_WIDTH);
    input [IN_WIDTH-1:0] in;
    output [OUT_WIDTH-1:0] out; 
    wire [OUT_WIDTH-1:0] inter [IN_WIDTH:0];
    assign inter[0] = {OUT_WIDTH{1'bX}};
    genvar i, j;
    generate
        for (i = 0; i < IN_WIDTH;i = i + 1) begin 
            assign inter[i + 1] = (in[i]) ? i : inter[i]; 
        end
    endgenerate
    assign out = inter[IN_WIDTH];
endmodule

module priority_cd_tb();
    parameter IN_WIDTH = 64;
    localparam OUT_WIDTH = $clog2(IN_WIDTH);
    reg [IN_WIDTH-1:0] in;
    wire [OUT_WIDTH-1:0] out;

    priority_cd #(.IN_WIDTH(IN_WIDTH)) uut (
        .in(in),
        .out(out)
    );
    initial begin
        $dumpfile("prior.vcd");
        $dumpvars(0, priority_cd_tb);
        in = 0;
        for (in = 0; in <= 100; in = in + 1) begin
            #1;
        end
        $finish;
    end

endmodule

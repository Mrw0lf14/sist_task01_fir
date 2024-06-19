`timescale 1ns / 1ps

module task10 #(parameter WIDTH = 8, parameter NUM = 4)(
        input clk_in,
        input [WIDTH-1:0] data_in,
        output [NUM-1:0][WIDTH-1:0] out,
        output [NUM-1:0] out_valid
    );

    reg [NUM-1:0][WIDTH-1:0] data = 'h0;
    reg [NUM-1:0] data_valid = 'h0;

    assign out = data;
    assign out_valid = data_valid;

    genvar i;
    integer j;

    wire [NUM-1:0] comp_mask;
    wire [NUM-1:0] data_mask;
    wire [NUM-1:0] shift_mask;

    assign data_mask = comp_mask ? comp_mask - 1 : comp_mask;
    assign shift_mask = data_mask ? data_mask : {NUM{1'b1}};
    generate
        for (i = 0; i < NUM; i = i + 1) 
            assign comp_mask[i] = (data[i] == data_in) & data_valid[i];
    endgenerate
    
    always@(posedge clk_in) begin
        for (j = 1; j < NUM; j = j + 1) begin 
            data[j] <= (shift_mask[j - 1]) ? data[j - 1] : data[j]; 
        end
        data[0] <= data_in;
         
        data_valid <= (data_mask) ? data_valid : (data_valid << 1) | 4'b1; 
    end
endmodule

module task10_tb();
    localparam WIDTH = 8, NUM = 4;
    reg clk_in = 'b0;
    reg [WIDTH-1:0] data_in = 'h0;
    wire [NUM-1:0][WIDTH-1:0] out;
    wire [NUM-1:0] out_valid;

    task10 #(.WIDTH(WIDTH), .NUM(NUM)) test_module (
        .clk_in(clk_in),
        .data_in(data_in),
        .out(out),
        .out_valid(out_valid)
    );
    
    integer i;
    always #5 clk_in = ~clk_in;

    initial begin
        $dumpfile("task10.vcd");
        $dumpvars(0, task10_tb);
        data_in = 'b0;
        for (i = 0; i < 3; i = i + 1)
            #10 data_in = data_in + 1;
        data_in = 'b1;
        for (i = 0; i < 40-3; i = i + 1)
            #10 data_in = ((data_in) % 4) + 1;
        $finish;
    end

endmodule
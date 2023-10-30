`timescale 1ns / 1ps
`default_nettype none

module clock(clk);
    output   clk;
    reg clk;
    initial
    begin
        clk = 0;
    end
    always
    begin
        #5;
        clk = (!clk);
    end
endmodule

module tb();
    wire clk;
    reg tb_is_finished = 0;
    clock clock0 (clk);
    reg rst;

    logic resend;
    logic config_finished;
    logic sioc;
    logic siod;
    logic reset;
    logic pwdn;

    OV2640_Controller dut (
        .clk(clk),
        .resend(resend),
        .config_finished(config_finished),
        .sioc(sioc),
        .siod(siod),
        .reset(reset),
        .pwdn(pwdn)
    );


    initial
    begin
        $dumpfile("i2c.vcd");
        $dumpvars(0, tb);

        #100;
        rst = 0;

        #100
        rst = 1;
        #100
        rst = 0;
        #100
        
        resend <= 1'b0;

        #100
        resend <= 1'b1;
        #10
        resend <= 1'b0;

        wait (config_finished == 1'b1)
            tb_is_finished <= 0;

        tb_is_finished <= 1;#20
        $finish;
    end

endmodule


`default_nettype wire

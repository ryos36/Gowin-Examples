`timescale 1ns / 1ps
`default_nettype none

module bayer_encoder #(
    parameter int DATA_WIDTH = 10
)(
    input wire clk,
    input wire reset,

    input wire vsync_i,
    input wire de_i,
    input wire [DATA_WIDTH-1:0] data_i,

    output logic de_o,
    output logic [DATA_WIDTH-1:0] data_r_o,
    output logic [DATA_WIDTH-1:0] data_g_o,
    output logic [DATA_WIDTH-1:0] data_b_o
);
    logic de_w;

    logic [DATA_WIDTH-1:0] data0_w;
    logic [DATA_WIDTH-1:0] data1_w;
    logic [DATA_WIDTH-1:0] data2_w;

    logic de_r_o, de_g_o, de_b_o;
    assign de_o = de_r_o;

    linebuffer #(
        .DATA_WIDTH(10),
        .MAX_DATA_LENGTH(640)
    )
    linebuffer0
    (
        .clk(clk),

        .vsync_i(vsync_i),
        .de_i(de_i),
        .data_i(data_i),

        .de_o(de_w),
        .data0_o(data0_w),
        .data1_o(data1_w),
        .data2_o(data2_w)
    );

    filter3x3 
    #(
        .K00(0), .K10(1),
        .K01(0), .K11(0)
    )
    filter3x3_R0 (
        .clk(clk),

        .vsync_i(vsync_i),
        .de_i(de_w),
        .data0_i(data0_w),
        .data1_i(data1_w),
        .data2_i(data2_w),

        .de_o(de_r_o),
        .data_o(data_r_o)
    );

    filter3x3 
    #(
        .K00(1), .K10(0),
        .K01(0), .K11(1)
    )
    filter3x3_G0 (
        .clk(clk),

        .vsync_i(vsync_i),
        .de_i(de_w),
        .data0_i(data0_w),
        .data1_i(data1_w),
        .data2_i(data2_w),

        .de_o(de_g_o),
        .data_o(data_g_o)
    );

    filter3x3 
    #(
        .K00(0), .K10(0),
        .K01(1), .K11(0)
    )
    filter3x3_B0 (
        .clk(clk),

        .vsync_i(vsync_i),
        .de_i(de_w),
        .data0_i(data0_w),
        .data1_i(data1_w),
        .data2_i(data2_w),

        .de_o(de_b_o),
        .data_o(data_b_o)
    );


endmodule

`ifdef TEST_BENCH_bayer

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
    localparam int DATA_WIDTH = 10;

    wire clk;
    reg rst = 0;
    reg tb_is_finished = 0;
    clock clock0 (clk);

    logic [DATA_WIDTH-1:0] out_data_r;
    logic [DATA_WIDTH-1:0] out_data_g;
    logic [DATA_WIDTH-1:0] out_data_b;
    logic out_de;
    logic de;
    logic vsync;
    logic [DATA_WIDTH-1:0] in_data;

    bayer_encoder #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    bayer0
    (
        .clk(clk),
        .reset(rst),

        .vsync_i(vsync),
        .de_i(de),
        .data_i(in_data),

        .de_o(out_de),
        .data_r_o(out_data_r),
        .data_g_o(out_data_g),
        .data_b_o(out_data_b)
    );

    //----------------------------------------------------------------
    logic [9:0] vcount;
    logic [9:0] hcount;

    logic [7:0] color_list[0:1][0:1];
    logic [7:0] base_color0;
    assign base_color0 = color_list[hcount[0]][ vcount[0]];

    initial
    begin
        $dumpfile("vcd/bayer.vcd");
        $dumpvars(0, tb);

        #100;
        rst = 0;

        #100
        rst = 1;
        #100
        rst = 0;

        de <= #1 1'b0;
        vsync <= #1 1'b0;
        vcount <= #1 'd0;
        hcount <= #1 'd0;

        /*         h  v */
        color_list[0][0] = 'h62;
        color_list[1][0] = 'h67;
        color_list[0][1] = 'h67;
        color_list[1][1] = 'h82;

        #100
        vsync <= #1 1'b1;

        #100
        vsync <= #1 1'b0;

        repeat ( 15 ) begin
            #100
            de <= #1 1'b0;
            hcount <= #1 hcount - 'd1;
            repeat ( 640 ) begin
                #10
                de <= #1 1'b1;

                case ({hcount[1],vcount[1]}) 
                2'b00: in_data <= DATA_WIDTH'({base_color0, 1'b0});
                2'b10: in_data <= DATA_WIDTH'({base_color0, 2'b0});
                2'b01: in_data <= DATA_WIDTH'({base_color0, 1'b0});
                2'b11: in_data <= DATA_WIDTH'({base_color0 - 8'h40, 3'b0});
                endcase

                hcount <= #1 hcount + 'd1;
            end
            #10
            de <= #1 1'b0;
            in_data <= #1 'dx;
            hcount <= #1 'd0;
            vcount <= #1 vcount + 'd1;
        end

        tb_is_finished = 1;#20
        $finish;
    end

endmodule

`endif

`default_nettype wire

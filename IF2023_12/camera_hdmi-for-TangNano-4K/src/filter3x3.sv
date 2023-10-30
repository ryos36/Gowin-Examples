`timescale 1ns / 1ps
`default_nettype none

module filter3x3 #(
    parameter int HEIGHT_WIDTH = 10,
    parameter int DATA_WIDTH = 10,
    parameter int ADD_DATA_WIDTH = 3,
    parameter int K00 = 1, parameter int K10 = 0,
    parameter int K01 = 0, parameter int K11 = 0
)(
    input wire clk,

    input wire vsync_i,
    input wire de_i,
    input wire [DATA_WIDTH-1:0] data0_i,
    input wire [DATA_WIDTH-1:0] data1_i,
    input wire [DATA_WIDTH-1:0] data2_i,

    output logic de_o,
    output logic [DATA_WIDTH-1:0] data_o
);

localparam int CALC_DATA_WIDTH = DATA_WIDTH + ADD_DATA_WIDTH;
localparam int K02 = K00;
localparam int K12 = K10;

logic k00;
logic k01;
logic k02_w;
logic k10;
logic k11;
logic k12_w;

logic [CALC_DATA_WIDTH-1:0] d00;
logic [CALC_DATA_WIDTH-1:0] d01;
logic [CALC_DATA_WIDTH-1:0] d02;
logic [CALC_DATA_WIDTH-1:0] d10;
logic [CALC_DATA_WIDTH-1:0] d11;
logic [CALC_DATA_WIDTH-1:0] d12;
logic [CALC_DATA_WIDTH-1:0] d20;
logic [CALC_DATA_WIDTH-1:0] d21;
logic [CALC_DATA_WIDTH-1:0] d22;

//----------------------------------------------------------------
logic de_d;
logic de_dd;
logic de_ddd;
logic de_dddd;
assign de_o = de_dddd;

always_ff @(posedge clk) begin
    de_dddd <= #1 de_ddd;
    de_ddd <= #1 de_dd;
    de_dd <= #1 de_d;
    de_d <= #1 de_i;
end

//----------------------------------------------------------------
logic negedge_de;

always_comb begin
    negedge_de = ((de_d == 1'b1) & ( de_i == 1'b0 ));
end

//----------------------------------------------------------------
logic [HEIGHT_WIDTH-1:0] vcount;
always_ff @(posedge clk) begin
    if ( vsync_i ) begin
        vcount <= #1 1'b0;
    end else begin
        if ( negedge_de ) begin
            vcount <= #1 vcount + HEIGHT_WIDTH'(1);
        end
    end
end

//----------------------------------------------------------------

always_ff @(posedge clk) begin
    if ( vsync_i ) begin
        k00 <= #1 K00;
        k01 <= #1 K01;
        k10 <= #1 K10;
        k11 <= #1 K11;
    end else if ( de_i ) begin
        k00 <= #1 k10;
        k01 <= #1 k11;
        k10 <= #1 k00;
        k11 <= #1 k01;
    end else if ( negedge_de ) begin
        if ( vcount[0] ) begin
            k00 <= #1 K00;
            k01 <= #1 K01;
            k10 <= #1 K10;
            k11 <= #1 K11;
        end else begin
            k00 <= #1 K01;
            k01 <= #1 K02;
            k10 <= #1 K11;
            k11 <= #1 K12;
        end
    end
end

//----------------------------------------------------------------
logic [CALC_DATA_WIDTH-1:0] di0;
logic [CALC_DATA_WIDTH-1:0] di1;
logic [CALC_DATA_WIDTH-1:0] di2;

logic [CALC_DATA_WIDTH-1:0] d2_0_2;
logic [CALC_DATA_WIDTH-1:0] d2_0_1_2;

always_comb begin
    k02_w = k00;
    k12_w = k10;

    di0 = k00 ? {ADD_DATA_WIDTH'(0), data0_i} : CALC_DATA_WIDTH'(0);
    di1 = k01 ? {ADD_DATA_WIDTH'(0), data1_i} : CALC_DATA_WIDTH'(0);
    di2 = k02_w ? {ADD_DATA_WIDTH'(0), data2_i} : CALC_DATA_WIDTH'(0);

    d2_0_2 = d20 + d22;
    d2_0_1_2 = d2_0_2 + d21;
end

always_ff @(posedge clk) begin
    if ( de_i ) begin
        d00 <= #1 di0;
        d01 <= #1 di1;
        d02 <= #1 di2;

        d10 <= #1 d00 + di0;
        d11 <= #1 d01 + di1;
        d12 <= #1 d02 + di2;

        d20 <= #1 d10 + di0;
        d21 <= #1 d11 + di1;
        d22 <= #1 d12 + di2;

        case ({k00, k01, k10, k11})
            4'b0010: data_o <= #1 d2_0_2[DATA_WIDTH+1:2];
            4'b1000: data_o <= #1 d2_0_2[DATA_WIDTH:1];
            4'b1001: data_o <= #1 d2_0_1_2[DATA_WIDTH+1:2];
            4'b0001: data_o <= #1 d21[DATA_WIDTH:1];
            4'b0100: data_o <= #1 d21[DATA_WIDTH-1:0];
            4'b0110: data_o <= #1 d21[DATA_WIDTH-1:0];
            default: data_o <= #3 DATA_WIDTH'('dx);
        endcase
    end
end

endmodule

`ifdef TEST_BENCH_filter3x3

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

    logic vsync;
    logic de;
    logic [DATA_WIDTH-1:0] data0;
    logic [DATA_WIDTH-1:0] data1;
    logic [DATA_WIDTH-1:0] data2;

    logic de_o;
    logic [DATA_WIDTH-1:0] data_o;

    filter3x3 filter3x30 (
        .clk(clk),

        .vsync_i(vsync),
        .de_i(de),
        .data0_i(data0),
        .data1_i(data1),
        .data2_i(data2),

        .de_o(de_o),
        .data_o(data_o)
    );

    logic [9:0] vcount;
    logic [9:0] hcount;

    /* BGGR */
    logic [7:0] color_list[0:1][0:1];
    logic [7:0] base_color0;
    logic [7:0] base_color1;
    logic [7:0] base_color2;
    assign base_color0 = color_list[hcount[0]][ vcount[0]];
    assign base_color1 = color_list[hcount[0]][~vcount[0]];

    initial
    begin
        $dumpfile("vcd/filter3x3.vcd");
        $dumpvars(0, tb);

        #100;
        rst = 0;

        #100
        rst = 1;
        #100
        rst = 0;
        #100

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
                2'b00: data0 <= DATA_WIDTH'({base_color0, 1'b0});
                2'b10: data0 <= DATA_WIDTH'({base_color0, 2'b0});
                2'b01: data0 <= DATA_WIDTH'({base_color0, 1'b0});
                2'b11: data0 <= DATA_WIDTH'({base_color0 - 8'h40, 3'b0});
                endcase

                case ({hcount[1],~vcount[1]}) 
                2'b00: data1 <= DATA_WIDTH'({base_color1, 1'b0});
                2'b10: data1 <= DATA_WIDTH'({base_color1, 2'b0});
                2'b01: data1 <= DATA_WIDTH'({base_color1, 1'b0});
                2'b11: data1 <= DATA_WIDTH'({base_color1 - 8'h40, 3'b0});
                endcase

                case ({hcount[1],vcount[1]}) 
                2'b00: data2 <= DATA_WIDTH'({base_color0, 1'b0});
                2'b10: data2 <= DATA_WIDTH'({base_color0 - 8'h40, 3'b0});
                2'b01: data2 <= DATA_WIDTH'({base_color0, 1'b0});
                2'b11: data2 <= DATA_WIDTH'({base_color0, 2'b0});
                endcase

                hcount <= #1 hcount + 'd1;
            end
            #10
            de <= #1 1'b0;
            data0 <= #1 'dx;
            data1 <= #1 'dx;
            data2 <= #1 'dx;
            hcount <= #1 'd0;
            vcount <= #1 vcount + 'd1;
        end

        tb_is_finished <= 1;#20
        $finish;
    end

endmodule

`endif

`default_nettype wire

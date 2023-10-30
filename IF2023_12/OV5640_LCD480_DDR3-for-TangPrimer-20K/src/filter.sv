`timescale 1ns / 1ps
`default_nettype none

module edge_filter3x3 #(
    parameter int DATA_WIDTH = 10,
    parameter int ADD_DATA_WIDTH = 4
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

logic [CALC_DATA_WIDTH-1:0] d00;
logic [CALC_DATA_WIDTH-1:0] d01;
logic [CALC_DATA_WIDTH-1:0] d02;

logic [CALC_DATA_WIDTH-1:0] d1_0;
logic [CALC_DATA_WIDTH-1:0] d1_1;

logic [CALC_DATA_WIDTH-1:0] d2_0;
logic [CALC_DATA_WIDTH-1:0] d2_1;

logic [DATA_WIDTH-1:0] abs_d3;

//----------------------------------------------------------------
logic de_d;
logic de_dd;
logic de_ddd;
logic de_dddd;
logic de_ddddd;
assign de_o = de_ddddd;

always_ff @(posedge clk) begin
    de_ddddd <= #1 de_dddd;
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
logic [CALC_DATA_WIDTH-1:0] di0;
logic [CALC_DATA_WIDTH-1:0] di1_x_4;
logic [CALC_DATA_WIDTH-1:0] di2;

logic [CALC_DATA_WIDTH-1:0] d00_d02;
logic [CALC_DATA_WIDTH-1:0] d01_di1_x_4;

logic [CALC_DATA_WIDTH-1:0] d1_0_di0;
logic [CALC_DATA_WIDTH-1:0] d1_1_di2;

logic [CALC_DATA_WIDTH-1:0] d3;
logic [DATA_WIDTH:0] d3_out;

always_comb begin
    di0 = {ADD_DATA_WIDTH'(0), data0_i};
    di1_x_4 = ~({(ADD_DATA_WIDTH-2)'(0), data1_i, 2'b00} - ADD_DATA_WIDTH'(1));
    di2 = {ADD_DATA_WIDTH'(0), data2_i};

    d00_d02 = d00 + d02;
    d01_di1_x_4 = d01 + di1_x_4;

    d1_0_di0 = d1_0 + di0;
    d1_1_di2 = d1_1 + di2;

    d3 = d2_0 + d2_1;

end

assign abs_d3 = d3_out[DATA_WIDTH]?(d3_out[DATA_WIDTH-1:0] + 1):d3_out[DATA_WIDTH-1:0];

always_ff @(posedge clk) begin
    if ( de_i ) begin
        d00 <= #1 di0;
        d01 <= #1 CALC_DATA_WIDTH'(0);
        d02 <= #1 di2;

        d1_0 <= #1 d00_d02;
        d1_1 <= #1 d01_di1_x_4;

        d2_0 <= #1 d1_0_di0;
        d2_1 <= #1 d1_1_di2;

        d3_out <= #1 d3[CALC_DATA_WIDTH-1:ADD_DATA_WIDTH-1];
        data_o <= #1 abs_d3;
    end
end

endmodule

`ifdef TEST_BENCH_edge_filter3x3

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
    localparam int DATA_WIDTH = 8;

    wire clk;
    reg rst = 0;
    reg tb_is_finished = 0;
    clock clock0 (clk);

    logic [7:0] hcount;
    logic [7:0] vcount;

    logic vsync;
    logic de;
    logic [DATA_WIDTH-1:0] data0;
    logic [DATA_WIDTH-1:0] data1;
    logic [DATA_WIDTH-1:0] data2;

    logic de_o;
    logic [DATA_WIDTH-1:0] data_o;

    edge_filter3x3 
    #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    filter3x3_0 (
        .clk(clk),

        .vsync_i(vsync),
        .de_i(de),
        .data0_i(data0),
        .data1_i(data1),
        .data2_i(data2),

        .de_o(de_o),
        .data_o(data_o)
    );

    /* RGB */
    logic [DATA_WIDTH-1:0] color_list[0:3][0:2];

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
        hcount <= #1 'd0;
        vcount <= #1 'd0;

        color_list[0][0] = 'h62;
        color_list[0][1] = 'h00;
        color_list[0][2] = 'h67;

        color_list[1][0] = 'h00;
        color_list[1][1] = 'h82;
        color_list[1][2] = 'h00;

        color_list[2][0] = 'h67;
        color_list[2][1] = 'h00;
        color_list[2][2] = 'h82;

        color_list[3][0] = 'h00;
        color_list[3][1] = 'h82;
        color_list[3][2] = 'h00;

        #100
        vsync <= #1 1'b1;

        #100
        vsync <= #1 1'b0;

        repeat ( 15 ) begin
            #100
            de <= #1 1'b0;
            hcount <= #1 'd0;
            #100
            hcount <= #1 hcount - 'd1;
            repeat ( 15 ) begin
                #10
                de <= #1 1'b1;

                data0 <= color_list[hcount[1:0]][0];
                data1 <= color_list[hcount[1:0]][1];
                data2 <= color_list[hcount[1:0]][2];

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

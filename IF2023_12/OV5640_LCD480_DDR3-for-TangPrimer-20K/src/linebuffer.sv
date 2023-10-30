`timescale 1ns / 1ps
`default_nettype none

module linebuffer #(
    parameter int DATA_WIDTH = 10,
    parameter int MAX_DATA_LENGTH = 1024
)(
    input wire clk,

    input wire vsync_i,
    input wire de_i,
    input wire [DATA_WIDTH-1:0] data_i,

    output logic de_o,
    output logic [DATA_WIDTH-1:0] data0_o,
    output logic [DATA_WIDTH-1:0] data1_o,
    output logic [DATA_WIDTH-1:0] data2_o
);

localparam int MAX_DATA_WIDTH = $clog2(MAX_DATA_LENGTH);

logic [DATA_WIDTH-1:0] data0_buf[0:MAX_DATA_LENGTH-1];
logic [DATA_WIDTH-1:0] data1_buf[0:MAX_DATA_LENGTH-1];
logic data_buf_w;
logic de_d;
logic [MAX_DATA_WIDTH-1:0] hcount;
logic vcount;

logic negedge_de;

always_comb begin
    negedge_de = ((de_d == 1'b1) & ( de_i == 1'b0 ));
end

always_ff @(posedge clk) begin
    if ( vsync_i ) begin
        data_buf_w <= #1 1'b0;
    end else begin
        if ( negedge_de ) begin
            data_buf_w <= #1 ~data_buf_w;
        end
    end

    de_d <= #1 de_i;
end

always_ff @(posedge clk) begin
    if ( de_i ) begin
        if ( data_buf_w == 1'b0 ) begin
            data0_buf[hcount] <= #1 data_i;
        end else begin
            data1_buf[hcount] <= #1 data_i;
        end
    end
end

always_ff @(posedge clk) begin
    if ( vsync_i ) begin
        vcount <= #1 1'b0;
    end else begin
        if ( negedge_de ) begin
            vcount <= #1 1'b1;
        end
    end
end

logic de_o_w;

always_comb begin
    de_o_w = (vcount & de_i);
end

always_ff @(posedge clk) begin
    de_o <= #1 de_o_w;
end

always_ff @(posedge clk) begin
    if ( de_o_w ) begin
        if ( data_buf_w == 1'b0 ) begin
            data1_o <= #1 data1_buf[hcount];
            data0_o <= #1 data0_buf[hcount];
        end else begin
            data1_o <= #1 data0_buf[hcount];
            data0_o <= #1 data1_buf[hcount];
        end
        data2_o <= #1 data_i;
    end
end 

always_ff @(posedge clk) begin
    if ( vsync_i ) begin
        hcount <= #1 MAX_DATA_WIDTH'(0);
    end else if ( de_i ) begin
        hcount <= #1 hcount + MAX_DATA_WIDTH'(1);
    end else begin
        hcount <= #1 MAX_DATA_WIDTH'(0);
    end
end

`ifdef DEBUG_MAX_DATA_WIDTH
    initial
    begin
        $display(MAX_DATA_WIDTH);
    end
`endif

endmodule

`ifdef TEST_BENCH_linebuffer

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
    localparam int MAX_DATA_LENGTH = 480;

    wire clk;
    reg rst = 0;
    reg tb_is_finished = 0;
    clock clock0 (clk);

    wire [DATA_WIDTH-1:0] out_data0_w;
    wire [DATA_WIDTH-1:0] out_data1_w;
    wire [DATA_WIDTH-1:0] out_data2_w;
    wire out_de_w;

    logic vsync;
    logic de;
    logic [DATA_WIDTH-1:0] data;
    logic [DATA_WIDTH-1:0] save_data;

    linebuffer #(
        .DATA_WIDTH(DATA_WIDTH),
        .MAX_DATA_LENGTH(MAX_DATA_LENGTH)
    )
    linebuffer0
    (
        .clk(clk),

        .vsync_i(vsync),
        .de_i(de),
        .data_i(data),

        .de_o(out_de_w),
        .data0_o(out_data0_w),
        .data1_o(out_data1_w),
        .data2_o(out_data2_w)
    );

    initial
    begin
        $dumpfile("vcd/linebuffer.vcd");
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
        #10 
        vsync <= #1 1'b1;
        #30 
        vsync <= #1 1'b0;
        save_data <= #1 10'd0;

        repeat ( 5 ) begin
            #10 
            de <= #1 1'b1;
            data <= #1 save_data;

            repeat ( MAX_DATA_LENGTH - 1 ) begin
                #10 
                de <= #1 1'b1;
                data <= #1 data + 10'd1;
            end
            
            #10 
            de <= #1 1'b0;
            data <= #1 10'dx;
            save_data <= #1 data;
            #100 
            de <= #1 1'b0;
        end

        repeat ( MAX_DATA_LENGTH ) begin
            #10
            de <= #1 1'b1;
        end

        #10 
        de <= #1 1'b0;

        tb_is_finished <= 1;#20
        $finish;
    end

endmodule

`endif

`default_nettype wire

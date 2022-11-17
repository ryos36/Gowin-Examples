
`default_nettype none

module top(
    input wire clk,

    output wire uart_tx,
    input wire uart_rx,

    output wire tmds_clk_n,
    output wire tmds_clk_p,
    output wire [2:0] tmds_d_n,
    output wire [2:0] tmds_d_p,

    input wire sw1_i,
    input wire sw2_i,
    output wire [5:0] led_o
);

    logic i_tx_en;
    logic [2:0] waddr;
    logic [7:0] wdata;

    logic i_rx_en;
    logic [2:0] raddr;
    logic [7:0] rdata;

    UART_MASTER_Top uart0 (
        .I_CLK(clk), //input I_CLK
        .I_RESETN(1'b1), //input I_RESETN
        .I_TX_EN(i_tx_en), //input I_TX_EN
        .I_WADDR(waddr), //input [2:0] I_WADDR
        .I_WDATA(wdata), //input [7:0] I_WDATA
        .I_RX_EN(i_rx_en), //input I_RX_EN
        .I_RADDR(raddr), //input [2:0] I_RADDR
        .O_RDATA(rdata), //output [7:0] O_RDATA

        .SIN(uart_rx), //input SIN
        .SOUT(uart_tx), //output SOUT


        .DCDn(1'b0), //input DCDn
        .CTSn(1'b0), //input CTSn
        .DSRn(1'b0), //input DSRn
        .RIn(1'b0) //input RIn
    );

wire term_out_tready_w;
wire term_in_tvalid_w;
wire [7:0] term_in_tdata_w;


UART2AXIS_m uart2axis0
(
    .clk(clk),
    .rst(1'b0),

    .term_out_tdata(term_in_tdata_w),
    .term_out_tvalid(term_in_tvalid_w),
    .term_out_tready(term_out_tready_w),

    .i_tx_en(i_tx_en),
    .waddr(waddr),
    .wdata(wdata),

    .i_rx_en(i_rx_en),
    .raddr(raddr),
    .rdata(rdata)
);


wire lock_w;
wire memory_clk_w;
wire clkoutd3_w;
wire clk_d_w;

Gowin_rPLL PLL_U0(
    .clkout(memory_clk_w), //output clkout
    .lock(lock_w), //output lock

    .clkoutd(clk_d_w), //output clkoutd
    .clkoutd3(clkoutd3_w), //output clkoutd3

    .clkin(clk) //input clkin
);

wire clk_pixel;
wire clk_5x_pixel;
wire clk_5x_pixel_lock_w;

assign clk_5x_pixel = memory_clk_w;
assign clk_5x_pixel_lock_w = lock_w;

Gowin_CLKDIV CLKDIV_for_640x480(
    .clkout(clk_pixel), //output clkout
    .hclkin(clk_5x_pixel), //input hclkin
    .resetn(1'b1) //input resetn
);

svo_hdmi_top HDMI0 (
    .clk(clk),
    .resetn(1'b1),

    .clk_pixel(clk_pixel),
    .clk_5x_pixel(clk_5x_pixel),
    .locked(clk_5x_pixel_lock_w),

    .term_in_tvalid(term_in_tvalid_w),
    .term_out_tready(term_out_tready_w),
    .term_in_tdata(term_in_tdata_w),

    // output signals
    .tmds_clk_n(tmds_clk_n),
    .tmds_clk_p(tmds_clk_p),
    .tmds_d_n(tmds_d_n),
    .tmds_d_p(tmds_d_p)
);

endmodule

`default_nettype wire

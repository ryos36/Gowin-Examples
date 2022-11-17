`default_nettype none

module top (
  input wire clk,

  output wire uart_tx,
  input wire uart_rx
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

    Echo_m echo0 (
        .clk(clk),
        .rst(1'b0),

        .i_tx_en(i_tx_en),
        .waddr(waddr),
        .wdata(wdata),
        .raddr(raddr),
        .i_rx_en(i_rx_en),
        .rdata(rdata)
    );

endmodule

`default_nettype wire

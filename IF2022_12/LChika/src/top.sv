`default_nettype none

module top (
  input wire clk,

  input wire sw0,
  input wire sw1,

  output wire [5:0] led_output
);
    logic led;

    assign led_output = {6{led}};

    LChika_m lchika (
        .clk(clk),
        .rst(1'b0),
        .led(led)
    );

endmodule

`default_nettype wire


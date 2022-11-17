module test
  (
    
  );

  //localparams
  localparam CLK_PERIOD = 10;
  localparam CLK_HALF_PERIOD = 5;
  localparam INITIAL_RESET_SPAN = 100;
  localparam test_b1_INIT = 0;
  localparam test_b1_FINISH = 1;
  
  //signals: 
  reg clk;
  reg rst;
  reg        [1:0] test_state;
  //sub modules
  //matrix_m instance
  LEDMatrixAB_m matrix_m(
    .clk(clk),
    .rst(rst),
    .swA(1'd0),
    .swB(1'd0)
  );
  
  
  initial begin
    clk = 0;
    #CLK_HALF_PERIOD
    forever #CLK_HALF_PERIOD clk = ~clk;
  end
  initial begin
    rst <= 1;
    #INITIAL_RESET_SPAN
    rst <= 0;
  end
  

  always @(posedge clk) begin
    if (rst) begin
      test_state <= test_b1_INIT;
    end else begin //if (rst)
      case(test_state)
      test_b1_INIT: begin
        test_state <= test_b1_FINISH;
      end
      test_b1_FINISH: begin
        $display("%5t:finish", $time);
        $finish();
      end
      endcase
    end
  end
  

endmodule


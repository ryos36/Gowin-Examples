module test
  (
    
  );

  //localparams
  localparam CLK_PERIOD = 10;
  localparam CLK_HALF_PERIOD = 5;
  localparam INITIAL_RESET_SPAN = 100;
  localparam test_b1_INIT = 0;
  localparam test_b1_S2 = 1;
  localparam test_b1_S3 = 2;
  localparam test_b1_S4 = 3;
  localparam test_b1_S5 = 4;
  localparam test_b1_S6 = 5;
  localparam test_b1_S7 = 6;
  localparam test_b1_S8 = 7;
  localparam test_b1_S9 = 8;
  localparam test_b1_S10 = 9;
  localparam test_b1_S11 = 10;
  localparam test_b1_S12 = 11;
  localparam test_b1_FINISH = 12;
  
  //signals: 
  reg clk;
  reg rst;
  reg        [3:0] test_state;
  //signals: term_out_tready
  reg axis_m_term_out_tready;
  //signals: term_out_tvalid
  wire axis_m_term_out_tvalid;
  //sub modules
  //axis_m instance
  UART2AXIS_m axis_m(
    .clk(clk),
    .rst(rst),
    .rdata(8'd0),
    .term_out_tready(axis_m_term_out_tready),
    .term_out_tvalid(axis_m_term_out_tvalid)
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
      axis_m_term_out_tready <= 0;
      test_state <= test_b1_INIT;
    end else begin //if (rst)
      case(test_state)
      test_b1_INIT: begin
        axis_m_term_out_tready <= 1;
        test_state <= test_b1_S2;
      end
      test_b1_S2: begin
        if (axis_m_term_out_tvalid == 1) begin
          /*wait a cycle*/
          test_state <= test_b1_S4;
        end
      end
      test_b1_S4: begin
        /*wait a cycle*/
        test_state <= test_b1_S5;
      end
      test_b1_S5: begin
        /*wait a cycle*/
        test_state <= test_b1_S6;
      end
      test_b1_S6: begin
        /*wait a cycle*/
        test_state <= test_b1_S7;
      end
      test_b1_S7: begin
        /*wait a cycle*/
        test_state <= test_b1_S8;
      end
      test_b1_S8: begin
        /*wait a cycle*/
        test_state <= test_b1_S9;
      end
      test_b1_S9: begin
        /*wait a cycle*/
        test_state <= test_b1_S10;
      end
      test_b1_S10: begin
        /*wait a cycle*/
        test_state <= test_b1_S11;
      end
      test_b1_S11: begin
        /*wait a cycle*/
        test_state <= test_b1_S12;
      end
      test_b1_S12: begin
        /*wait a cycle*/
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


module test
  (
    
  );

  //localparams
  localparam CLK_PERIOD = 10;
  localparam CLK_HALF_PERIOD = 5;
  localparam INITIAL_RESET_SPAN = 100;
  localparam test_b1_INIT = 0;
  localparam test_b1_S2 = 1;
  localparam test_ifthen2_S0 = 2;
  localparam test_ifthen2_S1 = 3;
  localparam test_ifelse5_S0 = 4;
  localparam test_ifelse5_S1 = 5;
  localparam test_b6_S0 = 6;
  localparam test_b6_S1 = 7;
  localparam test_b6_S2 = 8;
  localparam test_ifthen7_S0 = 9;
  localparam test_ifthen7_S1 = 10;
  localparam test_ifelse10_S0 = 11;
  localparam test_ifelse10_S1 = 12;
  localparam test_b11_S0 = 13;
  localparam test_b11_S1 = 14;
  localparam test_b11_S2 = 15;
  localparam test_ifthen12_S0 = 16;
  localparam test_ifthen12_S1 = 17;
  localparam test_ifelse15_S0 = 18;
  localparam test_ifelse15_S1 = 19;
  localparam test_b16_S0 = 20;
  localparam test_b16_FINISH = 21;
  
  //signals: 
  wire c574;
  wire c576;
  wire c578;
  wire c611;
  wire c612;
  wire c613;
  wire c648;
  wire c649;
  wire c650;
  reg clk;
  reg rst;
  reg t573;
  reg t575;
  reg t577;
  reg        [4:0] test_state;
  //signals: led
  wire lchika_m_led;
  //combinations: 
  assign c574 = (t573 != 0);
  assign c576 = (t575 != 0);
  assign c578 = (t577 != 0);
  assign c611 = !c574;
  assign c612 = !c576;
  assign c613 = !c578;
  assign c648 = !c574;
  assign c649 = !c576;
  assign c650 = !c578;
  //sub modules
  //lchika_m instance
  LChika_m lchika_m(
    .clk(clk),
    .rst(rst),
    .led(lchika_m_led)
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
      t573 <= 0;
      t575 <= 0;
      t577 <= 0;
      test_state <= test_b1_INIT;
    end else begin //if (rst)
      case(test_state)
      test_b1_INIT: begin
        t573 <= lchika_m_led;
        test_state <= test_b1_S2;
      end
      test_b1_S2: begin
        /* c574 <= (t573 != 0); */
        if (c574) begin
          $display("%s", "LED off");
          test_state <= test_b6_S0;
        end else begin
          /* c648 <= !c574; */
          /* c611 <= !c574; */
          $display("%s", "LED on");
          test_state <= test_b6_S0;
        end
      end
      test_b6_S0: begin
        if (lchika_m_led == 0) begin
          t575 <= lchika_m_led;
          test_state <= test_b6_S2;
        end
      end
      test_b6_S2: begin
        /* c576 <= (t575 != 0); */
        if (c576) begin
          $display("%s", "LED off");
          test_state <= test_b11_S0;
        end else begin
          /* c649 <= !c576; */
          /* c612 <= !c576; */
          $display("%s", "LED on");
          test_state <= test_b11_S0;
        end
      end
      test_b11_S0: begin
        if (lchika_m_led == 1) begin
          t577 <= lchika_m_led;
          test_state <= test_b11_S2;
        end
      end
      test_b11_S2: begin
        /* c578 <= (t577 != 0); */
        if (c578) begin
          $display("%s", "LED off");
          test_state <= test_b16_S0;
        end else begin
          /* c650 <= !c578; */
          /* c613 <= !c578; */
          $display("%s", "LED on");
          test_state <= test_b16_S0;
        end
      end
      test_b16_S0: begin
        test_state <= test_b16_FINISH;
      end
      test_b16_FINISH: begin
        $display("%5t:finish", $time);
        $finish();
      end
      endcase
    end
  end
  

endmodule


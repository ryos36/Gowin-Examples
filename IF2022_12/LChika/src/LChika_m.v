module LChika_m
  (
    input wire clk,
    input wire rst,
    output reg led = 1
  );

  //localparams
  localparam LChika_m_main_c7_b1_INIT = 0;
  localparam LChika_m_main_c7_b1_S1 = 1;
  localparam LChika_m_main_c7_b1_FINISH = 2;
  localparam LChika_m_main_c7_L1_while2_S0 = 3;
  localparam LChika_m_main_c7_L1_while2_S1 = 4;
  localparam LChika_m_main_c7_L1_forelse6_S0 = 5;
  localparam LChika_m_main_c7_L1_forelse6_S1 = 6;
  localparam LChika_m_main_c7_L2_fortest4_S0 = 7;
  localparam LChika_m_main_c7_L2_forbody5_S0 = 8;
  localparam LChika_m_main_c7_L2_forbody5_S1 = 9;
  
  //signals: 
  wire m_main_c7_c570_inl1;
  wire m_main_c7_led3;
  reg m_main_c7_led2;
  reg        [3:0] m_main_c7_state;
  wire signed [31:0] interval;
  wire signed [31:0] m_main_c7_i_inl14;
  wire signed [31:0] m_main_c7_t567_inl1;
  reg signed [31:0] m_main_c7_i_inl13;
  //combinations: 
  assign interval = 27000000;
  assign m_main_c7_c570_inl1 = (m_main_c7_i_inl13 < m_main_c7_t567_inl1);
  assign m_main_c7_i_inl14 = (m_main_c7_i_inl13 + 1);
  assign m_main_c7_led3 = !m_main_c7_led2;
  assign m_main_c7_t567_inl1 = (interval / 2);
  
  always @(posedge clk) begin
    if (rst) begin
      led <= 1;
      m_main_c7_i_inl13 <= 0;
      m_main_c7_led2 <= 0;
      m_main_c7_state <= LChika_m_main_c7_b1_INIT;
    end else begin //if (rst)
      case(m_main_c7_state)
      LChika_m_main_c7_b1_INIT: begin
        m_main_c7_led2 <= 1;
        m_main_c7_state <= LChika_m_main_c7_L1_while2_S0;
      end
      LChika_m_main_c7_L1_while2_S0: begin
        led <= m_main_c7_led2;
        /* m_main_c7_led3 <= !m_main_c7_led2; */
        /* m_main_c7_t567_inl1 <= (interval / 2); */
        m_main_c7_i_inl13 <= 0;
        m_main_c7_state <= LChika_m_main_c7_L2_fortest4_S0;
      end
      LChika_m_main_c7_L2_fortest4_S0: begin
        /* m_main_c7_c570_inl1 <= (m_main_c7_i_inl13 < m_main_c7_t567_inl1); */
        if (m_main_c7_c570_inl1) begin
          /* m_main_c7_i_inl14 <= (m_main_c7_i_inl13 + 1); */
          m_main_c7_i_inl13 <= m_main_c7_i_inl14;
          m_main_c7_state <= LChika_m_main_c7_L2_fortest4_S0;
        end else begin
          m_main_c7_led2 <= m_main_c7_led3;
          m_main_c7_state <= LChika_m_main_c7_L1_while2_S0;
        end
      end
      endcase
    end
  end
  

endmodule


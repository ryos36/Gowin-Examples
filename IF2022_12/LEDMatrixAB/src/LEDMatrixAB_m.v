module LEDMatrixAB_m
  (
    input wire clk,
    input wire rst,
    input wire swA,
    input wire swB,
    output reg [7:0] col = 0,
    output reg [7:0] row = 0
  );

  //localparams
  localparam LEDMatrixAB_m_main_cd_b1_INIT = 0;
  localparam LEDMatrixAB_m_main_cd_b1_S1 = 1;
  localparam LEDMatrixAB_m_main_cd_b1_FINISH = 2;
  localparam LEDMatrixAB_m_main_cd_L1_while2_S0 = 3;
  localparam LEDMatrixAB_m_main_cd_L1_while2_S1 = 4;
  localparam LEDMatrixAB_m_main_cd_L1_while2_S2 = 5;
  localparam LEDMatrixAB_m_main_cd_L1_while2_S3 = 6;
  localparam LEDMatrixAB_m_main_cd_L1_while2_S4 = 7;
  localparam LEDMatrixAB_m_main_cd_L1_forelse6_S0 = 8;
  localparam LEDMatrixAB_m_main_cd_L1_forelse6_S1 = 9;
  localparam LEDMatrixAB_m_main_cd_L2_fortest4_S0 = 10;
  localparam LEDMatrixAB_m_main_cd_L2_forbody5_S0 = 11;
  localparam LEDMatrixAB_m_main_cd_L2_forbody5_S1 = 12;
  
  //signals: 
  wire m_main_cd_c582_inl1;
  wire m_main_cd_c585;
  wire m_main_cd_c586;
  wire m_main_cd_c587;
  wire m_main_cd_c588;
  wire m_main_cd_c589;
  wire m_main_cd_c590;
  wire m_main_cd_c591;
  wire m_main_cd_c592;
  wire m_main_cd_c593;
  reg m_main_cd_a;
  reg m_main_cd_b;
  reg        [3:0] m_main_cd_state;
  wire signed [31:0] interval;
  wire signed [31:0] m_main_cd_i_inl14;
  wire signed [31:0] m_main_cd_row_cnt3;
  wire signed [31:0] m_main_cd_t578_inl1;
  wire signed [31:0] m_main_cd_t597;
  wire signed [31:0] m_main_cd_t598;
  wire signed [31:0] m_main_cd_t599;
  wire signed [31:0] m_main_cd_t600;
  wire signed [31:0] m_main_cd_t658;
  wire signed [31:0] m_main_cd_t659;
  wire signed [31:0] m_main_cd_t660;
  reg signed [31:0] m_main_cd_i_inl13;
  reg signed [31:0] m_main_cd_row_cnt2;
  //combinations: 
  function [31:0] FONT_DATA (
    input [5:0] FONT_DATA_in
  );
  begin
    case (FONT_DATA_in)
      0: begin
        FONT_DATA = 0;
      end
      1: begin
        FONT_DATA = 0;
      end
      2: begin
        FONT_DATA = 0;
      end
      3: begin
        FONT_DATA = 0;
      end
      4: begin
        FONT_DATA = 0;
      end
      5: begin
        FONT_DATA = 0;
      end
      6: begin
        FONT_DATA = 0;
      end
      7: begin
        FONT_DATA = 0;
      end
      8: begin
        FONT_DATA = 16;
      end
      9: begin
        FONT_DATA = 40;
      end
      10: begin
        FONT_DATA = 68;
      end
      11: begin
        FONT_DATA = 130;
      end
      12: begin
        FONT_DATA = 254;
      end
      13: begin
        FONT_DATA = 130;
      end
      14: begin
        FONT_DATA = 130;
      end
      15: begin
        FONT_DATA = 0;
      end
      16: begin
        FONT_DATA = 252;
      end
      17: begin
        FONT_DATA = 130;
      end
      18: begin
        FONT_DATA = 130;
      end
      19: begin
        FONT_DATA = 252;
      end
      20: begin
        FONT_DATA = 130;
      end
      21: begin
        FONT_DATA = 130;
      end
      22: begin
        FONT_DATA = 252;
      end
      23: begin
        FONT_DATA = 0;
      end
      24: begin
        FONT_DATA = 96;
      end
      25: begin
        FONT_DATA = 128;
      end
      26: begin
        FONT_DATA = 128;
      end
      27: begin
        FONT_DATA = 102;
      end
      28: begin
        FONT_DATA = 9;
      end
      29: begin
        FONT_DATA = 9;
      end
      30: begin
        FONT_DATA = 6;
      end
      31: begin
        FONT_DATA = 1;
      end
    endcase
  end
  endfunction
  assign interval = 2700;
  assign m_main_cd_c582_inl1 = (m_main_cd_i_inl13 < m_main_cd_t578_inl1);
  assign m_main_cd_c585 = (m_main_cd_a == 0);
  assign m_main_cd_c586 = (m_main_cd_b == 1);
  assign m_main_cd_c587 = (m_main_cd_c585 && m_main_cd_c586);
  assign m_main_cd_c588 = (m_main_cd_a == 1);
  assign m_main_cd_c589 = (m_main_cd_b == 0);
  assign m_main_cd_c590 = (m_main_cd_c588 && m_main_cd_c589);
  assign m_main_cd_c591 = (m_main_cd_a == 0);
  assign m_main_cd_c592 = (m_main_cd_b == 0);
  assign m_main_cd_c593 = (m_main_cd_c591 && m_main_cd_c592);
  assign m_main_cd_i_inl14 = (m_main_cd_i_inl13 + 1);
  assign m_main_cd_row_cnt3 = (m_main_cd_t600 & 7);
  assign m_main_cd_t578_inl1 = (interval / 2);
  assign m_main_cd_t597 = (m_main_cd_t660 + m_main_cd_row_cnt2);
  assign m_main_cd_t598 = FONT_DATA(m_main_cd_t597);
  assign m_main_cd_t599 = (1 << m_main_cd_row_cnt2);
  assign m_main_cd_t600 = (m_main_cd_row_cnt2 + 1);
  assign m_main_cd_t658 = m_main_cd_c593 ? 24 : 0;
  assign m_main_cd_t659 = m_main_cd_c590 ? 16 : m_main_cd_t658;
  assign m_main_cd_t660 = m_main_cd_c587 ? 8 : m_main_cd_t659;
  
  always @(posedge clk) begin
    if (rst) begin
      col <= 0;
      m_main_cd_a <= 0;
      m_main_cd_b <= 0;
      m_main_cd_i_inl13 <= 0;
      m_main_cd_row_cnt2 <= 0;
      row <= 0;
      m_main_cd_state <= LEDMatrixAB_m_main_cd_b1_INIT;
    end else begin //if (rst)
      case(m_main_cd_state)
      LEDMatrixAB_m_main_cd_b1_INIT: begin
        m_main_cd_row_cnt2 <= 0;
        m_main_cd_state <= LEDMatrixAB_m_main_cd_L1_while2_S0;
      end
      LEDMatrixAB_m_main_cd_L1_while2_S0: begin
        m_main_cd_a <= swA;
        /* m_main_cd_t599 <= (1 << m_main_cd_row_cnt2); */
        /* m_main_cd_t600 <= (m_main_cd_row_cnt2 + 1); */
        /* m_main_cd_t578_inl1 <= (interval / 2); */
        m_main_cd_i_inl13 <= 0;
        /* m_main_cd_row_cnt3 <= (m_main_cd_t600 & 7); */
        m_main_cd_state <= LEDMatrixAB_m_main_cd_L1_while2_S1;
      end
      LEDMatrixAB_m_main_cd_L1_while2_S1: begin
        m_main_cd_b <= swB;
        /* m_main_cd_c585 <= (m_main_cd_a == 0); */
        /* m_main_cd_c588 <= (m_main_cd_a == 1); */
        /* m_main_cd_c591 <= (m_main_cd_a == 0); */
        m_main_cd_state <= LEDMatrixAB_m_main_cd_L1_while2_S2;
      end
      LEDMatrixAB_m_main_cd_L1_while2_S2: begin
        col <= m_main_cd_t598;
        /* m_main_cd_c586 <= (m_main_cd_b == 1); */
        /* m_main_cd_c589 <= (m_main_cd_b == 0); */
        /* m_main_cd_c592 <= (m_main_cd_b == 0); */
        /* m_main_cd_c587 <= (m_main_cd_c585 && m_main_cd_c586); */
        /* m_main_cd_c590 <= (m_main_cd_c588 && m_main_cd_c589); */
        /* m_main_cd_c593 <= (m_main_cd_c591 && m_main_cd_c592); */
        /* m_main_cd_t658 <= m_main_cd_c593 ? 24 : 0; */
        /* m_main_cd_t659 <= m_main_cd_c590 ? 16 : m_main_cd_t658; */
        /* m_main_cd_t660 <= m_main_cd_c587 ? 8 : m_main_cd_t659; */
        /* m_main_cd_t597 <= (m_main_cd_t660 + m_main_cd_row_cnt2); */
        /* m_main_cd_t598 <= FONT_DATA(m_main_cd_t597); */
        m_main_cd_state <= LEDMatrixAB_m_main_cd_L1_while2_S3;
      end
      LEDMatrixAB_m_main_cd_L1_while2_S3: begin
        row <= m_main_cd_t599;
        m_main_cd_state <= LEDMatrixAB_m_main_cd_L2_fortest4_S0;
      end
      LEDMatrixAB_m_main_cd_L2_fortest4_S0: begin
        /* m_main_cd_c582_inl1 <= (m_main_cd_i_inl13 < m_main_cd_t578_inl1); */
        if (m_main_cd_c582_inl1) begin
          /* m_main_cd_i_inl14 <= (m_main_cd_i_inl13 + 1); */
          m_main_cd_i_inl13 <= m_main_cd_i_inl14;
          m_main_cd_state <= LEDMatrixAB_m_main_cd_L2_fortest4_S0;
        end else begin
          m_main_cd_row_cnt2 <= m_main_cd_row_cnt3;
          m_main_cd_state <= LEDMatrixAB_m_main_cd_L1_while2_S0;
        end
      end
      endcase
    end
  end
  

endmodule


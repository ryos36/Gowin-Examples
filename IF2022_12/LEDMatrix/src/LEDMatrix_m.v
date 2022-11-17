module LEDMatrix_m
  (
    input wire clk,
    input wire rst,
    output reg [7:0] col = 0,
    output reg [7:0] row = 0
  );

  //localparams
  localparam LEDMatrix_m_main_c8_b1_INIT = 0;
  localparam LEDMatrix_m_main_c8_b1_S1 = 1;
  localparam LEDMatrix_m_main_c8_b1_FINISH = 2;
  localparam LEDMatrix_m_main_c8_L1_while2_S0 = 3;
  localparam LEDMatrix_m_main_c8_L1_while2_S1 = 4;
  localparam LEDMatrix_m_main_c8_L1_while2_S2 = 5;
  localparam LEDMatrix_m_main_c8_L1_forelse6_S0 = 6;
  localparam LEDMatrix_m_main_c8_L1_forelse6_S1 = 7;
  localparam LEDMatrix_m_main_c8_L2_fortest4_S0 = 8;
  localparam LEDMatrix_m_main_c8_L2_forbody5_S0 = 9;
  localparam LEDMatrix_m_main_c8_L2_forbody5_S1 = 10;
  
  //signals: 
  wire m_main_c8_c577_inl1;
  reg        [3:0] m_main_c8_state;
  wire signed [31:0] interval;
  wire signed [31:0] m_main_c8_i_inl14;
  wire signed [31:0] m_main_c8_row_cnt3;
  wire signed [31:0] m_main_c8_t573_inl1;
  wire signed [31:0] m_main_c8_t580;
  wire signed [31:0] m_main_c8_t581;
  wire signed [31:0] m_main_c8_t582;
  reg signed [31:0] m_main_c8_i_inl13;
  reg signed [31:0] m_main_c8_row_cnt2;
  //combinations: 
  function [31:0] FONT_DATA (
    input [3:0] FONT_DATA_in
  );
  begin
    case (FONT_DATA_in)
      0: begin
        FONT_DATA = 96;
      end
      1: begin
        FONT_DATA = 128;
      end
      2: begin
        FONT_DATA = 128;
      end
      3: begin
        FONT_DATA = 102;
      end
      4: begin
        FONT_DATA = 9;
      end
      5: begin
        FONT_DATA = 9;
      end
      6: begin
        FONT_DATA = 6;
      end
      7: begin
        FONT_DATA = 1;
      end
    endcase
  end
  endfunction
  assign interval = 27000;
  assign m_main_c8_c577_inl1 = (m_main_c8_i_inl13 < m_main_c8_t573_inl1);
  assign m_main_c8_i_inl14 = (m_main_c8_i_inl13 + 1);
  assign m_main_c8_row_cnt3 = (m_main_c8_t582 & 7);
  assign m_main_c8_t573_inl1 = interval;
  assign m_main_c8_t580 = FONT_DATA(m_main_c8_row_cnt2);
  assign m_main_c8_t581 = (1 << m_main_c8_row_cnt2);
  assign m_main_c8_t582 = (m_main_c8_row_cnt2 + 1);
  
  always @(posedge clk) begin
    if (rst) begin
      col <= 0;
      m_main_c8_i_inl13 <= 0;
      m_main_c8_row_cnt2 <= 0;
      row <= 0;
      m_main_c8_state <= LEDMatrix_m_main_c8_b1_INIT;
    end else begin //if (rst)
      case(m_main_c8_state)
      LEDMatrix_m_main_c8_b1_INIT: begin
        m_main_c8_row_cnt2 <= 0;
        m_main_c8_state <= LEDMatrix_m_main_c8_L1_while2_S0;
      end
      LEDMatrix_m_main_c8_L1_while2_S0: begin
        col <= m_main_c8_t580;
        /* m_main_c8_t580 <= FONT_DATA(m_main_c8_row_cnt2); */
        /* m_main_c8_t581 <= (1 << m_main_c8_row_cnt2); */
        /* m_main_c8_t582 <= (m_main_c8_row_cnt2 + 1); */
        /* m_main_c8_t573_inl1 <= interval; */
        m_main_c8_i_inl13 <= 0;
        /* m_main_c8_row_cnt3 <= (m_main_c8_t582 & 7); */
        m_main_c8_state <= LEDMatrix_m_main_c8_L1_while2_S1;
      end
      LEDMatrix_m_main_c8_L1_while2_S1: begin
        row <= m_main_c8_t581;
        m_main_c8_state <= LEDMatrix_m_main_c8_L2_fortest4_S0;
      end
      LEDMatrix_m_main_c8_L2_fortest4_S0: begin
        /* m_main_c8_c577_inl1 <= (m_main_c8_i_inl13 < m_main_c8_t573_inl1); */
        if (m_main_c8_c577_inl1) begin
          /* m_main_c8_i_inl14 <= (m_main_c8_i_inl13 + 1); */
          m_main_c8_i_inl13 <= m_main_c8_i_inl14;
          m_main_c8_state <= LEDMatrix_m_main_c8_L2_fortest4_S0;
        end else begin
          m_main_c8_row_cnt2 <= m_main_c8_row_cnt3;
          m_main_c8_state <= LEDMatrix_m_main_c8_L1_while2_S0;
        end
      end
      endcase
    end
  end
  

endmodule


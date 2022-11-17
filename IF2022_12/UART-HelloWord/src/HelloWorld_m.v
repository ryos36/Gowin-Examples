module HelloWorld_m
  (
    input wire clk,
    input wire rst,
    output reg i_tx_en = 0,
    output reg [2:0] waddr = 0,
    output reg [7:0] wdata = 0,
    output reg [2:0] raddr = 0,
    output reg i_rx_en = 0,
    input wire [7:0] rdata
  );

  //localparams
  localparam HelloWorld_m_main_ck_b1_INIT = 0;
  localparam HelloWorld_m_main_ck_b1_S1 = 1;
  localparam HelloWorld_m_main_ck_b1_S2 = 2;
  localparam HelloWorld_m_main_ck_b1_S3 = 3;
  localparam HelloWorld_m_main_ck_b1_S4 = 4;
  localparam HelloWorld_m_main_ck_b1_S5 = 5;
  localparam HelloWorld_m_main_ck_b1_S6 = 6;
  localparam HelloWorld_m_main_ck_b1_S7 = 7;
  localparam HelloWorld_m_main_ck_b1_S8 = 8;
  localparam HelloWorld_m_main_ck_b1_S9 = 9;
  localparam HelloWorld_m_main_ck_b1_S10 = 10;
  localparam HelloWorld_m_main_ck_b1_S11 = 11;
  localparam HelloWorld_m_main_ck_b1_S12 = 12;
  localparam HelloWorld_m_main_ck_b1_S13 = 13;
  localparam HelloWorld_m_main_ck_b1_S14 = 14;
  localparam HelloWorld_m_main_ck_b1_FINISH = 15;
  localparam HelloWorld_m_main_ck_L1_while2_S0 = 16;
  localparam HelloWorld_m_main_ck_L1_while2_S1 = 17;
  localparam HelloWorld_m_main_ck_L1_forelse9_S0 = 18;
  localparam HelloWorld_m_main_ck_L2_fortest4_S0 = 19;
  localparam HelloWorld_m_main_ck_L2_forbody5_S0 = 20;
  localparam HelloWorld_m_main_ck_L2_forbody5_S1 = 21;
  localparam HelloWorld_m_main_ck_L2_whileelse8_S0 = 22;
  localparam HelloWorld_m_main_ck_L2_whileelse8_S1 = 23;
  localparam HelloWorld_m_main_ck_L2_whileelse8_S2 = 24;
  localparam HelloWorld_m_main_ck_L2_whileelse8_S3 = 25;
  localparam HelloWorld_m_main_ck_L2_whileelse8_S4 = 26;
  localparam HelloWorld_m_main_ck_L2_whileelse8_S5 = 27;
  localparam HelloWorld_m_main_ck_L3_while6_S0 = 28;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S0 = 29;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S1 = 30;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S2 = 31;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S3 = 32;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S4 = 33;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S5 = 34;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S6 = 35;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S7 = 36;
  localparam HelloWorld_m_main_ck_L3_whilebody7_S8 = 37;
  
  //signals: 
  wire m_main_ck_c601;
  wire m_main_ck_c602_inl2;
  wire m_main_ck_c604_inl2;
  wire m_main_ck_c715;
  wire m_main_ck_c780;
  wire        [7:0] m_main_ck_t603_inl2;
  wire m_main_ck_tx_empty_inl25;
  reg        [5:0] m_main_ck_state;
  reg        [7:0] m_main_ck_status_inl2;
  reg m_main_ck_tx_empty_inl24;
  wire signed [31:0] m_main_ck_counter5944;
  wire signed [31:0] m_main_ck_data;
  wire signed [31:0] m_main_ck_t716;
  reg signed [31:0] m_main_ck_counter5943;
  //combinations: 
  function [31:0] MSG_DATA (
    input [4:0] MSG_DATA_in
  );
  begin
    case (MSG_DATA_in)
      0: begin
        MSG_DATA = 72;
      end
      1: begin
        MSG_DATA = 101;
      end
      2: begin
        MSG_DATA = 108;
      end
      3: begin
        MSG_DATA = 108;
      end
      4: begin
        MSG_DATA = 111;
      end
      5: begin
        MSG_DATA = 32;
      end
      6: begin
        MSG_DATA = 87;
      end
      7: begin
        MSG_DATA = 111;
      end
      8: begin
        MSG_DATA = 114;
      end
      9: begin
        MSG_DATA = 108;
      end
      10: begin
        MSG_DATA = 100;
      end
    endcase
  end
  endfunction
  assign m_main_ck_c601 = (m_main_ck_counter5943 < 11);
  assign m_main_ck_c602_inl2 = (m_main_ck_tx_empty_inl24 == 0);
  assign m_main_ck_c604_inl2 = (m_main_ck_t603_inl2 == 64);
  assign m_main_ck_c715 = (m_main_ck_c601 && m_main_ck_c602_inl2);
  assign m_main_ck_c780 = (m_main_ck_c601 && m_main_ck_c602_inl2);
  assign m_main_ck_counter5944 = (m_main_ck_counter5943 + 1);
  assign m_main_ck_data = MSG_DATA(m_main_ck_counter5943);
  assign m_main_ck_t603_inl2 = (m_main_ck_status_inl2 & 64);
  assign m_main_ck_t716 = m_main_ck_c604_inl2 ? 1 : 0;
  assign m_main_ck_tx_empty_inl25 = m_main_ck_t716;
  
  always @(posedge clk) begin
    if (rst) begin
      i_rx_en <= 0;
      i_tx_en <= 0;
      m_main_ck_counter5943 <= 0;
      m_main_ck_status_inl2 <= 0;
      m_main_ck_tx_empty_inl24 <= 0;
      raddr <= 0;
      waddr <= 0;
      wdata <= 0;
      m_main_ck_state <= HelloWorld_m_main_ck_b1_INIT;
    end else begin //if (rst)
      case(m_main_ck_state)
      HelloWorld_m_main_ck_b1_INIT: begin
        i_tx_en <= 1;
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S1;
      end
      HelloWorld_m_main_ck_b1_S1: begin
        waddr <= 3;
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S2;
      end
      HelloWorld_m_main_ck_b1_S2: begin
        wdata <= 3;
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S3;
      end
      HelloWorld_m_main_ck_b1_S3: begin
        i_tx_en <= 0;
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S4;
      end
      HelloWorld_m_main_ck_b1_S4: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S5;
      end
      HelloWorld_m_main_ck_b1_S5: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S6;
      end
      HelloWorld_m_main_ck_b1_S6: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S7;
      end
      HelloWorld_m_main_ck_b1_S7: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S8;
      end
      HelloWorld_m_main_ck_b1_S8: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S9;
      end
      HelloWorld_m_main_ck_b1_S9: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S10;
      end
      HelloWorld_m_main_ck_b1_S10: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S11;
      end
      HelloWorld_m_main_ck_b1_S11: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S12;
      end
      HelloWorld_m_main_ck_b1_S12: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_b1_S13;
      end
      HelloWorld_m_main_ck_b1_S13: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_L1_while2_S0;
      end
      HelloWorld_m_main_ck_L1_while2_S0: begin
        m_main_ck_counter5943 <= 0;
        m_main_ck_state <= HelloWorld_m_main_ck_L2_fortest4_S0;
      end
      HelloWorld_m_main_ck_L2_fortest4_S0: begin
        /* m_main_ck_c601 <= (m_main_ck_counter5943 < 11); */
        if (m_main_ck_c601) begin
          /* m_main_ck_data <= MSG_DATA(m_main_ck_counter5943); */
          m_main_ck_tx_empty_inl24 <= 0;
          m_main_ck_state <= HelloWorld_m_main_ck_L3_while6_S0;
        end else begin
          m_main_ck_state <= HelloWorld_m_main_ck_L1_while2_S0;
        end
      end
      HelloWorld_m_main_ck_L2_whileelse8_S1: begin
        wdata <= m_main_ck_data;
        m_main_ck_state <= HelloWorld_m_main_ck_L2_whileelse8_S2;
      end
      HelloWorld_m_main_ck_L2_whileelse8_S2: begin
        i_tx_en <= 1;
        m_main_ck_state <= HelloWorld_m_main_ck_L2_whileelse8_S3;
      end
      HelloWorld_m_main_ck_L2_whileelse8_S3: begin
        i_tx_en <= 0;
        m_main_ck_state <= HelloWorld_m_main_ck_L2_whileelse8_S4;
      end
      HelloWorld_m_main_ck_L2_whileelse8_S4: begin
        /* m_main_ck_counter5944 <= (m_main_ck_counter5943 + 1); */
        m_main_ck_counter5943 <= m_main_ck_counter5944;
        m_main_ck_state <= HelloWorld_m_main_ck_L2_fortest4_S0;
      end
      HelloWorld_m_main_ck_L3_while6_S0: begin
        /* m_main_ck_c602_inl2 <= (m_main_ck_tx_empty_inl24 == 0); */
        if (m_main_ck_c602_inl2) begin
          raddr <= 5;
          /* m_main_ck_c780 <= (m_main_ck_c601 && m_main_ck_c602_inl2); */
          /* m_main_ck_c715 <= (m_main_ck_c601 && m_main_ck_c602_inl2); */
          m_main_ck_state <= HelloWorld_m_main_ck_L3_whilebody7_S1;
        end else begin
          waddr <= 0;
          m_main_ck_state <= HelloWorld_m_main_ck_L2_whileelse8_S1;
        end
      end
      HelloWorld_m_main_ck_L3_whilebody7_S1: begin
        i_rx_en <= 1;
        m_main_ck_state <= HelloWorld_m_main_ck_L3_whilebody7_S2;
      end
      HelloWorld_m_main_ck_L3_whilebody7_S2: begin
        i_rx_en <= 0;
        m_main_ck_state <= HelloWorld_m_main_ck_L3_whilebody7_S3;
      end
      HelloWorld_m_main_ck_L3_whilebody7_S3: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_L3_whilebody7_S4;
      end
      HelloWorld_m_main_ck_L3_whilebody7_S4: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_L3_whilebody7_S5;
      end
      HelloWorld_m_main_ck_L3_whilebody7_S5: begin
        /*wait a cycle*/
        m_main_ck_state <= HelloWorld_m_main_ck_L3_whilebody7_S6;
      end
      HelloWorld_m_main_ck_L3_whilebody7_S6: begin
        m_main_ck_status_inl2 <= rdata;
        m_main_ck_state <= HelloWorld_m_main_ck_L3_whilebody7_S7;
      end
      HelloWorld_m_main_ck_L3_whilebody7_S7: begin
        /* m_main_ck_t603_inl2 <= (m_main_ck_status_inl2 & 64); */
        /* m_main_ck_c604_inl2 <= (m_main_ck_t603_inl2 == 64); */
        /* m_main_ck_t716 <= m_main_ck_c604_inl2 ? 1 : 0; */
        /* m_main_ck_tx_empty_inl25 <= m_main_ck_t716; */
        m_main_ck_tx_empty_inl24 <= m_main_ck_tx_empty_inl25;
        m_main_ck_state <= HelloWorld_m_main_ck_L3_while6_S0;
      end
      endcase
    end
  end
  

endmodule


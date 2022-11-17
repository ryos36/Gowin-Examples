module Echo_m
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
  localparam Echo_m_echoback_worker_cn_b1_INIT = 0;
  localparam Echo_m_echoback_worker_cn_b1_S1 = 1;
  localparam Echo_m_echoback_worker_cn_b1_S2 = 2;
  localparam Echo_m_echoback_worker_cn_b1_S3 = 3;
  localparam Echo_m_echoback_worker_cn_b1_S4 = 4;
  localparam Echo_m_echoback_worker_cn_b1_S5 = 5;
  localparam Echo_m_echoback_worker_cn_b1_S6 = 6;
  localparam Echo_m_echoback_worker_cn_b1_S7 = 7;
  localparam Echo_m_echoback_worker_cn_b1_S8 = 8;
  localparam Echo_m_echoback_worker_cn_b1_S9 = 9;
  localparam Echo_m_echoback_worker_cn_b1_S10 = 10;
  localparam Echo_m_echoback_worker_cn_b1_S11 = 11;
  localparam Echo_m_echoback_worker_cn_b1_S12 = 12;
  localparam Echo_m_echoback_worker_cn_b1_S13 = 13;
  localparam Echo_m_echoback_worker_cn_b1_S14 = 14;
  localparam Echo_m_echoback_worker_cn_b1_FINISH = 15;
  localparam Echo_m_echoback_worker_cn_L1_while2_S0 = 16;
  localparam Echo_m_echoback_worker_cn_L1_while2_S1 = 17;
  localparam Echo_m_echoback_worker_cn_L1_while2_S2 = 18;
  localparam Echo_m_echoback_worker_cn_L1_while2_S3 = 19;
  localparam Echo_m_echoback_worker_cn_L1_while2_S4 = 20;
  localparam Echo_m_echoback_worker_cn_L1_ifthen4_S0 = 21;
  localparam Echo_m_echoback_worker_cn_L1_ifthen4_S1 = 22;
  localparam Echo_m_echoback_worker_cn_L1_ifthen4_S2 = 23;
  localparam Echo_m_echoback_worker_cn_L1_ifthen4_S3 = 24;
  localparam Echo_m_echoback_worker_cn_L1_ifthen4_S4 = 25;
  localparam Echo_m_echoback_worker_cn_L1_ifthen4_S5 = 26;
  localparam Echo_m_echoback_worker_cn_L1_ifthen4_S6 = 27;
  localparam Echo_m_echoback_worker_cn_L1_ifthen4_S7 = 28;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S0 = 29;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S1 = 30;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S2 = 31;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S3 = 32;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S4 = 33;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S5 = 34;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S6 = 35;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S7 = 36;
  localparam Echo_m_echoback_worker_cn_L1_whileelse7_S8 = 37;
  localparam Echo_m_echoback_worker_cn_L1_forelse11_S0 = 38;
  localparam Echo_m_echoback_worker_cn_L2_while5_S0 = 39;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S0 = 40;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S1 = 41;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S2 = 42;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S3 = 43;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S4 = 44;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S5 = 45;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S6 = 46;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S7 = 47;
  localparam Echo_m_echoback_worker_cn_L2_whilebody6_S8 = 48;
  localparam Echo_m_echoback_worker_cn_L3_fortest9_S0 = 49;
  localparam Echo_m_echoback_worker_cn_L3_forbody10_S0 = 50;
  localparam Echo_m_echoback_worker_cn_L3_forbody10_S1 = 51;
  
  //signals: 
  wire m_echoback_worker_cn_c618;
  wire m_echoback_worker_cn_c619;
  wire m_echoback_worker_cn_c621_inl2;
  wire m_echoback_worker_cn_c623_inl1_inl4;
  wire m_echoback_worker_cn_c625_inl1_inl4;
  wire m_echoback_worker_cn_c783;
  wire m_echoback_worker_cn_c872;
  wire        [7:0] m_echoback_worker_cn_t620_inl2;
  wire        [7:0] m_echoback_worker_cn_t624_inl1_inl4;
  wire m_echoback_worker_cn_tx_empty_inl1_inl44;
  reg        [7:0] m_echoback_worker_cn_data_inl3;
  reg        [5:0] m_echoback_worker_cn_state;
  reg        [7:0] m_echoback_worker_cn_status_inl1_inl4;
  reg        [7:0] m_echoback_worker_cn_status_inl2;
  reg m_echoback_worker_cn_tx_empty_inl1_inl43;
  wire signed [31:0] m_echoback_worker_cn_i4;
  wire signed [31:0] m_echoback_worker_cn_t785;
  wire signed [31:0] m_echoback_worker_cn_t786;
  reg signed [31:0] m_echoback_worker_cn_i3;
  //combinations: 
  assign m_echoback_worker_cn_c618 = (m_echoback_worker_cn_t785 != 0);
  assign m_echoback_worker_cn_c619 = (m_echoback_worker_cn_i3 < 10000);
  assign m_echoback_worker_cn_c621_inl2 = (m_echoback_worker_cn_t620_inl2 == 1);
  assign m_echoback_worker_cn_c623_inl1_inl4 = (m_echoback_worker_cn_tx_empty_inl1_inl43 == 0);
  assign m_echoback_worker_cn_c625_inl1_inl4 = (m_echoback_worker_cn_t624_inl1_inl4 == 64);
  assign m_echoback_worker_cn_c783 = (m_echoback_worker_cn_c618 && m_echoback_worker_cn_c623_inl1_inl4);
  assign m_echoback_worker_cn_c872 = (m_echoback_worker_cn_c618 && m_echoback_worker_cn_c623_inl1_inl4);
  assign m_echoback_worker_cn_i4 = (m_echoback_worker_cn_i3 + 1);
  assign m_echoback_worker_cn_t620_inl2 = (m_echoback_worker_cn_status_inl2 & 1);
  assign m_echoback_worker_cn_t624_inl1_inl4 = (m_echoback_worker_cn_status_inl1_inl4 & 64);
  assign m_echoback_worker_cn_t785 = m_echoback_worker_cn_c621_inl2 ? 1 : 0;
  assign m_echoback_worker_cn_t786 = m_echoback_worker_cn_c625_inl1_inl4 ? 1 : 0;
  assign m_echoback_worker_cn_tx_empty_inl1_inl44 = m_echoback_worker_cn_t786;
  
  always @(posedge clk) begin
    if (rst) begin
      i_rx_en <= 0;
      i_tx_en <= 0;
      m_echoback_worker_cn_data_inl3 <= 0;
      m_echoback_worker_cn_i3 <= 0;
      m_echoback_worker_cn_status_inl1_inl4 <= 0;
      m_echoback_worker_cn_status_inl2 <= 0;
      m_echoback_worker_cn_tx_empty_inl1_inl43 <= 0;
      raddr <= 0;
      waddr <= 0;
      wdata <= 0;
      m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_INIT;
    end else begin //if (rst)
      case(m_echoback_worker_cn_state)
      Echo_m_echoback_worker_cn_b1_INIT: begin
        i_tx_en <= 1;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S1;
      end
      Echo_m_echoback_worker_cn_b1_S1: begin
        waddr <= 3;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S2;
      end
      Echo_m_echoback_worker_cn_b1_S2: begin
        wdata <= 3;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S3;
      end
      Echo_m_echoback_worker_cn_b1_S3: begin
        i_tx_en <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S4;
      end
      Echo_m_echoback_worker_cn_b1_S4: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S5;
      end
      Echo_m_echoback_worker_cn_b1_S5: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S6;
      end
      Echo_m_echoback_worker_cn_b1_S6: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S7;
      end
      Echo_m_echoback_worker_cn_b1_S7: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S8;
      end
      Echo_m_echoback_worker_cn_b1_S8: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S9;
      end
      Echo_m_echoback_worker_cn_b1_S9: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S10;
      end
      Echo_m_echoback_worker_cn_b1_S10: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S11;
      end
      Echo_m_echoback_worker_cn_b1_S11: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S12;
      end
      Echo_m_echoback_worker_cn_b1_S12: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_b1_S13;
      end
      Echo_m_echoback_worker_cn_b1_S13: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_while2_S0;
      end
      Echo_m_echoback_worker_cn_L1_while2_S0: begin
        raddr <= 5;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_while2_S1;
      end
      Echo_m_echoback_worker_cn_L1_while2_S1: begin
        i_rx_en <= 1;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_while2_S2;
      end
      Echo_m_echoback_worker_cn_L1_while2_S2: begin
        i_rx_en <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_while2_S3;
      end
      Echo_m_echoback_worker_cn_L1_while2_S3: begin
        m_echoback_worker_cn_status_inl2 <= rdata;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_while2_S4;
      end
      Echo_m_echoback_worker_cn_L1_while2_S4: begin
        /* m_echoback_worker_cn_t620_inl2 <= (m_echoback_worker_cn_status_inl2 & 1); */
        /* m_echoback_worker_cn_c621_inl2 <= (m_echoback_worker_cn_t620_inl2 == 1); */
        /* m_echoback_worker_cn_t785 <= m_echoback_worker_cn_c621_inl2 ? 1 : 0; */
        /* m_echoback_worker_cn_c618 <= (m_echoback_worker_cn_t785 != 0); */
        if (m_echoback_worker_cn_c618) begin
          i_rx_en <= 1;
          m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_ifthen4_S1;
        end else begin
          /* m_echoback_worker_cn_c619 <= (m_echoback_worker_cn_i3 < 10000); */
          if (m_echoback_worker_cn_c619) begin
            /* m_echoback_worker_cn_i4 <= (m_echoback_worker_cn_i3 + 1); */
            m_echoback_worker_cn_i3 <= m_echoback_worker_cn_i4;
            m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L3_forbody10_S1;
          end else begin
            m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_while2_S0;
          end
        end
      end
      Echo_m_echoback_worker_cn_L1_ifthen4_S1: begin
        raddr <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_ifthen4_S2;
      end
      Echo_m_echoback_worker_cn_L1_ifthen4_S2: begin
        i_rx_en <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_ifthen4_S3;
      end
      Echo_m_echoback_worker_cn_L1_ifthen4_S3: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_ifthen4_S4;
      end
      Echo_m_echoback_worker_cn_L1_ifthen4_S4: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_ifthen4_S5;
      end
      Echo_m_echoback_worker_cn_L1_ifthen4_S5: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_ifthen4_S6;
      end
      Echo_m_echoback_worker_cn_L1_ifthen4_S6: begin
        m_echoback_worker_cn_data_inl3 <= rdata;
        m_echoback_worker_cn_tx_empty_inl1_inl43 <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_while5_S0;
      end
      Echo_m_echoback_worker_cn_L1_whileelse7_S1: begin
        waddr <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_whileelse7_S2;
      end
      Echo_m_echoback_worker_cn_L1_whileelse7_S2: begin
        wdata <= m_echoback_worker_cn_data_inl3;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_whileelse7_S3;
      end
      Echo_m_echoback_worker_cn_L1_whileelse7_S3: begin
        i_tx_en <= 1;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_whileelse7_S4;
      end
      Echo_m_echoback_worker_cn_L1_whileelse7_S4: begin
        i_tx_en <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_whileelse7_S5;
      end
      Echo_m_echoback_worker_cn_L1_whileelse7_S5: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_whileelse7_S6;
      end
      Echo_m_echoback_worker_cn_L1_whileelse7_S6: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_whileelse7_S7;
      end
      Echo_m_echoback_worker_cn_L1_whileelse7_S7: begin
        m_echoback_worker_cn_i3 <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L3_fortest9_S0;
      end
      Echo_m_echoback_worker_cn_L2_while5_S0: begin
        /* m_echoback_worker_cn_c623_inl1_inl4 <= (m_echoback_worker_cn_tx_empty_inl1_inl43 == 0); */
        if (m_echoback_worker_cn_c623_inl1_inl4) begin
          raddr <= 5;
          /* m_echoback_worker_cn_c872 <= (m_echoback_worker_cn_c618 && m_echoback_worker_cn_c623_inl1_inl4); */
          /* m_echoback_worker_cn_c783 <= (m_echoback_worker_cn_c618 && m_echoback_worker_cn_c623_inl1_inl4); */
          m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_whilebody6_S1;
        end else begin
          /*wait a cycle*/
          m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_whileelse7_S1;
        end
      end
      Echo_m_echoback_worker_cn_L2_whilebody6_S1: begin
        i_rx_en <= 1;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_whilebody6_S2;
      end
      Echo_m_echoback_worker_cn_L2_whilebody6_S2: begin
        i_rx_en <= 0;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_whilebody6_S3;
      end
      Echo_m_echoback_worker_cn_L2_whilebody6_S3: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_whilebody6_S4;
      end
      Echo_m_echoback_worker_cn_L2_whilebody6_S4: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_whilebody6_S5;
      end
      Echo_m_echoback_worker_cn_L2_whilebody6_S5: begin
        /*wait a cycle*/
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_whilebody6_S6;
      end
      Echo_m_echoback_worker_cn_L2_whilebody6_S6: begin
        m_echoback_worker_cn_status_inl1_inl4 <= rdata;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_whilebody6_S7;
      end
      Echo_m_echoback_worker_cn_L2_whilebody6_S7: begin
        /* m_echoback_worker_cn_t624_inl1_inl4 <= (m_echoback_worker_cn_status_inl1_inl4 & 64); */
        /* m_echoback_worker_cn_c625_inl1_inl4 <= (m_echoback_worker_cn_t624_inl1_inl4 == 64); */
        /* m_echoback_worker_cn_t786 <= m_echoback_worker_cn_c625_inl1_inl4 ? 1 : 0; */
        /* m_echoback_worker_cn_tx_empty_inl1_inl44 <= m_echoback_worker_cn_t786; */
        m_echoback_worker_cn_tx_empty_inl1_inl43 <= m_echoback_worker_cn_tx_empty_inl1_inl44;
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L2_while5_S0;
      end
      Echo_m_echoback_worker_cn_L3_fortest9_S0: begin
        /* m_echoback_worker_cn_c619 <= (m_echoback_worker_cn_i3 < 10000); */
        if (m_echoback_worker_cn_c619) begin
          /* m_echoback_worker_cn_i4 <= (m_echoback_worker_cn_i3 + 1); */
          m_echoback_worker_cn_i3 <= m_echoback_worker_cn_i4;
          m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L3_forbody10_S1;
        end else begin
          m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L1_while2_S0;
        end
      end
      Echo_m_echoback_worker_cn_L3_forbody10_S1: begin
        m_echoback_worker_cn_state <= Echo_m_echoback_worker_cn_L3_fortest9_S0;
      end
      endcase
    end
  end
  

endmodule


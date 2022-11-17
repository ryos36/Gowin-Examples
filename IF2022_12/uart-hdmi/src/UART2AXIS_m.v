module UART2AXIS_m
  (
    input wire clk,
    input wire rst,
    output reg i_tx_en = 0,
    output reg [2:0] waddr = 0,
    output reg [7:0] wdata = 0,
    output reg [2:0] raddr = 0,
    output reg i_rx_en = 0,
    input wire [7:0] rdata,
    output reg [7:0] term_out_tdata = 0,
    output reg term_out_tvalid = 0,
    input wire term_out_tready
  );

  //localparams
  localparam UART2AXIS_m_main_cr_b1_INIT = 0;
  localparam UART2AXIS_m_main_cr_b1_S1 = 1;
  localparam UART2AXIS_m_main_cr_b1_S2 = 2;
  localparam UART2AXIS_m_main_cr_b1_S3 = 3;
  localparam UART2AXIS_m_main_cr_b1_S4 = 4;
  localparam UART2AXIS_m_main_cr_b1_FINISH = 5;
  localparam UART2AXIS_m_main_cr_L1_while2_S0 = 6;
  localparam UART2AXIS_m_main_cr_L1_while2_S1 = 7;
  localparam UART2AXIS_m_main_cr_L1_while2_S2 = 8;
  localparam UART2AXIS_m_main_cr_L1_while2_S3 = 9;
  localparam UART2AXIS_m_main_cr_L1_while2_S4 = 10;
  localparam UART2AXIS_m_main_cr_L1_ifthen4_S0 = 11;
  localparam UART2AXIS_m_main_cr_L1_ifthen4_S1 = 12;
  localparam UART2AXIS_m_main_cr_L1_ifthen4_S2 = 13;
  localparam UART2AXIS_m_main_cr_L1_ifthen4_S3 = 14;
  localparam UART2AXIS_m_main_cr_L1_ifthen4_S4 = 15;
  localparam UART2AXIS_m_main_cr_L1_ifthen4_S5 = 16;
  localparam UART2AXIS_m_main_cr_L1_ifthen4_S6 = 17;
  localparam UART2AXIS_m_main_cr_L1_ifthen4_S7 = 18;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S0 = 19;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S1 = 20;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S2 = 21;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S3 = 22;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S4 = 23;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S5 = 24;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S6 = 25;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S7 = 26;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S8 = 27;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S9 = 28;
  localparam UART2AXIS_m_main_cr_L1_whileelse7_S10 = 29;
  localparam UART2AXIS_m_main_cr_L1_forelse11_S0 = 30;
  localparam UART2AXIS_m_main_cr_L2_while5_S0 = 31;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S0 = 32;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S1 = 33;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S2 = 34;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S3 = 35;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S4 = 36;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S5 = 37;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S6 = 38;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S7 = 39;
  localparam UART2AXIS_m_main_cr_L2_whilebody6_S8 = 40;
  localparam UART2AXIS_m_main_cr_L3_fortest9_S0 = 41;
  localparam UART2AXIS_m_main_cr_L3_forbody10_S0 = 42;
  localparam UART2AXIS_m_main_cr_L3_forbody10_S1 = 43;
  
  //signals: 
  wire m_main_cr_c616;
  wire m_main_cr_c617;
  wire m_main_cr_c619_inl2;
  wire m_main_cr_c621_inl1_inl4;
  wire m_main_cr_c623_inl1_inl4;
  wire m_main_cr_c806;
  wire m_main_cr_c893;
  wire        [7:0] m_main_cr_t618_inl2;
  wire        [7:0] m_main_cr_t622_inl1_inl4;
  wire m_main_cr_tx_empty_inl1_inl44;
  reg        [7:0] m_main_cr_data_inl3;
  reg        [5:0] m_main_cr_state;
  reg        [7:0] m_main_cr_status_inl1_inl4;
  reg        [7:0] m_main_cr_status_inl2;
  reg m_main_cr_tx_empty_inl1_inl43;
  wire signed [31:0] m_main_cr_i4;
  wire signed [31:0] m_main_cr_t808;
  wire signed [31:0] m_main_cr_t809;
  reg signed [31:0] m_main_cr_i3;
  //combinations: 
  assign m_main_cr_c616 = (m_main_cr_t808 != 0);
  assign m_main_cr_c617 = (m_main_cr_i3 < 10000);
  assign m_main_cr_c619_inl2 = (m_main_cr_t618_inl2 == 1);
  assign m_main_cr_c621_inl1_inl4 = (m_main_cr_tx_empty_inl1_inl43 == 0);
  assign m_main_cr_c623_inl1_inl4 = (m_main_cr_t622_inl1_inl4 == 64);
  assign m_main_cr_c806 = (m_main_cr_c616 && m_main_cr_c621_inl1_inl4);
  assign m_main_cr_c893 = (m_main_cr_c616 && m_main_cr_c621_inl1_inl4);
  assign m_main_cr_i4 = (m_main_cr_i3 + 1);
  assign m_main_cr_t618_inl2 = (m_main_cr_status_inl2 & 1);
  assign m_main_cr_t622_inl1_inl4 = (m_main_cr_status_inl1_inl4 & 64);
  assign m_main_cr_t808 = m_main_cr_c619_inl2 ? 1 : 0;
  assign m_main_cr_t809 = m_main_cr_c623_inl1_inl4 ? 1 : 0;
  assign m_main_cr_tx_empty_inl1_inl44 = m_main_cr_t809;
  
  always @(posedge clk) begin
    if (rst) begin
      i_rx_en <= 0;
      i_tx_en <= 0;
      m_main_cr_data_inl3 <= 0;
      m_main_cr_i3 <= 0;
      m_main_cr_status_inl1_inl4 <= 0;
      m_main_cr_status_inl2 <= 0;
      m_main_cr_tx_empty_inl1_inl43 <= 0;
      raddr <= 0;
      term_out_tdata <= 0;
      term_out_tvalid <= 0;
      waddr <= 0;
      wdata <= 0;
      m_main_cr_state <= UART2AXIS_m_main_cr_b1_INIT;
    end else begin //if (rst)
      case(m_main_cr_state)
      UART2AXIS_m_main_cr_b1_INIT: begin
        i_tx_en <= 1;
        m_main_cr_state <= UART2AXIS_m_main_cr_b1_S1;
      end
      UART2AXIS_m_main_cr_b1_S1: begin
        waddr <= 3;
        m_main_cr_state <= UART2AXIS_m_main_cr_b1_S2;
      end
      UART2AXIS_m_main_cr_b1_S2: begin
        wdata <= 3;
        m_main_cr_state <= UART2AXIS_m_main_cr_b1_S3;
      end
      UART2AXIS_m_main_cr_b1_S3: begin
        i_tx_en <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_while2_S0;
      end
      UART2AXIS_m_main_cr_L1_while2_S0: begin
        raddr <= 5;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_while2_S1;
      end
      UART2AXIS_m_main_cr_L1_while2_S1: begin
        i_rx_en <= 1;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_while2_S2;
      end
      UART2AXIS_m_main_cr_L1_while2_S2: begin
        i_rx_en <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_while2_S3;
      end
      UART2AXIS_m_main_cr_L1_while2_S3: begin
        m_main_cr_status_inl2 <= rdata;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_while2_S4;
      end
      UART2AXIS_m_main_cr_L1_while2_S4: begin
        /* m_main_cr_t618_inl2 <= (m_main_cr_status_inl2 & 1); */
        /* m_main_cr_c619_inl2 <= (m_main_cr_t618_inl2 == 1); */
        /* m_main_cr_t808 <= m_main_cr_c619_inl2 ? 1 : 0; */
        /* m_main_cr_c616 <= (m_main_cr_t808 != 0); */
        if (m_main_cr_c616) begin
          i_rx_en <= 1;
          m_main_cr_state <= UART2AXIS_m_main_cr_L1_ifthen4_S1;
        end else begin
          /* m_main_cr_c617 <= (m_main_cr_i3 < 10000); */
          if (m_main_cr_c617) begin
            /* m_main_cr_i4 <= (m_main_cr_i3 + 1); */
            m_main_cr_i3 <= m_main_cr_i4;
            m_main_cr_state <= UART2AXIS_m_main_cr_L3_forbody10_S1;
          end else begin
            m_main_cr_state <= UART2AXIS_m_main_cr_L1_while2_S0;
          end
        end
      end
      UART2AXIS_m_main_cr_L1_ifthen4_S1: begin
        raddr <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_ifthen4_S2;
      end
      UART2AXIS_m_main_cr_L1_ifthen4_S2: begin
        i_rx_en <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_ifthen4_S3;
      end
      UART2AXIS_m_main_cr_L1_ifthen4_S3: begin
        /*wait a cycle*/
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_ifthen4_S4;
      end
      UART2AXIS_m_main_cr_L1_ifthen4_S4: begin
        /*wait a cycle*/
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_ifthen4_S5;
      end
      UART2AXIS_m_main_cr_L1_ifthen4_S5: begin
        /*wait a cycle*/
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_ifthen4_S6;
      end
      UART2AXIS_m_main_cr_L1_ifthen4_S6: begin
        m_main_cr_data_inl3 <= rdata;
        m_main_cr_tx_empty_inl1_inl43 <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L2_while5_S0;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S1: begin
        waddr <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S2;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S2: begin
        wdata <= m_main_cr_data_inl3;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S3;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S3: begin
        i_tx_en <= 1;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S4;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S4: begin
        i_tx_en <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S5;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S5: begin
        /*wait a cycle*/
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S6;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S6: begin
        /*wait a cycle*/
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S7;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S7: begin
        term_out_tdata <= m_main_cr_data_inl3;
        m_main_cr_i3 <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S8;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S8: begin
        term_out_tvalid <= 1;
        m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S9;
      end
      UART2AXIS_m_main_cr_L1_whileelse7_S9: begin
        term_out_tvalid <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L3_fortest9_S0;
      end
      UART2AXIS_m_main_cr_L2_while5_S0: begin
        /* m_main_cr_c621_inl1_inl4 <= (m_main_cr_tx_empty_inl1_inl43 == 0); */
        if (m_main_cr_c621_inl1_inl4) begin
          raddr <= 5;
          /* m_main_cr_c893 <= (m_main_cr_c616 && m_main_cr_c621_inl1_inl4); */
          /* m_main_cr_c806 <= (m_main_cr_c616 && m_main_cr_c621_inl1_inl4); */
          m_main_cr_state <= UART2AXIS_m_main_cr_L2_whilebody6_S1;
        end else begin
          /*wait a cycle*/
          m_main_cr_state <= UART2AXIS_m_main_cr_L1_whileelse7_S1;
        end
      end
      UART2AXIS_m_main_cr_L2_whilebody6_S1: begin
        i_rx_en <= 1;
        m_main_cr_state <= UART2AXIS_m_main_cr_L2_whilebody6_S2;
      end
      UART2AXIS_m_main_cr_L2_whilebody6_S2: begin
        i_rx_en <= 0;
        m_main_cr_state <= UART2AXIS_m_main_cr_L2_whilebody6_S3;
      end
      UART2AXIS_m_main_cr_L2_whilebody6_S3: begin
        /*wait a cycle*/
        m_main_cr_state <= UART2AXIS_m_main_cr_L2_whilebody6_S4;
      end
      UART2AXIS_m_main_cr_L2_whilebody6_S4: begin
        /*wait a cycle*/
        m_main_cr_state <= UART2AXIS_m_main_cr_L2_whilebody6_S5;
      end
      UART2AXIS_m_main_cr_L2_whilebody6_S5: begin
        /*wait a cycle*/
        m_main_cr_state <= UART2AXIS_m_main_cr_L2_whilebody6_S6;
      end
      UART2AXIS_m_main_cr_L2_whilebody6_S6: begin
        m_main_cr_status_inl1_inl4 <= rdata;
        m_main_cr_state <= UART2AXIS_m_main_cr_L2_whilebody6_S7;
      end
      UART2AXIS_m_main_cr_L2_whilebody6_S7: begin
        /* m_main_cr_t622_inl1_inl4 <= (m_main_cr_status_inl1_inl4 & 64); */
        /* m_main_cr_c623_inl1_inl4 <= (m_main_cr_t622_inl1_inl4 == 64); */
        /* m_main_cr_t809 <= m_main_cr_c623_inl1_inl4 ? 1 : 0; */
        /* m_main_cr_tx_empty_inl1_inl44 <= m_main_cr_t809; */
        m_main_cr_tx_empty_inl1_inl43 <= m_main_cr_tx_empty_inl1_inl44;
        m_main_cr_state <= UART2AXIS_m_main_cr_L2_while5_S0;
      end
      UART2AXIS_m_main_cr_L3_fortest9_S0: begin
        /* m_main_cr_c617 <= (m_main_cr_i3 < 10000); */
        if (m_main_cr_c617) begin
          /* m_main_cr_i4 <= (m_main_cr_i3 + 1); */
          m_main_cr_i3 <= m_main_cr_i4;
          m_main_cr_state <= UART2AXIS_m_main_cr_L3_forbody10_S1;
        end else begin
          m_main_cr_state <= UART2AXIS_m_main_cr_L1_while2_S0;
        end
      end
      UART2AXIS_m_main_cr_L3_forbody10_S1: begin
        m_main_cr_state <= UART2AXIS_m_main_cr_L3_fortest9_S0;
      end
      endcase
    end
  end
  

endmodule


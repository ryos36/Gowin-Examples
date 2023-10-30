module ov2640_m
  (
    input wire clk,
    input wire rst,
    output reg finished = 0,
    output reg [15:0] command = 0,
    input wire advance,
    input wire resend
  );

  //localparams
  localparam ov2640_m_main_cg_b1_INIT = 0;
  localparam ov2640_m_main_cg_b1_FINISH = 1;
  localparam ov2640_m_main_cg_L1_while2_S0 = 2;
  localparam ov2640_m_main_cg_L1_while2_S1 = 3;
  localparam ov2640_m_main_cg_L1_while2_S2 = 4;
  localparam ov2640_m_main_cg_L1_while2_S3 = 5;
  localparam ov2640_m_main_cg_L1_while2_S4 = 6;
  localparam ov2640_m_main_cg_L1_while2_S5 = 7;
  localparam ov2640_m_main_cg_L1_forelse6_S0 = 8;
  localparam ov2640_m_main_cg_L1_forelse6_S1 = 9;
  localparam ov2640_m_main_cg_L1_forelse6_S2 = 10;
  localparam ov2640_m_main_cg_L1_forelse6_S3 = 11;
  localparam ov2640_m_main_cg_L1_forelse6_S4 = 12;
  localparam ov2640_m_main_cg_L1_forelse6_S5 = 13;
  localparam ov2640_m_main_cg_L1_forelse6_S6 = 14;
  localparam ov2640_m_main_cg_L1_forelse6_S7 = 15;
  localparam ov2640_m_main_cg_L1_forelse6_S8 = 16;
  localparam ov2640_m_main_cg_L2_fortest4_S0 = 17;
  localparam ov2640_m_main_cg_L2_forbody5_S0 = 18;
  localparam ov2640_m_main_cg_L2_forbody5_S1 = 19;
  localparam ov2640_m_main_cg_L2_forbody5_S2 = 20;
  localparam ov2640_m_main_cg_L2_forbody5_S3 = 21;
  localparam ov2640_m_main_cg_L2_forbody5_S4 = 22;
  
  //signals: 
  wire m_main_cg_c599_inl2;
  reg        [4:0] m_main_cg_state;
  wire signed [31:0] m_main_cg_counter587_inl24;
  wire signed [31:0] m_main_cg_data_inl2;
  reg signed [31:0] m_main_cg_counter587_inl23;
  //combinations: 
  function [31:0] ov2640_data (
    input [8:0] ov2640_data_in
  );
  begin
    case (ov2640_data_in)
      0: begin
        ov2640_data = 65281;
      end
      1: begin
        ov2640_data = 4736;
      end
      2: begin
        ov2640_data = 65280;
      end
      3: begin
        ov2640_data = 11519;
      end
      4: begin
        ov2640_data = 11999;
      end
      5: begin
        ov2640_data = 65281;
      end
      6: begin
        ov2640_data = 15410;
      end
      7: begin
        ov2640_data = 4480;
      end
      8: begin
        ov2640_data = 2306;
      end
      9: begin
        ov2640_data = 1064;
      end
      10: begin
        ov2640_data = 5093;
      end
      11: begin
        ov2640_data = 5192;
      end
      12: begin
        ov2640_data = 5376;
      end
      13: begin
        ov2640_data = 11276;
      end
      14: begin
        ov2640_data = 13176;
      end
      15: begin
        ov2640_data = 14899;
      end
      16: begin
        ov2640_data = 15355;
      end
      17: begin
        ov2640_data = 15872;
      end
      18: begin
        ov2640_data = 17169;
      end
      19: begin
        ov2640_data = 5648;
      end
      20: begin
        ov2640_data = 14594;
      end
      21: begin
        ov2640_data = 13704;
      end
      22: begin
        ov2640_data = 8714;
      end
      23: begin
        ov2640_data = 14144;
      end
      24: begin
        ov2640_data = 8960;
      end
      25: begin
        ov2640_data = 13472;
      end
      26: begin
        ov2640_data = 1538;
      end
      27: begin
        ov2640_data = 1672;
      end
      28: begin
        ov2640_data = 1984;
      end
      29: begin
        ov2640_data = 3511;
      end
      30: begin
        ov2640_data = 3585;
      end
      31: begin
        ov2640_data = 19456;
      end
      32: begin
        ov2640_data = 19073;
      end
      33: begin
        ov2640_data = 8601;
      end
      34: begin
        ov2640_data = 9280;
      end
      35: begin
        ov2640_data = 9528;
      end
      36: begin
        ov2640_data = 9858;
      end
      37: begin
        ov2640_data = 18432;
      end
      38: begin
        ov2640_data = 18688;
      end
      39: begin
        ov2640_data = 23552;
      end
      40: begin
        ov2640_data = 25344;
      end
      41: begin
        ov2640_data = 17920;
      end
      42: begin
        ov2640_data = 18176;
      end
      43: begin
        ov2640_data = 3130;
      end
      44: begin
        ov2640_data = 23893;
      end
      45: begin
        ov2640_data = 24189;
      end
      46: begin
        ov2640_data = 24445;
      end
      47: begin
        ov2640_data = 24661;
      end
      48: begin
        ov2640_data = 24944;
      end
      49: begin
        ov2640_data = 25216;
      end
      50: begin
        ov2640_data = 31749;
      end
      51: begin
        ov2640_data = 8320;
      end
      52: begin
        ov2640_data = 10288;
      end
      53: begin
        ov2640_data = 27648;
      end
      54: begin
        ov2640_data = 28032;
      end
      55: begin
        ov2640_data = 28160;
      end
      56: begin
        ov2640_data = 28674;
      end
      57: begin
        ov2640_data = 29076;
      end
      58: begin
        ov2640_data = 29633;
      end
      59: begin
        ov2640_data = 15668;
      end
      60: begin
        ov2640_data = 23127;
      end
      61: begin
        ov2640_data = 20411;
      end
      62: begin
        ov2640_data = 20636;
      end
      63: begin
        ov2640_data = 65280;
      end
      64: begin
        ov2640_data = 58751;
      end
      65: begin
        ov2640_data = 63936;
      end
      66: begin
        ov2640_data = 16676;
      end
      67: begin
        ov2640_data = 57364;
      end
      68: begin
        ov2640_data = 30463;
      end
      69: begin
        ov2640_data = 13216;
      end
      70: begin
        ov2640_data = 16928;
      end
      71: begin
        ov2640_data = 17176;
      end
      72: begin
        ov2640_data = 19456;
      end
      73: begin
        ov2640_data = 34768;
      end
      74: begin
        ov2640_data = 34879;
      end
      75: begin
        ov2640_data = 55043;
      end
      76: begin
        ov2640_data = 55568;
      end
      77: begin
        ov2640_data = 54146;
      end
      78: begin
        ov2640_data = 51208;
      end
      79: begin
        ov2640_data = 51584;
      end
      80: begin
        ov2640_data = 31744;
      end
      81: begin
        ov2640_data = 32000;
      end
      82: begin
        ov2640_data = 31747;
      end
      83: begin
        ov2640_data = 32072;
      end
      84: begin
        ov2640_data = 32072;
      end
      85: begin
        ov2640_data = 31752;
      end
      86: begin
        ov2640_data = 32032;
      end
      87: begin
        ov2640_data = 32016;
      end
      88: begin
        ov2640_data = 32014;
      end
      89: begin
        ov2640_data = 36864;
      end
      90: begin
        ov2640_data = 37134;
      end
      91: begin
        ov2640_data = 37146;
      end
      92: begin
        ov2640_data = 37169;
      end
      93: begin
        ov2640_data = 37210;
      end
      94: begin
        ov2640_data = 37225;
      end
      95: begin
        ov2640_data = 37237;
      end
      96: begin
        ov2640_data = 37246;
      end
      97: begin
        ov2640_data = 37256;
      end
      98: begin
        ov2640_data = 37263;
      end
      99: begin
        ov2640_data = 37270;
      end
      100: begin
        ov2640_data = 37283;
      end
      101: begin
        ov2640_data = 37295;
      end
      102: begin
        ov2640_data = 37316;
      end
      103: begin
        ov2640_data = 37335;
      end
      104: begin
        ov2640_data = 37352;
      end
      105: begin
        ov2640_data = 37152;
      end
      106: begin
        ov2640_data = 37376;
      end
      107: begin
        ov2640_data = 37638;
      end
      108: begin
        ov2640_data = 37859;
      end
      109: begin
        ov2640_data = 37635;
      end
      110: begin
        ov2640_data = 37635;
      end
      111: begin
        ov2640_data = 37632;
      end
      112: begin
        ov2640_data = 37634;
      end
      113: begin
        ov2640_data = 37632;
      end
      114: begin
        ov2640_data = 37632;
      end
      115: begin
        ov2640_data = 37632;
      end
      116: begin
        ov2640_data = 37632;
      end
      117: begin
        ov2640_data = 37632;
      end
      118: begin
        ov2640_data = 37632;
      end
      119: begin
        ov2640_data = 37632;
      end
      120: begin
        ov2640_data = 38400;
      end
      121: begin
        ov2640_data = 38664;
      end
      122: begin
        ov2640_data = 38681;
      end
      123: begin
        ov2640_data = 38658;
      end
      124: begin
        ov2640_data = 38668;
      end
      125: begin
        ov2640_data = 38692;
      end
      126: begin
        ov2640_data = 38704;
      end
      127: begin
        ov2640_data = 38696;
      end
      128: begin
        ov2640_data = 38694;
      end
      129: begin
        ov2640_data = 38658;
      end
      130: begin
        ov2640_data = 38808;
      end
      131: begin
        ov2640_data = 38784;
      end
      132: begin
        ov2640_data = 38656;
      end
      133: begin
        ov2640_data = 38656;
      end
      134: begin
        ov2640_data = 41984;
      end
      135: begin
        ov2640_data = 43008;
      end
      136: begin
        ov2640_data = 50449;
      end
      137: begin
        ov2640_data = 50769;
      end
      138: begin
        ov2640_data = 49024;
      end
      139: begin
        ov2640_data = 50960;
      end
      140: begin
        ov2640_data = 46694;
      end
      141: begin
        ov2640_data = 47269;
      end
      142: begin
        ov2640_data = 46948;
      end
      143: begin
        ov2640_data = 47484;
      end
      144: begin
        ov2640_data = 45999;
      end
      145: begin
        ov2640_data = 46231;
      end
      146: begin
        ov2640_data = 46591;
      end
      147: begin
        ov2640_data = 45253;
      end
      148: begin
        ov2640_data = 45460;
      end
      149: begin
        ov2640_data = 45583;
      end
      150: begin
        ov2640_data = 50268;
      end
      151: begin
        ov2640_data = 42496;
      end
      152: begin
        ov2640_data = 42784;
      end
      153: begin
        ov2640_data = 42968;
      end
      154: begin
        ov2640_data = 42779;
      end
      155: begin
        ov2640_data = 42801;
      end
      156: begin
        ov2640_data = 42752;
      end
      157: begin
        ov2640_data = 42776;
      end
      158: begin
        ov2640_data = 42784;
      end
      159: begin
        ov2640_data = 42968;
      end
      160: begin
        ov2640_data = 42777;
      end
      161: begin
        ov2640_data = 42801;
      end
      162: begin
        ov2640_data = 42752;
      end
      163: begin
        ov2640_data = 42776;
      end
      164: begin
        ov2640_data = 42784;
      end
      165: begin
        ov2640_data = 42968;
      end
      166: begin
        ov2640_data = 42777;
      end
      167: begin
        ov2640_data = 42801;
      end
      168: begin
        ov2640_data = 42752;
      end
      169: begin
        ov2640_data = 42776;
      end
      170: begin
        ov2640_data = 32512;
      end
      171: begin
        ov2640_data = 58655;
      end
      172: begin
        ov2640_data = 57719;
      end
      173: begin
        ov2640_data = 56703;
      end
      174: begin
        ov2640_data = 49678;
      end
      175: begin
        ov2640_data = 65281;
      end
      176: begin
        ov2640_data = 65280;
      end
      177: begin
        ov2640_data = 57348;
      end
      178: begin
        ov2640_data = 55812;
      end
      179: begin
        ov2640_data = 55043;
      end
      180: begin
        ov2640_data = 57719;
      end
      181: begin
        ov2640_data = 57344;
      end
      182: begin
        ov2640_data = 65280;
      end
      183: begin
        ov2640_data = 1281;
      end
      184: begin
        ov2640_data = 23200;
      end
      185: begin
        ov2640_data = 23416;
      end
      186: begin
        ov2640_data = 23552;
      end
      187: begin
        ov2640_data = 65281;
      end
      188: begin
        ov2640_data = 4480;
      end
      189: begin
        ov2640_data = 65281;
      end
      190: begin
        ov2640_data = 4672;
      end
      191: begin
        ov2640_data = 778;
      end
      192: begin
        ov2640_data = 12809;
      end
      193: begin
        ov2640_data = 5905;
      end
      194: begin
        ov2640_data = 6211;
      end
      195: begin
        ov2640_data = 6400;
      end
      196: begin
        ov2640_data = 6731;
      end
      197: begin
        ov2640_data = 15672;
      end
      198: begin
        ov2640_data = 13786;
      end
      199: begin
        ov2640_data = 8730;
      end
      200: begin
        ov2640_data = 14275;
      end
      201: begin
        ov2640_data = 13504;
      end
      202: begin
        ov2640_data = 1672;
      end
      203: begin
        ov2640_data = 3463;
      end
      204: begin
        ov2640_data = 3649;
      end
      205: begin
        ov2640_data = 16899;
      end
      206: begin
        ov2640_data = 65280;
      end
      207: begin
        ov2640_data = 1281;
      end
      208: begin
        ov2640_data = 57348;
      end
      209: begin
        ov2640_data = 49252;
      end
      210: begin
        ov2640_data = 49483;
      end
      211: begin
        ov2640_data = 35840;
      end
      212: begin
        ov2640_data = 21248;
      end
      213: begin
        ov2640_data = 21504;
      end
      214: begin
        ov2640_data = 20936;
      end
      215: begin
        ov2640_data = 21142;
      end
      216: begin
        ov2640_data = 21760;
      end
      217: begin
        ov2640_data = 22272;
      end
      218: begin
        ov2640_data = 34365;
      end
      219: begin
        ov2640_data = 20608;
      end
      220: begin
        ov2640_data = 54144;
      end
      221: begin
        ov2640_data = 1280;
      end
      222: begin
        ov2640_data = 57344;
      end
      223: begin
        ov2640_data = 65280;
      end
      224: begin
        ov2640_data = 1280;
      end
      225: begin
        ov2640_data = 65280;
      end
      226: begin
        ov2640_data = 57348;
      end
      227: begin
        ov2640_data = 55812;
      end
      228: begin
        ov2640_data = 55043;
      end
      229: begin
        ov2640_data = 57719;
      end
      230: begin
        ov2640_data = 57344;
      end
    endcase
  end
  endfunction
  assign m_main_cg_c599_inl2 = (m_main_cg_counter587_inl23 < 231);
  assign m_main_cg_counter587_inl24 = (m_main_cg_counter587_inl23 + 1);
  assign m_main_cg_data_inl2 = ov2640_data(m_main_cg_counter587_inl23);
  
  always @(posedge clk) begin
    if (rst) begin
      command <= 0;
      finished <= 0;
      m_main_cg_counter587_inl23 <= 0;
      m_main_cg_state <= ov2640_m_main_cg_b1_INIT;
    end else begin //if (rst)
      case(m_main_cg_state)
      ov2640_m_main_cg_b1_INIT: begin
        m_main_cg_state <= ov2640_m_main_cg_L1_while2_S0;
      end
      ov2640_m_main_cg_L1_while2_S0: begin
        finished <= 0;
        m_main_cg_state <= ov2640_m_main_cg_L1_while2_S1;
      end
      ov2640_m_main_cg_L1_while2_S1: begin
        command <= 63497;
        m_main_cg_state <= ov2640_m_main_cg_L1_while2_S2;
      end
      ov2640_m_main_cg_L1_while2_S2: begin
        if (advance == 1) begin
          m_main_cg_state <= ov2640_m_main_cg_L1_while2_S3;
        end
      end
      ov2640_m_main_cg_L1_while2_S3: begin
        if (advance == 0) begin
          m_main_cg_counter587_inl23 <= 0;
          m_main_cg_state <= ov2640_m_main_cg_L2_fortest4_S0;
        end
      end
      ov2640_m_main_cg_L1_forelse6_S1: begin
        if (advance == 1) begin
          m_main_cg_state <= ov2640_m_main_cg_L1_forelse6_S2;
        end
      end
      ov2640_m_main_cg_L1_forelse6_S2: begin
        if (advance == 0) begin
          command <= 65535;
          m_main_cg_state <= ov2640_m_main_cg_L1_forelse6_S4;
        end
      end
      ov2640_m_main_cg_L1_forelse6_S4: begin
        if (advance == 1) begin
          m_main_cg_state <= ov2640_m_main_cg_L1_forelse6_S5;
        end
      end
      ov2640_m_main_cg_L1_forelse6_S5: begin
        if (advance == 0) begin
          finished <= 1;
          m_main_cg_state <= ov2640_m_main_cg_L1_forelse6_S7;
        end
      end
      ov2640_m_main_cg_L1_forelse6_S7: begin
        if (resend == 1) begin
          m_main_cg_state <= ov2640_m_main_cg_L1_while2_S0;
        end
      end
      ov2640_m_main_cg_L2_fortest4_S0: begin
        /* m_main_cg_c599_inl2 <= (m_main_cg_counter587_inl23 < 231); */
        if (m_main_cg_c599_inl2) begin
          command <= m_main_cg_data_inl2;
          /* m_main_cg_data_inl2 <= ov2640_data(m_main_cg_counter587_inl23); */
          m_main_cg_state <= ov2640_m_main_cg_L2_forbody5_S1;
        end else begin
          command <= 55812;
          m_main_cg_state <= ov2640_m_main_cg_L1_forelse6_S1;
        end
      end
      ov2640_m_main_cg_L2_forbody5_S1: begin
        if (advance == 1) begin
          m_main_cg_state <= ov2640_m_main_cg_L2_forbody5_S2;
        end
      end
      ov2640_m_main_cg_L2_forbody5_S2: begin
        if (advance == 0) begin
          /* m_main_cg_counter587_inl24 <= (m_main_cg_counter587_inl23 + 1); */
          m_main_cg_counter587_inl23 <= m_main_cg_counter587_inl24;
          m_main_cg_state <= ov2640_m_main_cg_L2_fortest4_S0;
        end
      end
      endcase
    end
  end
  

endmodule


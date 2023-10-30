module ov2640_initiator
  (
    input wire clk,
    input wire rst,
    output reg i2c_scl_o = 0,
    output reg i2c_scl_t = 0,
    output reg i2c_sda_o = 0,
    output reg i2c_sda_t = 0,
    output reg done = 0,
    output reg [7:0] debug_print_pin = 0,
    input wire resend,
    input wire i2c_sda_i,
    input wire i2c_scl_i
  );

  //localparams
  localparam ov2640_initiator_worker_d7_b1_INIT = 0;
  localparam ov2640_initiator_worker_d7_b1_S1 = 1;
  localparam ov2640_initiator_worker_d7_b1_S2 = 2;
  localparam ov2640_initiator_worker_d7_b1_S3 = 3;
  localparam ov2640_initiator_worker_d7_b1_S4 = 4;
  localparam ov2640_initiator_worker_d7_b1_S5 = 5;
  localparam ov2640_initiator_worker_d7_b1_S6 = 6;
  localparam ov2640_initiator_worker_d7_b1_FINISH = 7;
  localparam ov2640_initiator_worker_d7_L1_while2_S0 = 8;
  localparam ov2640_initiator_worker_d7_L1_while2_S1 = 9;
  localparam ov2640_initiator_worker_d7_L1_forelse36_S0 = 10;
  localparam ov2640_initiator_worker_d7_L1_forelse36_S1 = 11;
  localparam ov2640_initiator_worker_d7_L1_forelse36_S2 = 12;
  localparam ov2640_initiator_worker_d7_L1_forelse36_S3 = 13;
  localparam ov2640_initiator_worker_d7_L1_forelse36_S4 = 14;
  localparam ov2640_initiator_worker_d7_L2_fortest4_S0 = 15;
  localparam ov2640_initiator_worker_d7_L2_forbody5_S0 = 16;
  localparam ov2640_initiator_worker_d7_L2_forbody5_S1 = 17;
  localparam ov2640_initiator_worker_d7_L2_forbody5_S2 = 18;
  localparam ov2640_initiator_worker_d7_L2_forbody5_S3 = 19;
  localparam ov2640_initiator_worker_d7_L2_forbody5_S4 = 20;
  localparam ov2640_initiator_worker_d7_L2_forelse9_S0 = 21;
  localparam ov2640_initiator_worker_d7_L2_forelse9_S1 = 22;
  localparam ov2640_initiator_worker_d7_L2_forelse9_S2 = 23;
  localparam ov2640_initiator_worker_d7_L2_ifthen12_S0 = 24;
  localparam ov2640_initiator_worker_d7_L2_whileexit14_S0 = 25;
  localparam ov2640_initiator_worker_d7_L2_whileexit14_S1 = 26;
  localparam ov2640_initiator_worker_d7_L2_ifthen15_S0 = 27;
  localparam ov2640_initiator_worker_d7_L2_ifthen15_S1 = 28;
  localparam ov2640_initiator_worker_d7_L2_ifthen15_S2 = 29;
  localparam ov2640_initiator_worker_d7_L2_ifthen15_S3 = 30;
  localparam ov2640_initiator_worker_d7_L2_ifthen15_S4 = 31;
  localparam ov2640_initiator_worker_d7_L2_ifelse17_S0 = 32;
  localparam ov2640_initiator_worker_d7_L2_ifelse17_S1 = 33;
  localparam ov2640_initiator_worker_d7_L2_ifelse17_S2 = 34;
  localparam ov2640_initiator_worker_d7_L2_forelse21_S0 = 35;
  localparam ov2640_initiator_worker_d7_L2_forelse21_S1 = 36;
  localparam ov2640_initiator_worker_d7_L2_forelse21_S2 = 37;
  localparam ov2640_initiator_worker_d7_L2_ifthen24_S0 = 38;
  localparam ov2640_initiator_worker_d7_L2_whileexit26_S0 = 39;
  localparam ov2640_initiator_worker_d7_L2_whileexit26_S1 = 40;
  localparam ov2640_initiator_worker_d7_L2_whileexit26_S2 = 41;
  localparam ov2640_initiator_worker_d7_L2_whileexit26_S3 = 42;
  localparam ov2640_initiator_worker_d7_L2_forelse30_S0 = 43;
  localparam ov2640_initiator_worker_d7_L2_forelse30_S1 = 44;
  localparam ov2640_initiator_worker_d7_L2_forelse30_S2 = 45;
  localparam ov2640_initiator_worker_d7_L2_ifthen33_S0 = 46;
  localparam ov2640_initiator_worker_d7_L2_whileexit35_S0 = 47;
  localparam ov2640_initiator_worker_d7_L2_whileexit35_S1 = 48;
  localparam ov2640_initiator_worker_d7_L2_whileexit35_S2 = 49;
  localparam ov2640_initiator_worker_d7_L2_whileexit35_S3 = 50;
  localparam ov2640_initiator_worker_d7_L2_whileexit35_S4 = 51;
  localparam ov2640_initiator_worker_d7_L2_whileexit35_S5 = 52;
  localparam ov2640_initiator_worker_d7_L2_exit16_S0 = 53;
  localparam ov2640_initiator_worker_d7_L2_exit16_S1 = 54;
  localparam ov2640_initiator_worker_d7_L3_fortest6_S0 = 55;
  localparam ov2640_initiator_worker_d7_L3_forbody7_S0 = 56;
  localparam ov2640_initiator_worker_d7_L3_forbody7_S1 = 57;
  localparam ov2640_initiator_worker_d7_L3_forbody7_S2 = 58;
  localparam ov2640_initiator_worker_d7_L3_forbody7_S3 = 59;
  localparam ov2640_initiator_worker_d7_L3_forbody7_S4 = 60;
  localparam ov2640_initiator_worker_d7_L4_while10_S0 = 61;
  localparam ov2640_initiator_worker_d7_L4_whilebody11_S0 = 62;
  localparam ov2640_initiator_worker_d7_L4_whilebody11_S1 = 63;
  localparam ov2640_initiator_worker_d7_L4_whilebody11_S2 = 64;
  localparam ov2640_initiator_worker_d7_L4_whilebody11_S3 = 65;
  localparam ov2640_initiator_worker_d7_L4_ifelse13_S0 = 66;
  localparam ov2640_initiator_worker_d7_L4_ifelse13_S1 = 67;
  localparam ov2640_initiator_worker_d7_L5_fortest18_S0 = 68;
  localparam ov2640_initiator_worker_d7_L5_forbody19_S0 = 69;
  localparam ov2640_initiator_worker_d7_L5_forbody19_S1 = 70;
  localparam ov2640_initiator_worker_d7_L5_forbody19_S2 = 71;
  localparam ov2640_initiator_worker_d7_L5_forbody19_S3 = 72;
  localparam ov2640_initiator_worker_d7_L5_forbody19_S4 = 73;
  localparam ov2640_initiator_worker_d7_L6_while22_S0 = 74;
  localparam ov2640_initiator_worker_d7_L6_whilebody23_S0 = 75;
  localparam ov2640_initiator_worker_d7_L6_whilebody23_S1 = 76;
  localparam ov2640_initiator_worker_d7_L6_whilebody23_S2 = 77;
  localparam ov2640_initiator_worker_d7_L6_whilebody23_S3 = 78;
  localparam ov2640_initiator_worker_d7_L6_ifelse25_S0 = 79;
  localparam ov2640_initiator_worker_d7_L6_ifelse25_S1 = 80;
  localparam ov2640_initiator_worker_d7_L7_fortest27_S0 = 81;
  localparam ov2640_initiator_worker_d7_L7_forbody28_S0 = 82;
  localparam ov2640_initiator_worker_d7_L7_forbody28_S1 = 83;
  localparam ov2640_initiator_worker_d7_L7_forbody28_S2 = 84;
  localparam ov2640_initiator_worker_d7_L7_forbody28_S3 = 85;
  localparam ov2640_initiator_worker_d7_L7_forbody28_S4 = 86;
  localparam ov2640_initiator_worker_d7_L8_while31_S0 = 87;
  localparam ov2640_initiator_worker_d7_L8_whilebody32_S0 = 88;
  localparam ov2640_initiator_worker_d7_L8_whilebody32_S1 = 89;
  localparam ov2640_initiator_worker_d7_L8_whilebody32_S2 = 90;
  localparam ov2640_initiator_worker_d7_L8_whilebody32_S3 = 91;
  localparam ov2640_initiator_worker_d7_L8_ifelse34_S0 = 92;
  localparam ov2640_initiator_worker_d7_L8_ifelse34_S1 = 93;
  
  //signals: 
  wire initiator_worker_d7_c1249;
  wire initiator_worker_d7_c1251;
  wire initiator_worker_d7_c1252;
  wire initiator_worker_d7_c1253;
  wire initiator_worker_d7_c1254;
  wire initiator_worker_d7_c1255;
  wire initiator_worker_d7_c1256;
  wire initiator_worker_d7_c1258;
  wire initiator_worker_d7_c1259;
  wire initiator_worker_d7_c1260;
  wire initiator_worker_d7_c1261;
  wire initiator_worker_d7_c1262;
  wire initiator_worker_d7_c1264;
  wire initiator_worker_d7_c1265;
  wire initiator_worker_d7_c1266;
  wire initiator_worker_d7_c1267;
  wire initiator_worker_d7_c1270;
  wire initiator_worker_d7_c1271;
  wire initiator_worker_d7_c1272;
  wire initiator_worker_d7_c1274;
  wire initiator_worker_d7_c1275;
  wire initiator_worker_d7_c1276;
  wire initiator_worker_d7_c1277;
  wire initiator_worker_d7_c1278;
  wire initiator_worker_d7_c1627;
  wire initiator_worker_d7_c1628;
  wire initiator_worker_d7_c1629;
  wire initiator_worker_d7_c1630;
  wire initiator_worker_d7_c1631;
  wire initiator_worker_d7_c1632;
  wire initiator_worker_d7_c1633;
  wire initiator_worker_d7_c1634;
  wire initiator_worker_d7_c1635;
  wire initiator_worker_d7_c1636;
  wire initiator_worker_d7_c1637;
  wire initiator_worker_d7_c1638;
  wire initiator_worker_d7_c1639;
  wire initiator_worker_d7_c1640;
  wire initiator_worker_d7_c1641;
  wire initiator_worker_d7_c1642;
  wire initiator_worker_d7_c817_inl6;
  wire initiator_worker_d7_c822_inl3_inl6;
  wire initiator_worker_d7_c822_inl4_inl6;
  wire initiator_worker_d7_c822_inl5_inl6;
  wire initiator_worker_d7_c823_inl3_inl6;
  wire initiator_worker_d7_c823_inl4_inl6;
  wire initiator_worker_d7_c823_inl5_inl6;
  wire initiator_worker_d7_c826_inl1_inl2_inl6;
  wire initiator_worker_d7_c826_inl8_inl6;
  wire initiator_worker_d7_c826_inl9_inl6;
  wire initiator_worker_d7_c828_inl1_inl2_inl6;
  wire initiator_worker_d7_c828_inl8_inl6;
  wire initiator_worker_d7_c828_inl9_inl6;
  wire initiator_worker_d7_c843;
  wire        [7:0] initiator_worker_d7_err_i_inl3_inl66;
  wire        [7:0] initiator_worker_d7_err_i_inl3_inl67;
  wire        [7:0] initiator_worker_d7_err_i_inl4_inl66;
  wire        [7:0] initiator_worker_d7_err_i_inl5_inl66;
  wire initiator_worker_d7_msb_inl1_inl2_inl6;
  wire initiator_worker_d7_msb_inl8_inl6;
  wire initiator_worker_d7_msb_inl9_inl6;
  wire        [7:0] initiator_worker_d7_raw_data_inl1_inl2_inl65;
  wire        [7:0] initiator_worker_d7_raw_data_inl8_inl65;
  wire        [7:0] initiator_worker_d7_raw_data_inl9_inl65;
  wire        [7:0] initiator_worker_d7_reg_addr;
  wire        [7:0] initiator_worker_d7_send_data;
  wire        [7:0] initiator_worker_d7_t827_inl1_inl2_inl6;
  wire        [7:0] initiator_worker_d7_t827_inl8_inl6;
  wire        [7:0] initiator_worker_d7_t827_inl9_inl6;
  reg initiator_worker_d7_ack_check_inl3_inl6;
  reg initiator_worker_d7_ack_check_inl4_inl6;
  reg initiator_worker_d7_ack_check_inl5_inl6;
  reg        [7:0] initiator_worker_d7_err_i_inl3_inl64;
  reg        [7:0] initiator_worker_d7_err_i_inl4_inl64;
  reg        [7:0] initiator_worker_d7_err_i_inl5_inl64;
  reg        [7:0] initiator_worker_d7_raw_data_inl1_inl2_inl64;
  reg        [7:0] initiator_worker_d7_raw_data_inl8_inl64;
  reg        [7:0] initiator_worker_d7_raw_data_inl9_inl64;
  reg        [6:0] initiator_worker_d7_state;
  wire signed [31:0] initiator_worker_d7_counter8064;
  wire signed [31:0] initiator_worker_d7_data_i;
  wire signed [31:0] initiator_worker_d7_i_inl1_inl2_inl65;
  wire signed [31:0] initiator_worker_d7_i_inl8_inl65;
  wire signed [31:0] initiator_worker_d7_i_inl9_inl65;
  wire signed [31:0] initiator_worker_d7_t1268;
  wire signed [31:0] initiator_worker_d7_t1269;
  wire signed [31:0] initiator_worker_d7_t1273;
  wire signed [31:0] initiator_worker_d7_t844;
  reg signed [31:0] initiator_worker_d7_counter8063;
  reg signed [31:0] initiator_worker_d7_i_inl1_inl2_inl64;
  reg signed [31:0] initiator_worker_d7_i_inl8_inl64;
  reg signed [31:0] initiator_worker_d7_i_inl9_inl64;
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
      231: begin
        ov2640_data = 65535;
      end
    endcase
  end
  endfunction
  assign initiator_worker_d7_c1249 = (initiator_worker_d7_c843 && initiator_worker_d7_c826_inl1_inl2_inl6);
  assign initiator_worker_d7_c1251 = (initiator_worker_d7_c843 && initiator_worker_d7_c822_inl3_inl6);
  assign initiator_worker_d7_c1252 = (initiator_worker_d7_c1251 && initiator_worker_d7_c823_inl3_inl6);
  assign initiator_worker_d7_c1253 = (initiator_worker_d7_c1251 && !initiator_worker_d7_c823_inl3_inl6);
  assign initiator_worker_d7_c1254 = (initiator_worker_d7_c843 && initiator_worker_d7_c817_inl6);
  assign initiator_worker_d7_c1255 = (initiator_worker_d7_c843 && !initiator_worker_d7_c817_inl6);
  assign initiator_worker_d7_c1256 = (initiator_worker_d7_c1255 && initiator_worker_d7_c826_inl8_inl6);
  assign initiator_worker_d7_c1258 = (initiator_worker_d7_c1255 && initiator_worker_d7_c822_inl4_inl6);
  assign initiator_worker_d7_c1259 = (initiator_worker_d7_c1258 && initiator_worker_d7_c823_inl4_inl6);
  assign initiator_worker_d7_c1260 = (initiator_worker_d7_c1258 && !initiator_worker_d7_c823_inl4_inl6);
  assign initiator_worker_d7_c1261 = (initiator_worker_d7_c1255 && !initiator_worker_d7_c822_inl4_inl6);
  assign initiator_worker_d7_c1262 = (initiator_worker_d7_c1272 && initiator_worker_d7_c826_inl9_inl6);
  assign initiator_worker_d7_c1264 = (initiator_worker_d7_c1276 && initiator_worker_d7_c822_inl5_inl6);
  assign initiator_worker_d7_c1265 = (initiator_worker_d7_c1264 && initiator_worker_d7_c823_inl5_inl6);
  assign initiator_worker_d7_c1266 = (initiator_worker_d7_c1264 && !initiator_worker_d7_c823_inl5_inl6);
  assign initiator_worker_d7_c1267 = (initiator_worker_d7_c1277 && !initiator_worker_d7_c822_inl5_inl6);
  assign initiator_worker_d7_c1270 = (initiator_worker_d7_c1261 || initiator_worker_d7_c1259);
  assign initiator_worker_d7_c1271 = (initiator_worker_d7_c1261 || initiator_worker_d7_c1259);
  assign initiator_worker_d7_c1272 = (initiator_worker_d7_c1261 || initiator_worker_d7_c1259);
  assign initiator_worker_d7_c1274 = (initiator_worker_d7_c1261 || initiator_worker_d7_c1259);
  assign initiator_worker_d7_c1275 = (initiator_worker_d7_c1261 || initiator_worker_d7_c1259);
  assign initiator_worker_d7_c1276 = (initiator_worker_d7_c1261 || initiator_worker_d7_c1259);
  assign initiator_worker_d7_c1277 = (initiator_worker_d7_c1261 || initiator_worker_d7_c1259);
  assign initiator_worker_d7_c1278 = (initiator_worker_d7_c1267 || initiator_worker_d7_c1265);
  assign initiator_worker_d7_c1627 = (initiator_worker_d7_c843 && initiator_worker_d7_c826_inl1_inl2_inl6);
  assign initiator_worker_d7_c1628 = (initiator_worker_d7_c843 && initiator_worker_d7_c822_inl3_inl6);
  assign initiator_worker_d7_c1629 = (initiator_worker_d7_c1628 && initiator_worker_d7_c823_inl3_inl6);
  assign initiator_worker_d7_c1630 = (initiator_worker_d7_c1628 && !initiator_worker_d7_c823_inl3_inl6);
  assign initiator_worker_d7_c1631 = (initiator_worker_d7_c843 && initiator_worker_d7_c817_inl6);
  assign initiator_worker_d7_c1632 = (initiator_worker_d7_c843 && !initiator_worker_d7_c817_inl6);
  assign initiator_worker_d7_c1633 = (initiator_worker_d7_c1632 && initiator_worker_d7_c826_inl8_inl6);
  assign initiator_worker_d7_c1634 = (initiator_worker_d7_c1632 && initiator_worker_d7_c822_inl4_inl6);
  assign initiator_worker_d7_c1635 = (initiator_worker_d7_c1634 && initiator_worker_d7_c823_inl4_inl6);
  assign initiator_worker_d7_c1636 = (initiator_worker_d7_c1634 && !initiator_worker_d7_c823_inl4_inl6);
  assign initiator_worker_d7_c1637 = (initiator_worker_d7_c1632 && !initiator_worker_d7_c822_inl4_inl6);
  assign initiator_worker_d7_c1638 = ((initiator_worker_d7_c1637 || initiator_worker_d7_c1635) && initiator_worker_d7_c826_inl9_inl6);
  assign initiator_worker_d7_c1639 = ((initiator_worker_d7_c1637 || initiator_worker_d7_c1635) && initiator_worker_d7_c822_inl5_inl6);
  assign initiator_worker_d7_c1640 = (initiator_worker_d7_c1639 && initiator_worker_d7_c823_inl5_inl6);
  assign initiator_worker_d7_c1641 = (initiator_worker_d7_c1639 && !initiator_worker_d7_c823_inl5_inl6);
  assign initiator_worker_d7_c1642 = ((initiator_worker_d7_c1637 || initiator_worker_d7_c1635) && !initiator_worker_d7_c822_inl5_inl6);
  assign initiator_worker_d7_c817_inl6 = (initiator_worker_d7_err_i_inl3_inl67 > 0);
  assign initiator_worker_d7_c822_inl3_inl6 = (initiator_worker_d7_err_i_inl3_inl64 < 16);
  assign initiator_worker_d7_c822_inl4_inl6 = (initiator_worker_d7_err_i_inl4_inl64 < 16);
  assign initiator_worker_d7_c822_inl5_inl6 = (initiator_worker_d7_err_i_inl5_inl64 < 16);
  assign initiator_worker_d7_c823_inl3_inl6 = (initiator_worker_d7_ack_check_inl3_inl6 == 0);
  assign initiator_worker_d7_c823_inl4_inl6 = (initiator_worker_d7_ack_check_inl4_inl6 == 0);
  assign initiator_worker_d7_c823_inl5_inl6 = (initiator_worker_d7_ack_check_inl5_inl6 == 0);
  assign initiator_worker_d7_c826_inl1_inl2_inl6 = (initiator_worker_d7_i_inl1_inl2_inl64 < 8);
  assign initiator_worker_d7_c826_inl8_inl6 = (initiator_worker_d7_i_inl8_inl64 < 8);
  assign initiator_worker_d7_c826_inl9_inl6 = (initiator_worker_d7_i_inl9_inl64 < 8);
  assign initiator_worker_d7_c828_inl1_inl2_inl6 = (initiator_worker_d7_t827_inl1_inl2_inl6 == 128);
  assign initiator_worker_d7_c828_inl8_inl6 = (initiator_worker_d7_t827_inl8_inl6 == 128);
  assign initiator_worker_d7_c828_inl9_inl6 = (initiator_worker_d7_t827_inl9_inl6 == 128);
  assign initiator_worker_d7_c843 = (initiator_worker_d7_counter8063 < 232);
  assign initiator_worker_d7_counter8064 = (initiator_worker_d7_counter8063 + 1);
  assign initiator_worker_d7_data_i = ov2640_data(initiator_worker_d7_counter8063);
  assign initiator_worker_d7_err_i_inl3_inl66 = (initiator_worker_d7_err_i_inl3_inl64 + 1);
  assign initiator_worker_d7_err_i_inl3_inl67 = initiator_worker_d7_c1252 ? 0 : (initiator_worker_d7_c843 && !initiator_worker_d7_c822_inl3_inl6) ? initiator_worker_d7_err_i_inl3_inl64 : 'bz;
  assign initiator_worker_d7_err_i_inl4_inl66 = (initiator_worker_d7_err_i_inl4_inl64 + 1);
  assign initiator_worker_d7_err_i_inl5_inl66 = (initiator_worker_d7_err_i_inl5_inl64 + 1);
  assign initiator_worker_d7_i_inl1_inl2_inl65 = (initiator_worker_d7_i_inl1_inl2_inl64 + 1);
  assign initiator_worker_d7_i_inl8_inl65 = (initiator_worker_d7_i_inl8_inl64 + 1);
  assign initiator_worker_d7_i_inl9_inl65 = (initiator_worker_d7_i_inl9_inl64 + 1);
  assign initiator_worker_d7_msb_inl1_inl2_inl6 = initiator_worker_d7_t1268;
  assign initiator_worker_d7_msb_inl8_inl6 = initiator_worker_d7_t1269;
  assign initiator_worker_d7_msb_inl9_inl6 = initiator_worker_d7_t1273;
  assign initiator_worker_d7_raw_data_inl1_inl2_inl65 = (initiator_worker_d7_raw_data_inl1_inl2_inl64 << 1);
  assign initiator_worker_d7_raw_data_inl8_inl65 = (initiator_worker_d7_raw_data_inl8_inl64 << 1);
  assign initiator_worker_d7_raw_data_inl9_inl65 = (initiator_worker_d7_raw_data_inl9_inl64 << 1);
  assign initiator_worker_d7_reg_addr = (initiator_worker_d7_t844 & 255);
  assign initiator_worker_d7_send_data = (initiator_worker_d7_data_i & 255);
  assign initiator_worker_d7_t1268 = initiator_worker_d7_c828_inl1_inl2_inl6 ? 1 : 0;
  assign initiator_worker_d7_t1269 = initiator_worker_d7_c828_inl8_inl6 ? 1 : 0;
  assign initiator_worker_d7_t1273 = initiator_worker_d7_c828_inl9_inl6 ? 1 : 0;
  assign initiator_worker_d7_t827_inl1_inl2_inl6 = (initiator_worker_d7_raw_data_inl1_inl2_inl64 & 128);
  assign initiator_worker_d7_t827_inl8_inl6 = (initiator_worker_d7_raw_data_inl8_inl64 & 128);
  assign initiator_worker_d7_t827_inl9_inl6 = (initiator_worker_d7_raw_data_inl9_inl64 & 128);
  assign initiator_worker_d7_t844 = (initiator_worker_d7_data_i >>> 8);
  
  always @(posedge clk) begin
    if (rst) begin
      debug_print_pin <= 0;
      done <= 0;
      i2c_scl_o <= 0;
      i2c_scl_t <= 0;
      i2c_sda_o <= 0;
      i2c_sda_t <= 0;
      initiator_worker_d7_ack_check_inl3_inl6 <= 0;
      initiator_worker_d7_ack_check_inl4_inl6 <= 0;
      initiator_worker_d7_ack_check_inl5_inl6 <= 0;
      initiator_worker_d7_counter8063 <= 0;
      initiator_worker_d7_err_i_inl3_inl64 <= 0;
      initiator_worker_d7_err_i_inl4_inl64 <= 0;
      initiator_worker_d7_err_i_inl5_inl64 <= 0;
      initiator_worker_d7_i_inl1_inl2_inl64 <= 0;
      initiator_worker_d7_i_inl8_inl64 <= 0;
      initiator_worker_d7_i_inl9_inl64 <= 0;
      initiator_worker_d7_raw_data_inl1_inl2_inl64 <= 0;
      initiator_worker_d7_raw_data_inl8_inl64 <= 0;
      initiator_worker_d7_raw_data_inl9_inl64 <= 0;
      initiator_worker_d7_state <= ov2640_initiator_worker_d7_b1_INIT;
    end else begin //if (rst)
      case(initiator_worker_d7_state)
      ov2640_initiator_worker_d7_b1_INIT: begin
        i2c_scl_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_b1_S1;
      end
      ov2640_initiator_worker_d7_b1_S1: begin
        i2c_scl_t <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_b1_S2;
      end
      ov2640_initiator_worker_d7_b1_S2: begin
        i2c_sda_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_b1_S3;
      end
      ov2640_initiator_worker_d7_b1_S3: begin
        i2c_sda_t <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_b1_S4;
      end
      ov2640_initiator_worker_d7_b1_S4: begin
        done <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_b1_S5;
      end
      ov2640_initiator_worker_d7_b1_S5: begin
        debug_print_pin <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L1_while2_S0;
      end
      ov2640_initiator_worker_d7_L1_while2_S0: begin
        initiator_worker_d7_counter8063 <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_fortest4_S0;
      end
      ov2640_initiator_worker_d7_L1_forelse36_S1: begin
        debug_print_pin <= 242;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L1_forelse36_S2;
      end
      ov2640_initiator_worker_d7_L1_forelse36_S2: begin
        if (resend == 1) begin
          debug_print_pin <= 243;
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L1_while2_S0;
        end
      end
      ov2640_initiator_worker_d7_L2_fortest4_S0: begin
        /* initiator_worker_d7_c843 <= (initiator_worker_d7_counter8063 < 232); */
        if (initiator_worker_d7_c843) begin
          i2c_sda_o <= 0;
          /* initiator_worker_d7_data_i <= ov2640_data(initiator_worker_d7_counter8063); */
          /* initiator_worker_d7_t844 <= (initiator_worker_d7_data_i >>> 8); */
          /* initiator_worker_d7_send_data <= (initiator_worker_d7_data_i & 255); */
          /* initiator_worker_d7_reg_addr <= (initiator_worker_d7_t844 & 255); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_forbody5_S1;
        end else begin
          done <= 1;
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L1_forelse36_S1;
        end
      end
      ov2640_initiator_worker_d7_L2_forbody5_S1: begin
        i2c_scl_o <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_forbody5_S2;
      end
      ov2640_initiator_worker_d7_L2_forbody5_S2: begin
        i2c_sda_t <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_forbody5_S3;
      end
      ov2640_initiator_worker_d7_L2_forbody5_S3: begin
        initiator_worker_d7_i_inl1_inl2_inl64 <= 0;
        initiator_worker_d7_raw_data_inl1_inl2_inl64 <= 96;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L3_fortest6_S0;
      end
      ov2640_initiator_worker_d7_L2_forelse9_S1: begin
        i2c_sda_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L4_while10_S0;
      end
      ov2640_initiator_worker_d7_L2_whileexit14_S0: begin
        i2c_sda_t <= 0;
        /* initiator_worker_d7_err_i_inl3_inl67 <= initiator_worker_d7_c1252 ? 0 : (initiator_worker_d7_c843 && !initiator_worker_d7_c822_inl3_inl6) ? initiator_worker_d7_err_i_inl3_inl64 : 'bz; */
        /* initiator_worker_d7_c817_inl6 <= (initiator_worker_d7_err_i_inl3_inl67 > 0); */
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit14_S1;
      end
      ov2640_initiator_worker_d7_L2_whileexit14_S1: begin
        if (initiator_worker_d7_c817_inl6) begin
          i2c_scl_o <= 1;
          /* initiator_worker_d7_c1631 <= (initiator_worker_d7_c843 && initiator_worker_d7_c817_inl6); */
          /* initiator_worker_d7_c1254 <= (initiator_worker_d7_c843 && initiator_worker_d7_c817_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_ifthen15_S1;
        end else begin
          i2c_sda_t <= 0;
          /* initiator_worker_d7_c1632 <= (initiator_worker_d7_c843 && !initiator_worker_d7_c817_inl6); */
          /* initiator_worker_d7_c1255 <= (initiator_worker_d7_c843 && !initiator_worker_d7_c817_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_ifelse17_S1;
        end
      end
      ov2640_initiator_worker_d7_L2_ifthen15_S1: begin
        i2c_sda_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_ifthen15_S2;
      end
      ov2640_initiator_worker_d7_L2_ifthen15_S2: begin
        /*wait a cycle*/
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_ifthen15_S3;
      end
      ov2640_initiator_worker_d7_L2_ifthen15_S3: begin
        /*wait a cycle*/
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_exit16_S0;
      end
      ov2640_initiator_worker_d7_L2_ifelse17_S1: begin
        initiator_worker_d7_i_inl8_inl64 <= 0;
        initiator_worker_d7_raw_data_inl8_inl64 <= initiator_worker_d7_reg_addr;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L5_fortest18_S0;
      end
      ov2640_initiator_worker_d7_L2_forelse21_S1: begin
        i2c_sda_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L6_while22_S0;
      end
      ov2640_initiator_worker_d7_L2_whileexit26_S0: begin
        i2c_sda_t <= 0;
        /* initiator_worker_d7_c1637 <= (initiator_worker_d7_c1632 && !initiator_worker_d7_c822_inl4_inl6); */
        /* initiator_worker_d7_c1261 <= (initiator_worker_d7_c1255 && !initiator_worker_d7_c822_inl4_inl6); */
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit26_S1;
      end
      ov2640_initiator_worker_d7_L2_whileexit26_S1: begin
        i2c_sda_t <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit26_S2;
      end
      ov2640_initiator_worker_d7_L2_whileexit26_S2: begin
        /* initiator_worker_d7_c1270 <= (initiator_worker_d7_c1261 || initiator_worker_d7_c1259); */
        initiator_worker_d7_i_inl9_inl64 <= 0;
        initiator_worker_d7_raw_data_inl9_inl64 <= initiator_worker_d7_send_data;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L7_fortest27_S0;
      end
      ov2640_initiator_worker_d7_L2_forelse30_S1: begin
        i2c_sda_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L8_while31_S0;
      end
      ov2640_initiator_worker_d7_L2_whileexit35_S0: begin
        i2c_sda_t <= 0;
        /* initiator_worker_d7_c1642 <= ((initiator_worker_d7_c1637 || initiator_worker_d7_c1635) && !initiator_worker_d7_c822_inl5_inl6); */
        /* initiator_worker_d7_c1277 <= (initiator_worker_d7_c1261 || initiator_worker_d7_c1259); */
        /* initiator_worker_d7_c1267 <= (initiator_worker_d7_c1277 && !initiator_worker_d7_c822_inl5_inl6); */
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit35_S1;
      end
      ov2640_initiator_worker_d7_L2_whileexit35_S1: begin
        i2c_scl_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit35_S2;
      end
      ov2640_initiator_worker_d7_L2_whileexit35_S2: begin
        i2c_sda_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit35_S3;
      end
      ov2640_initiator_worker_d7_L2_whileexit35_S3: begin
        /*wait a cycle*/
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit35_S4;
      end
      ov2640_initiator_worker_d7_L2_whileexit35_S4: begin
        /*wait a cycle*/
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit35_S5;
      end
      ov2640_initiator_worker_d7_L2_whileexit35_S5: begin
        /* initiator_worker_d7_c1278 <= (initiator_worker_d7_c1267 || initiator_worker_d7_c1265); */
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_exit16_S0;
      end
      ov2640_initiator_worker_d7_L2_exit16_S0: begin
        debug_print_pin <= initiator_worker_d7_send_data;
        /* initiator_worker_d7_counter8064 <= (initiator_worker_d7_counter8063 + 1); */
        initiator_worker_d7_counter8063 <= initiator_worker_d7_counter8064;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_fortest4_S0;
      end
      ov2640_initiator_worker_d7_L3_fortest6_S0: begin
        /* initiator_worker_d7_c826_inl1_inl2_inl6 <= (initiator_worker_d7_i_inl1_inl2_inl64 < 8); */
        if (initiator_worker_d7_c826_inl1_inl2_inl6) begin
          i2c_sda_o <= initiator_worker_d7_msb_inl1_inl2_inl6;
          /* initiator_worker_d7_t827_inl1_inl2_inl6 <= (initiator_worker_d7_raw_data_inl1_inl2_inl64 & 128); */
          /* initiator_worker_d7_raw_data_inl1_inl2_inl65 <= (initiator_worker_d7_raw_data_inl1_inl2_inl64 << 1); */
          /* initiator_worker_d7_c1627 <= (initiator_worker_d7_c843 && initiator_worker_d7_c826_inl1_inl2_inl6); */
          /* initiator_worker_d7_c1249 <= (initiator_worker_d7_c843 && initiator_worker_d7_c826_inl1_inl2_inl6); */
          /* initiator_worker_d7_c828_inl1_inl2_inl6 <= (initiator_worker_d7_t827_inl1_inl2_inl6 == 128); */
          /* initiator_worker_d7_t1268 <= initiator_worker_d7_c828_inl1_inl2_inl6 ? 1 : 0; */
          /* initiator_worker_d7_msb_inl1_inl2_inl6 <= initiator_worker_d7_t1268; */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L3_forbody7_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_worker_d7_err_i_inl3_inl64 <= 0;
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_forelse9_S1;
        end
      end
      ov2640_initiator_worker_d7_L3_forbody7_S1: begin
        i2c_scl_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L3_forbody7_S2;
      end
      ov2640_initiator_worker_d7_L3_forbody7_S2: begin
        i2c_scl_o <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L3_forbody7_S3;
      end
      ov2640_initiator_worker_d7_L3_forbody7_S3: begin
        /* initiator_worker_d7_i_inl1_inl2_inl65 <= (initiator_worker_d7_i_inl1_inl2_inl64 + 1); */
        initiator_worker_d7_raw_data_inl1_inl2_inl64 <= initiator_worker_d7_raw_data_inl1_inl2_inl65;
        initiator_worker_d7_i_inl1_inl2_inl64 <= initiator_worker_d7_i_inl1_inl2_inl65;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L3_fortest6_S0;
      end
      ov2640_initiator_worker_d7_L4_while10_S0: begin
        /* initiator_worker_d7_c822_inl3_inl6 <= (initiator_worker_d7_err_i_inl3_inl64 < 16); */
        if (initiator_worker_d7_c822_inl3_inl6) begin
          i2c_scl_o <= 1;
          /* initiator_worker_d7_c1628 <= (initiator_worker_d7_c843 && initiator_worker_d7_c822_inl3_inl6); */
          /* initiator_worker_d7_c1251 <= (initiator_worker_d7_c843 && initiator_worker_d7_c822_inl3_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L4_whilebody11_S1;
        end else begin
          i2c_sda_t <= 0;
          /* initiator_worker_d7_err_i_inl3_inl67 <= initiator_worker_d7_c1252 ? 0 : (initiator_worker_d7_c843 && !initiator_worker_d7_c822_inl3_inl6) ? initiator_worker_d7_err_i_inl3_inl64 : 'bz; */
          /* initiator_worker_d7_c817_inl6 <= (initiator_worker_d7_err_i_inl3_inl67 > 0); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit14_S1;
        end
      end
      ov2640_initiator_worker_d7_L4_whilebody11_S1: begin
        initiator_worker_d7_ack_check_inl3_inl6 <= i2c_sda_i;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L4_whilebody11_S2;
      end
      ov2640_initiator_worker_d7_L4_whilebody11_S2: begin
        i2c_scl_o <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L4_whilebody11_S3;
      end
      ov2640_initiator_worker_d7_L4_whilebody11_S3: begin
        /* initiator_worker_d7_c823_inl3_inl6 <= (initiator_worker_d7_ack_check_inl3_inl6 == 0); */
        if (initiator_worker_d7_c823_inl3_inl6) begin
          /* initiator_worker_d7_c1629 <= (initiator_worker_d7_c1628 && initiator_worker_d7_c823_inl3_inl6); */
          /* initiator_worker_d7_c1252 <= (initiator_worker_d7_c1251 && initiator_worker_d7_c823_inl3_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit14_S0;
        end else begin
          /* initiator_worker_d7_err_i_inl3_inl66 <= (initiator_worker_d7_err_i_inl3_inl64 + 1); */
          initiator_worker_d7_err_i_inl3_inl64 <= initiator_worker_d7_err_i_inl3_inl66;
          /* initiator_worker_d7_c1630 <= (initiator_worker_d7_c1628 && !initiator_worker_d7_c823_inl3_inl6); */
          /* initiator_worker_d7_c1253 <= (initiator_worker_d7_c1251 && !initiator_worker_d7_c823_inl3_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L4_while10_S0;
        end
      end
      ov2640_initiator_worker_d7_L5_fortest18_S0: begin
        /* initiator_worker_d7_c826_inl8_inl6 <= (initiator_worker_d7_i_inl8_inl64 < 8); */
        if (initiator_worker_d7_c826_inl8_inl6) begin
          i2c_sda_o <= initiator_worker_d7_msb_inl8_inl6;
          /* initiator_worker_d7_t827_inl8_inl6 <= (initiator_worker_d7_raw_data_inl8_inl64 & 128); */
          /* initiator_worker_d7_raw_data_inl8_inl65 <= (initiator_worker_d7_raw_data_inl8_inl64 << 1); */
          /* initiator_worker_d7_c1633 <= (initiator_worker_d7_c1632 && initiator_worker_d7_c826_inl8_inl6); */
          /* initiator_worker_d7_c1256 <= (initiator_worker_d7_c1255 && initiator_worker_d7_c826_inl8_inl6); */
          /* initiator_worker_d7_c828_inl8_inl6 <= (initiator_worker_d7_t827_inl8_inl6 == 128); */
          /* initiator_worker_d7_t1269 <= initiator_worker_d7_c828_inl8_inl6 ? 1 : 0; */
          /* initiator_worker_d7_msb_inl8_inl6 <= initiator_worker_d7_t1269; */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L5_forbody19_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_worker_d7_err_i_inl4_inl64 <= 0;
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_forelse21_S1;
        end
      end
      ov2640_initiator_worker_d7_L5_forbody19_S1: begin
        i2c_scl_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L5_forbody19_S2;
      end
      ov2640_initiator_worker_d7_L5_forbody19_S2: begin
        i2c_scl_o <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L5_forbody19_S3;
      end
      ov2640_initiator_worker_d7_L5_forbody19_S3: begin
        /* initiator_worker_d7_i_inl8_inl65 <= (initiator_worker_d7_i_inl8_inl64 + 1); */
        initiator_worker_d7_raw_data_inl8_inl64 <= initiator_worker_d7_raw_data_inl8_inl65;
        initiator_worker_d7_i_inl8_inl64 <= initiator_worker_d7_i_inl8_inl65;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L5_fortest18_S0;
      end
      ov2640_initiator_worker_d7_L6_while22_S0: begin
        /* initiator_worker_d7_c822_inl4_inl6 <= (initiator_worker_d7_err_i_inl4_inl64 < 16); */
        if (initiator_worker_d7_c822_inl4_inl6) begin
          i2c_scl_o <= 1;
          /* initiator_worker_d7_c1634 <= (initiator_worker_d7_c1632 && initiator_worker_d7_c822_inl4_inl6); */
          /* initiator_worker_d7_c1258 <= (initiator_worker_d7_c1255 && initiator_worker_d7_c822_inl4_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L6_whilebody23_S1;
        end else begin
          i2c_sda_t <= 0;
          /* initiator_worker_d7_c1637 <= (initiator_worker_d7_c1632 && !initiator_worker_d7_c822_inl4_inl6); */
          /* initiator_worker_d7_c1261 <= (initiator_worker_d7_c1255 && !initiator_worker_d7_c822_inl4_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit26_S1;
        end
      end
      ov2640_initiator_worker_d7_L6_whilebody23_S1: begin
        initiator_worker_d7_ack_check_inl4_inl6 <= i2c_sda_i;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L6_whilebody23_S2;
      end
      ov2640_initiator_worker_d7_L6_whilebody23_S2: begin
        i2c_scl_o <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L6_whilebody23_S3;
      end
      ov2640_initiator_worker_d7_L6_whilebody23_S3: begin
        /* initiator_worker_d7_c823_inl4_inl6 <= (initiator_worker_d7_ack_check_inl4_inl6 == 0); */
        if (initiator_worker_d7_c823_inl4_inl6) begin
          /* initiator_worker_d7_c1635 <= (initiator_worker_d7_c1634 && initiator_worker_d7_c823_inl4_inl6); */
          /* initiator_worker_d7_c1259 <= (initiator_worker_d7_c1258 && initiator_worker_d7_c823_inl4_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit26_S0;
        end else begin
          /* initiator_worker_d7_err_i_inl4_inl66 <= (initiator_worker_d7_err_i_inl4_inl64 + 1); */
          initiator_worker_d7_err_i_inl4_inl64 <= initiator_worker_d7_err_i_inl4_inl66;
          /* initiator_worker_d7_c1636 <= (initiator_worker_d7_c1634 && !initiator_worker_d7_c823_inl4_inl6); */
          /* initiator_worker_d7_c1260 <= (initiator_worker_d7_c1258 && !initiator_worker_d7_c823_inl4_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L6_while22_S0;
        end
      end
      ov2640_initiator_worker_d7_L7_fortest27_S0: begin
        /* initiator_worker_d7_c826_inl9_inl6 <= (initiator_worker_d7_i_inl9_inl64 < 8); */
        /* initiator_worker_d7_c1271 <= (initiator_worker_d7_c1261 || initiator_worker_d7_c1259); */
        if (initiator_worker_d7_c826_inl9_inl6) begin
          i2c_sda_o <= initiator_worker_d7_msb_inl9_inl6;
          /* initiator_worker_d7_c1272 <= (initiator_worker_d7_c1261 || initiator_worker_d7_c1259); */
          /* initiator_worker_d7_t827_inl9_inl6 <= (initiator_worker_d7_raw_data_inl9_inl64 & 128); */
          /* initiator_worker_d7_raw_data_inl9_inl65 <= (initiator_worker_d7_raw_data_inl9_inl64 << 1); */
          /* initiator_worker_d7_c1638 <= ((initiator_worker_d7_c1637 || initiator_worker_d7_c1635) && initiator_worker_d7_c826_inl9_inl6); */
          /* initiator_worker_d7_c1262 <= (initiator_worker_d7_c1272 && initiator_worker_d7_c826_inl9_inl6); */
          /* initiator_worker_d7_c828_inl9_inl6 <= (initiator_worker_d7_t827_inl9_inl6 == 128); */
          /* initiator_worker_d7_t1273 <= initiator_worker_d7_c828_inl9_inl6 ? 1 : 0; */
          /* initiator_worker_d7_msb_inl9_inl6 <= initiator_worker_d7_t1273; */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L7_forbody28_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_worker_d7_err_i_inl5_inl64 <= 0;
          /* initiator_worker_d7_c1274 <= (initiator_worker_d7_c1261 || initiator_worker_d7_c1259); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_forelse30_S1;
        end
      end
      ov2640_initiator_worker_d7_L7_forbody28_S1: begin
        i2c_scl_o <= 1;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L7_forbody28_S2;
      end
      ov2640_initiator_worker_d7_L7_forbody28_S2: begin
        i2c_scl_o <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L7_forbody28_S3;
      end
      ov2640_initiator_worker_d7_L7_forbody28_S3: begin
        /* initiator_worker_d7_i_inl9_inl65 <= (initiator_worker_d7_i_inl9_inl64 + 1); */
        initiator_worker_d7_raw_data_inl9_inl64 <= initiator_worker_d7_raw_data_inl9_inl65;
        initiator_worker_d7_i_inl9_inl64 <= initiator_worker_d7_i_inl9_inl65;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L7_fortest27_S0;
      end
      ov2640_initiator_worker_d7_L8_while31_S0: begin
        /* initiator_worker_d7_c822_inl5_inl6 <= (initiator_worker_d7_err_i_inl5_inl64 < 16); */
        /* initiator_worker_d7_c1275 <= (initiator_worker_d7_c1261 || initiator_worker_d7_c1259); */
        if (initiator_worker_d7_c822_inl5_inl6) begin
          i2c_scl_o <= 1;
          /* initiator_worker_d7_c1276 <= (initiator_worker_d7_c1261 || initiator_worker_d7_c1259); */
          /* initiator_worker_d7_c1639 <= ((initiator_worker_d7_c1637 || initiator_worker_d7_c1635) && initiator_worker_d7_c822_inl5_inl6); */
          /* initiator_worker_d7_c1264 <= (initiator_worker_d7_c1276 && initiator_worker_d7_c822_inl5_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L8_whilebody32_S1;
        end else begin
          i2c_sda_t <= 0;
          /* initiator_worker_d7_c1642 <= ((initiator_worker_d7_c1637 || initiator_worker_d7_c1635) && !initiator_worker_d7_c822_inl5_inl6); */
          /* initiator_worker_d7_c1277 <= (initiator_worker_d7_c1261 || initiator_worker_d7_c1259); */
          /* initiator_worker_d7_c1267 <= (initiator_worker_d7_c1277 && !initiator_worker_d7_c822_inl5_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit35_S1;
        end
      end
      ov2640_initiator_worker_d7_L8_whilebody32_S1: begin
        initiator_worker_d7_ack_check_inl5_inl6 <= i2c_sda_i;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L8_whilebody32_S2;
      end
      ov2640_initiator_worker_d7_L8_whilebody32_S2: begin
        i2c_scl_o <= 0;
        initiator_worker_d7_state <= ov2640_initiator_worker_d7_L8_whilebody32_S3;
      end
      ov2640_initiator_worker_d7_L8_whilebody32_S3: begin
        /* initiator_worker_d7_c823_inl5_inl6 <= (initiator_worker_d7_ack_check_inl5_inl6 == 0); */
        if (initiator_worker_d7_c823_inl5_inl6) begin
          /* initiator_worker_d7_c1640 <= (initiator_worker_d7_c1639 && initiator_worker_d7_c823_inl5_inl6); */
          /* initiator_worker_d7_c1265 <= (initiator_worker_d7_c1264 && initiator_worker_d7_c823_inl5_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L2_whileexit35_S0;
        end else begin
          /* initiator_worker_d7_err_i_inl5_inl66 <= (initiator_worker_d7_err_i_inl5_inl64 + 1); */
          initiator_worker_d7_err_i_inl5_inl64 <= initiator_worker_d7_err_i_inl5_inl66;
          /* initiator_worker_d7_c1641 <= (initiator_worker_d7_c1639 && !initiator_worker_d7_c823_inl5_inl6); */
          /* initiator_worker_d7_c1266 <= (initiator_worker_d7_c1264 && !initiator_worker_d7_c823_inl5_inl6); */
          initiator_worker_d7_state <= ov2640_initiator_worker_d7_L8_while31_S0;
        end
      end
      endcase
    end
  end
  

endmodule


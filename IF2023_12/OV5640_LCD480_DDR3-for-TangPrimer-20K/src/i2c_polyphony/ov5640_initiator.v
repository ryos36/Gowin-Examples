module ov5640_initiator
  (
    input wire clk,
    input wire rst,
    output reg done = 0,
    output reg [7:0] debug_print_pin = 0,
    input wire resend,
    output reg i2c_scl_o = 0,
    output reg i2c_scl_t = 1,
    output reg i2c_sda_o = 0,
    output reg i2c_sda_t = 1,
    input wire i2c_sda_i,
    input wire i2c_scl_i
  );

  //localparams
  localparam ov5640_initiator_worker_dj_b1_INIT = 0;
  localparam ov5640_initiator_worker_dj_b1_S1 = 1;
  localparam ov5640_initiator_worker_dj_b1_S2 = 2;
  localparam ov5640_initiator_worker_dj_b1_FINISH = 3;
  localparam ov5640_initiator_worker_dj_L1_while2_S0 = 4;
  localparam ov5640_initiator_worker_dj_L1_while2_S1 = 5;
  localparam ov5640_initiator_worker_dj_L1_while2_S2 = 6;
  localparam ov5640_initiator_worker_dj_L1_forelse9_S0 = 7;
  localparam ov5640_initiator_worker_dj_L1_forelse9_S1 = 8;
  localparam ov5640_initiator_worker_dj_L1_forelse9_S2 = 9;
  localparam ov5640_initiator_worker_dj_L1_forelse9_S3 = 10;
  localparam ov5640_initiator_worker_dj_L1_forelse9_S4 = 11;
  localparam ov5640_initiator_worker_dj_L2_fortest4_S0 = 12;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S0 = 13;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S1 = 14;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S2 = 15;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S3 = 16;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S4 = 17;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S5 = 18;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S6 = 19;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S7 = 20;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S8 = 21;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S9 = 22;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S10 = 23;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S11 = 24;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S12 = 25;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S13 = 26;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S14 = 27;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S15 = 28;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S16 = 29;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S17 = 30;
  localparam ov5640_initiator_worker_dj_L2_forbody5_S18 = 31;
  localparam ov5640_initiator_worker_dj_L2_whileexit7_S0 = 32;
  localparam ov5640_initiator_worker_dj_L2_whileexit7_S1 = 33;
  localparam ov5640_initiator_worker_dj_L3_while6_S0 = 34;
  localparam ov5640_initiator_worker_dj_L3_while6_S1 = 35;
  localparam ov5640_initiator_worker_dj_L3_while6_S2 = 36;
  localparam ov5640_initiator_worker_dj_L3_while6_S3 = 37;
  localparam ov5640_initiator_worker_dj_L3_while6_S4 = 38;
  localparam ov5640_initiator_worker_dj_L3_ifelse8_S0 = 39;
  localparam ov5640_initiator_i2c_worker_50_dk_b1_INIT = 0;
  localparam ov5640_initiator_i2c_worker_50_dk_b1_S1 = 1;
  localparam ov5640_initiator_i2c_worker_50_dk_b1_S2 = 2;
  localparam ov5640_initiator_i2c_worker_50_dk_b1_S3 = 3;
  localparam ov5640_initiator_i2c_worker_50_dk_b1_S4 = 4;
  localparam ov5640_initiator_i2c_worker_50_dk_b1_FINISH = 5;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_while2_S0 = 6;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_while2_S1 = 7;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_while2_S2 = 8;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_while2_S3 = 9;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S0 = 10;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S1 = 11;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S2 = 12;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S3 = 13;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S4 = 14;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S5 = 15;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S6 = 16;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S7 = 17;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S8 = 18;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S9 = 19;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S10 = 20;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S0 = 21;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S1 = 22;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S2 = 23;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S3 = 24;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S4 = 25;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S5 = 26;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S6 = 27;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S7 = 28;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S0 = 29;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S1 = 30;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S2 = 31;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S3 = 32;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S4 = 33;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S5 = 34;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S6 = 35;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S7 = 36;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S8 = 37;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S9 = 38;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S10 = 39;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S11 = 40;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S12 = 41;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S13 = 42;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S0 = 43;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S1 = 44;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S2 = 45;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S3 = 46;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S4 = 47;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S5 = 48;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S6 = 49;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S7 = 50;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S8 = 51;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S9 = 52;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S10 = 53;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S0 = 54;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S1 = 55;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S2 = 56;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S3 = 57;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S4 = 58;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S5 = 59;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S6 = 60;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S7 = 61;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S8 = 62;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S9 = 63;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S10 = 64;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S11 = 65;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S12 = 66;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S13 = 67;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S14 = 68;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S15 = 69;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S16 = 70;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S17 = 71;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S18 = 72;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S19 = 73;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S0 = 74;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S1 = 75;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S2 = 76;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S3 = 77;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S4 = 78;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S5 = 79;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S6 = 80;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S7 = 81;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S8 = 82;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S9 = 83;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S10 = 84;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S11 = 85;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S12 = 86;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S13 = 87;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S0 = 88;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S1 = 89;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S2 = 90;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S3 = 91;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S4 = 92;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S5 = 93;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S6 = 94;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S7 = 95;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S8 = 96;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifelse96_S0 = 97;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifelse96_S1 = 98;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S0 = 99;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S1 = 100;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S2 = 101;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S3 = 102;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S4 = 103;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S5 = 104;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S6 = 105;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S7 = 106;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S8 = 107;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S0 = 108;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S1 = 109;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S2 = 110;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S3 = 111;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S4 = 112;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S5 = 113;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S6 = 114;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S7 = 115;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S8 = 116;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S0 = 117;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S1 = 118;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S2 = 119;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S3 = 120;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S4 = 121;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S5 = 122;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S6 = 123;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S7 = 124;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S8 = 125;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S0 = 126;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S1 = 127;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S2 = 128;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S3 = 129;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S4 = 130;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S5 = 131;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S6 = 132;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S7 = 133;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S8 = 134;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S0 = 135;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S1 = 136;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S2 = 137;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S3 = 138;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S4 = 139;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S5 = 140;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S6 = 141;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S7 = 142;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S8 = 143;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S9 = 144;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S10 = 145;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S11 = 146;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S0 = 147;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S1 = 148;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S2 = 149;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S3 = 150;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S4 = 151;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S5 = 152;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S6 = 153;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S7 = 154;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S8 = 155;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S0 = 156;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S1 = 157;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S2 = 158;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S3 = 159;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S4 = 160;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S5 = 161;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S6 = 162;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S7 = 163;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S8 = 164;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S9 = 165;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S10 = 166;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S0 = 167;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S1 = 168;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S2 = 169;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S3 = 170;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S4 = 171;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S5 = 172;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S6 = 173;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S7 = 174;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S8 = 175;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S9 = 176;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S10 = 177;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S11 = 178;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S0 = 179;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S1 = 180;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S2 = 181;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S3 = 182;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S4 = 183;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S5 = 184;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S6 = 185;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S7 = 186;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S8 = 187;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S0 = 188;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S1 = 189;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S2 = 190;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S3 = 191;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S4 = 192;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S5 = 193;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S6 = 194;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S7 = 195;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S8 = 196;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S9 = 197;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S10 = 198;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S11 = 199;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S12 = 200;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S13 = 201;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S0 = 202;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S1 = 203;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S2 = 204;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S3 = 205;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S4 = 206;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S5 = 207;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S6 = 208;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S7 = 209;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S8 = 210;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S0 = 211;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S1 = 212;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S2 = 213;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S3 = 214;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S4 = 215;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S5 = 216;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S6 = 217;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S7 = 218;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S8 = 219;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S0 = 220;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S1 = 221;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S2 = 222;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S3 = 223;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S4 = 224;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S5 = 225;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S6 = 226;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S7 = 227;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S8 = 228;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S9 = 229;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S10 = 230;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S0 = 231;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S1 = 232;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S2 = 233;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S3 = 234;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S4 = 235;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S5 = 236;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S6 = 237;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S7 = 238;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S8 = 239;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S0 = 240;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S1 = 241;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S2 = 242;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S3 = 243;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S4 = 244;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S5 = 245;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S6 = 246;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S7 = 247;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S8 = 248;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S0 = 249;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S1 = 250;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S2 = 251;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S3 = 252;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S4 = 253;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S5 = 254;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S6 = 255;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S7 = 256;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S8 = 257;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S9 = 258;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S10 = 259;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S11 = 260;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S12 = 261;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S13 = 262;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S14 = 263;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S0 = 264;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S1 = 265;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S2 = 266;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S3 = 267;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S4 = 268;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S5 = 269;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S6 = 270;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S7 = 271;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S8 = 272;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S9 = 273;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S10 = 274;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S11 = 275;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S0 = 276;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S1 = 277;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S2 = 278;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S3 = 279;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S4 = 280;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S5 = 281;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S6 = 282;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S7 = 283;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S8 = 284;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S9 = 285;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S10 = 286;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S11 = 287;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S12 = 288;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S13 = 289;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S0 = 290;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S1 = 291;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S2 = 292;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S3 = 293;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S4 = 294;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S5 = 295;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S6 = 296;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S7 = 297;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S8 = 298;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S0 = 299;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S1 = 300;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S2 = 301;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S3 = 302;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S4 = 303;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S5 = 304;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S6 = 305;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S7 = 306;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S8 = 307;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S9 = 308;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S10 = 309;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S11 = 310;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_b13_S0 = 311;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_b13_S1 = 312;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_b13_S2 = 313;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_b13_S3 = 314;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_b13_S4 = 315;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen14_S0 = 316;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen14_S1 = 317;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen14_S2 = 318;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_ifthen14_S3 = 319;
  localparam ov5640_initiator_i2c_worker_50_dk_L1_b15_S0 = 320;
  localparam ov5640_initiator_i2c_worker_50_dk_L2_fortest94_S0 = 321;
  localparam ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S0 = 322;
  localparam ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S1 = 323;
  localparam ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S2 = 324;
  localparam ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S3 = 325;
  localparam ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S4 = 326;
  localparam ov5640_initiator_i2c_worker_50_dk_L3_fortest73_S0 = 327;
  localparam ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S0 = 328;
  localparam ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S1 = 329;
  localparam ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S2 = 330;
  localparam ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S3 = 331;
  localparam ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S4 = 332;
  localparam ov5640_initiator_i2c_worker_50_dk_L4_fortest77_S0 = 333;
  localparam ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S0 = 334;
  localparam ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S1 = 335;
  localparam ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S2 = 336;
  localparam ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S3 = 337;
  localparam ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S4 = 338;
  localparam ov5640_initiator_i2c_worker_50_dk_L5_fortest81_S0 = 339;
  localparam ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S0 = 340;
  localparam ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S1 = 341;
  localparam ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S2 = 342;
  localparam ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S3 = 343;
  localparam ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S4 = 344;
  localparam ov5640_initiator_i2c_worker_50_dk_L6_fortest85_S0 = 345;
  localparam ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S0 = 346;
  localparam ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S1 = 347;
  localparam ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S2 = 348;
  localparam ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S3 = 349;
  localparam ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S4 = 350;
  localparam ov5640_initiator_i2c_worker_50_dk_L7_fortest89_S0 = 351;
  localparam ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S0 = 352;
  localparam ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S1 = 353;
  localparam ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S2 = 354;
  localparam ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S3 = 355;
  localparam ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S4 = 356;
  localparam ov5640_initiator_i2c_worker_50_dk_L8_fortest56_S0 = 357;
  localparam ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S0 = 358;
  localparam ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S1 = 359;
  localparam ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S2 = 360;
  localparam ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S3 = 361;
  localparam ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S4 = 362;
  localparam ov5640_initiator_i2c_worker_50_dk_L9_fortest60_S0 = 363;
  localparam ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S0 = 364;
  localparam ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S1 = 365;
  localparam ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S2 = 366;
  localparam ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S3 = 367;
  localparam ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S4 = 368;
  localparam ov5640_initiator_i2c_worker_50_dk_L10_fortest64_S0 = 369;
  localparam ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S0 = 370;
  localparam ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S1 = 371;
  localparam ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S2 = 372;
  localparam ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S3 = 373;
  localparam ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S4 = 374;
  localparam ov5640_initiator_i2c_worker_50_dk_L11_fortest68_S0 = 375;
  localparam ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S0 = 376;
  localparam ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S1 = 377;
  localparam ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S2 = 378;
  localparam ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S3 = 379;
  localparam ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S4 = 380;
  localparam ov5640_initiator_i2c_worker_50_dk_L12_fortest39_S0 = 381;
  localparam ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S0 = 382;
  localparam ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S1 = 383;
  localparam ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S2 = 384;
  localparam ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S3 = 385;
  localparam ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S4 = 386;
  localparam ov5640_initiator_i2c_worker_50_dk_L13_fortest43_S0 = 387;
  localparam ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S0 = 388;
  localparam ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S1 = 389;
  localparam ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S2 = 390;
  localparam ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S3 = 391;
  localparam ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S4 = 392;
  localparam ov5640_initiator_i2c_worker_50_dk_L14_fortest47_S0 = 393;
  localparam ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S0 = 394;
  localparam ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S1 = 395;
  localparam ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S2 = 396;
  localparam ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S3 = 397;
  localparam ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S4 = 398;
  localparam ov5640_initiator_i2c_worker_50_dk_L15_fortest51_S0 = 399;
  localparam ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S0 = 400;
  localparam ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S1 = 401;
  localparam ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S2 = 402;
  localparam ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S3 = 403;
  localparam ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S4 = 404;
  localparam ov5640_initiator_i2c_worker_50_dk_L16_fortest26_S0 = 405;
  localparam ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S0 = 406;
  localparam ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S1 = 407;
  localparam ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S2 = 408;
  localparam ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S3 = 409;
  localparam ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S4 = 410;
  localparam ov5640_initiator_i2c_worker_50_dk_L17_fortest30_S0 = 411;
  localparam ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S0 = 412;
  localparam ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S1 = 413;
  localparam ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S2 = 414;
  localparam ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S3 = 415;
  localparam ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S4 = 416;
  localparam ov5640_initiator_i2c_worker_50_dk_L18_fortest34_S0 = 417;
  localparam ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S0 = 418;
  localparam ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S1 = 419;
  localparam ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S2 = 420;
  localparam ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S3 = 421;
  localparam ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S4 = 422;
  localparam ov5640_initiator_i2c_worker_50_dk_L19_fortest17_S0 = 423;
  localparam ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S0 = 424;
  localparam ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S1 = 425;
  localparam ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S2 = 426;
  localparam ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S3 = 427;
  localparam ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S4 = 428;
  localparam ov5640_initiator_i2c_worker_50_dk_L20_fortest21_S0 = 429;
  localparam ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S0 = 430;
  localparam ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S1 = 431;
  localparam ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S2 = 432;
  localparam ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S3 = 433;
  localparam ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S4 = 434;
  localparam ov5640_initiator_i2c_worker_50_dk_L21_fortest5_S0 = 435;
  localparam ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S0 = 436;
  localparam ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S1 = 437;
  localparam ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S2 = 438;
  localparam ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S3 = 439;
  localparam ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S4 = 440;
  localparam ov5640_initiator_i2c_worker_50_dk_L22_fortest9_S0 = 441;
  localparam ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S0 = 442;
  localparam ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S1 = 443;
  localparam ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S2 = 444;
  localparam ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S3 = 445;
  localparam ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S4 = 446;
  
  //signals: 
  wire        [7:0] i2c_cmd_q_dout;
  wire i2c_cmd_q_empty;
  wire i2c_cmd_q_full;
  wire i2c_cmd_q_will_empty;
  wire i2c_cmd_q_will_full;
  wire        [7:0] i2c_res_q_dout;
  wire i2c_res_q_empty;
  wire i2c_res_q_full;
  wire i2c_res_q_will_empty;
  wire i2c_res_q_will_full;
  wire initiator_i2c_worker_50_dk_b0_inl104;
  wire initiator_i2c_worker_50_dk_c1009;
  wire initiator_i2c_worker_50_dk_c1010;
  wire initiator_i2c_worker_50_dk_c1011;
  wire initiator_i2c_worker_50_dk_c1012;
  wire initiator_i2c_worker_50_dk_c1013;
  wire initiator_i2c_worker_50_dk_c1014;
  wire initiator_i2c_worker_50_dk_c1015;
  wire initiator_i2c_worker_50_dk_c2913;
  wire initiator_i2c_worker_50_dk_c2914;
  wire initiator_i2c_worker_50_dk_c2915;
  wire initiator_i2c_worker_50_dk_c2916;
  wire initiator_i2c_worker_50_dk_c2917;
  wire initiator_i2c_worker_50_dk_c2918;
  wire initiator_i2c_worker_50_dk_c2919;
  wire initiator_i2c_worker_50_dk_c2921;
  wire initiator_i2c_worker_50_dk_c2923;
  wire initiator_i2c_worker_50_dk_c2925;
  wire initiator_i2c_worker_50_dk_c2927;
  wire initiator_i2c_worker_50_dk_c2929;
  wire initiator_i2c_worker_50_dk_c2931;
  wire initiator_i2c_worker_50_dk_c2935;
  wire initiator_i2c_worker_50_dk_c2937;
  wire initiator_i2c_worker_50_dk_c2939;
  wire initiator_i2c_worker_50_dk_c2941;
  wire initiator_i2c_worker_50_dk_c2944;
  wire initiator_i2c_worker_50_dk_c2946;
  wire initiator_i2c_worker_50_dk_c2948;
  wire initiator_i2c_worker_50_dk_c2952;
  wire initiator_i2c_worker_50_dk_c3966;
  wire initiator_i2c_worker_50_dk_c3967;
  wire initiator_i2c_worker_50_dk_c3968;
  wire initiator_i2c_worker_50_dk_c3969;
  wire initiator_i2c_worker_50_dk_c3970;
  wire initiator_i2c_worker_50_dk_c3971;
  wire initiator_i2c_worker_50_dk_c3972;
  wire initiator_i2c_worker_50_dk_c3973;
  wire initiator_i2c_worker_50_dk_c3974;
  wire initiator_i2c_worker_50_dk_c3975;
  wire initiator_i2c_worker_50_dk_c3976;
  wire initiator_i2c_worker_50_dk_c3977;
  wire initiator_i2c_worker_50_dk_c3978;
  wire initiator_i2c_worker_50_dk_c3979;
  wire initiator_i2c_worker_50_dk_c3980;
  wire initiator_i2c_worker_50_dk_c3981;
  wire initiator_i2c_worker_50_dk_c3982;
  wire initiator_i2c_worker_50_dk_c3983;
  wire initiator_i2c_worker_50_dk_c3984;
  wire initiator_i2c_worker_50_dk_c3985;
  wire initiator_i2c_worker_50_dk_c5923;
  wire initiator_i2c_worker_50_dk_c5924;
  wire initiator_i2c_worker_50_dk_c5925;
  wire initiator_i2c_worker_50_dk_c5926;
  wire initiator_i2c_worker_50_dk_c5927;
  wire initiator_i2c_worker_50_dk_c5928;
  wire initiator_i2c_worker_50_dk_c5929;
  wire initiator_i2c_worker_50_dk_c5930;
  wire initiator_i2c_worker_50_dk_c5931;
  wire initiator_i2c_worker_50_dk_c5932;
  wire initiator_i2c_worker_50_dk_c5933;
  wire initiator_i2c_worker_50_dk_c5934;
  wire initiator_i2c_worker_50_dk_c5935;
  wire initiator_i2c_worker_50_dk_c5936;
  wire initiator_i2c_worker_50_dk_c5937;
  wire initiator_i2c_worker_50_dk_c5938;
  wire initiator_i2c_worker_50_dk_c5939;
  wire initiator_i2c_worker_50_dk_c5940;
  wire initiator_i2c_worker_50_dk_c5941;
  wire initiator_i2c_worker_50_dk_c5942;
  wire initiator_i2c_worker_50_dk_c5943;
  wire initiator_i2c_worker_50_dk_c873;
  wire initiator_i2c_worker_50_dk_c874;
  wire initiator_i2c_worker_50_dk_c875;
  wire initiator_i2c_worker_50_dk_c876;
  wire initiator_i2c_worker_50_dk_c877;
  wire initiator_i2c_worker_50_dk_c878;
  wire initiator_i2c_worker_50_dk_c879;
  wire initiator_i2c_worker_50_dk_c880;
  wire initiator_i2c_worker_50_dk_c881;
  wire initiator_i2c_worker_50_dk_c886_inl10;
  wire initiator_i2c_worker_50_dk_c896_inl10_inl9;
  wire initiator_i2c_worker_50_dk_c896_inl1_inl2_inl2;
  wire initiator_i2c_worker_50_dk_c896_inl1_inl2_inl3;
  wire initiator_i2c_worker_50_dk_c896_inl1_inl2_inl4;
  wire initiator_i2c_worker_50_dk_c896_inl1_inl2_inl8;
  wire initiator_i2c_worker_50_dk_c896_inl1_inl3_inl5;
  wire initiator_i2c_worker_50_dk_c896_inl1_inl3_inl9;
  wire initiator_i2c_worker_50_dk_c896_inl1_inl4_inl5;
  wire initiator_i2c_worker_50_dk_c896_inl1_inl4_inl9;
  wire initiator_i2c_worker_50_dk_c896_inl5_inl2;
  wire initiator_i2c_worker_50_dk_c896_inl6_inl4;
  wire initiator_i2c_worker_50_dk_c896_inl7_inl4;
  wire initiator_i2c_worker_50_dk_c896_inl7_inl8;
  wire initiator_i2c_worker_50_dk_c896_inl8_inl5;
  wire initiator_i2c_worker_50_dk_c896_inl8_inl8;
  wire initiator_i2c_worker_50_dk_c896_inl9_inl8;
  wire initiator_i2c_worker_50_dk_c896_inl9_inl9;
  wire initiator_i2c_worker_50_dk_c898_inl10_inl9;
  wire initiator_i2c_worker_50_dk_c898_inl1_inl2_inl2;
  wire initiator_i2c_worker_50_dk_c898_inl1_inl2_inl3;
  wire initiator_i2c_worker_50_dk_c898_inl1_inl2_inl4;
  wire initiator_i2c_worker_50_dk_c898_inl1_inl2_inl8;
  wire initiator_i2c_worker_50_dk_c898_inl1_inl3_inl5;
  wire initiator_i2c_worker_50_dk_c898_inl1_inl3_inl9;
  wire initiator_i2c_worker_50_dk_c898_inl1_inl4_inl5;
  wire initiator_i2c_worker_50_dk_c898_inl1_inl4_inl9;
  wire initiator_i2c_worker_50_dk_c898_inl5_inl2;
  wire initiator_i2c_worker_50_dk_c898_inl6_inl4;
  wire initiator_i2c_worker_50_dk_c898_inl7_inl4;
  wire initiator_i2c_worker_50_dk_c898_inl7_inl8;
  wire initiator_i2c_worker_50_dk_c898_inl8_inl5;
  wire initiator_i2c_worker_50_dk_c898_inl8_inl8;
  wire initiator_i2c_worker_50_dk_c898_inl9_inl8;
  wire initiator_i2c_worker_50_dk_c898_inl9_inl9;
  wire initiator_i2c_worker_50_dk_c903_inl10_inl5;
  wire initiator_i2c_worker_50_dk_c903_inl13_inl9;
  wire initiator_i2c_worker_50_dk_c903_inl4_inl3;
  wire        [15:0] initiator_i2c_worker_50_dk_data16_inl62;
  wire        [15:0] initiator_i2c_worker_50_dk_data16_inl63;
  wire        [15:0] initiator_i2c_worker_50_dk_data16_inl72;
  wire        [15:0] initiator_i2c_worker_50_dk_data16_inl73;
  wire initiator_i2c_worker_50_dk_has_data_flag6;
  wire        [15:0] initiator_i2c_worker_50_dk_high_addr16_inl8;
  wire        [15:0] initiator_i2c_worker_50_dk_high_addr16_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_high_addr8_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_high_addr8_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_low_addr8_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_low_addr8_inl9;
  wire initiator_i2c_worker_50_dk_msb_inl10_inl9;
  wire initiator_i2c_worker_50_dk_msb_inl1_inl2_inl2;
  wire initiator_i2c_worker_50_dk_msb_inl1_inl2_inl3;
  wire initiator_i2c_worker_50_dk_msb_inl1_inl2_inl4;
  wire initiator_i2c_worker_50_dk_msb_inl1_inl2_inl8;
  wire initiator_i2c_worker_50_dk_msb_inl1_inl3_inl5;
  wire initiator_i2c_worker_50_dk_msb_inl1_inl3_inl9;
  wire initiator_i2c_worker_50_dk_msb_inl1_inl4_inl5;
  wire initiator_i2c_worker_50_dk_msb_inl1_inl4_inl9;
  wire initiator_i2c_worker_50_dk_msb_inl5_inl2;
  wire initiator_i2c_worker_50_dk_msb_inl6_inl4;
  wire initiator_i2c_worker_50_dk_msb_inl7_inl4;
  wire initiator_i2c_worker_50_dk_msb_inl7_inl8;
  wire initiator_i2c_worker_50_dk_msb_inl8_inl5;
  wire initiator_i2c_worker_50_dk_msb_inl8_inl8;
  wire initiator_i2c_worker_50_dk_msb_inl9_inl8;
  wire initiator_i2c_worker_50_dk_msb_inl9_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_r_data6;
  wire        [7:0] initiator_i2c_worker_50_dk_r_data_inl10_inl54;
  wire        [7:0] initiator_i2c_worker_50_dk_r_data_inl10_inl55;
  wire        [7:0] initiator_i2c_worker_50_dk_r_data_inl13_inl94;
  wire        [7:0] initiator_i2c_worker_50_dk_r_data_inl13_inl95;
  wire        [7:0] initiator_i2c_worker_50_dk_r_data_inl4_inl34;
  wire        [7:0] initiator_i2c_worker_50_dk_r_data_inl4_inl35;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl10_inl94;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl24;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl34;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl44;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl84;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl54;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl94;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl54;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl94;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl5_inl24;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl6_inl44;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl7_inl44;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl7_inl84;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl8_inl54;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl8_inl84;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl9_inl84;
  wire        [7:0] initiator_i2c_worker_50_dk_raw_data_inl9_inl94;
  wire        [7:0] initiator_i2c_worker_50_dk_res2;
  wire        [7:0] initiator_i2c_worker_50_dk_res3;
  wire        [7:0] initiator_i2c_worker_50_dk_res4;
  wire        [31:0] initiator_i2c_worker_50_dk_t884;
  wire        [15:0] initiator_i2c_worker_50_dk_t887_inl6;
  wire        [15:0] initiator_i2c_worker_50_dk_t887_inl7;
  wire        [15:0] initiator_i2c_worker_50_dk_t888_inl9;
  wire        [15:0] initiator_i2c_worker_50_dk_t890_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_t894_inl2_inl2;
  wire        [7:0] initiator_i2c_worker_50_dk_t894_inl2_inl3;
  wire        [7:0] initiator_i2c_worker_50_dk_t894_inl2_inl4;
  wire        [7:0] initiator_i2c_worker_50_dk_t894_inl2_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_t894_inl3_inl5;
  wire        [7:0] initiator_i2c_worker_50_dk_t894_inl3_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_t894_inl4_inl5;
  wire        [7:0] initiator_i2c_worker_50_dk_t894_inl4_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_t895_inl2_inl2;
  wire        [7:0] initiator_i2c_worker_50_dk_t895_inl2_inl3;
  wire        [7:0] initiator_i2c_worker_50_dk_t895_inl2_inl4;
  wire        [7:0] initiator_i2c_worker_50_dk_t895_inl2_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_t895_inl3_inl5;
  wire        [7:0] initiator_i2c_worker_50_dk_t895_inl3_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_t895_inl4_inl5;
  wire        [7:0] initiator_i2c_worker_50_dk_t895_inl4_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl10_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl1_inl2_inl2;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl1_inl2_inl3;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl1_inl2_inl4;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl1_inl2_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl1_inl3_inl5;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl1_inl3_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl1_inl4_inl5;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl1_inl4_inl9;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl5_inl2;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl6_inl4;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl7_inl4;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl7_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl8_inl5;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl8_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl9_inl8;
  wire        [7:0] initiator_i2c_worker_50_dk_t897_inl9_inl9;
  wire initiator_worker_dj_c2957;
  wire initiator_worker_dj_c5944;
  wire initiator_worker_dj_c910;
  wire initiator_worker_dj_c917_inl6;
  wire        [7:0] initiator_worker_dj_debug_i4;
  wire        [15:0] initiator_worker_dj_reg_addr;
  wire        [7:0] initiator_worker_dj_send_data;
  wire        [15:0] initiator_worker_dj_t912_inl6;
  wire        [15:0] initiator_worker_dj_t913_inl6;
  wire        [15:0] initiator_worker_dj_t914_inl6;
  wire        [7:0] initiator_worker_dj_t916_inl6;
  reg        [7:0] i2c_cmd_q_din;
  reg i2c_cmd_q_read;
  reg i2c_cmd_q_write;
  reg        [7:0] i2c_res_q_din;
  reg i2c_res_q_read;
  reg i2c_res_q_write;
  reg initiator_i2c_worker_50_dk_ack_check_inl3_inl2;
  reg initiator_i2c_worker_50_dk_ack_check_inl3_inl3;
  reg initiator_i2c_worker_50_dk_ack_check_inl3_inl4;
  reg initiator_i2c_worker_50_dk_ack_check_inl3_inl8;
  reg initiator_i2c_worker_50_dk_ack_check_inl4_inl2;
  reg initiator_i2c_worker_50_dk_ack_check_inl4_inl4;
  reg initiator_i2c_worker_50_dk_ack_check_inl4_inl8;
  reg initiator_i2c_worker_50_dk_ack_check_inl5_inl4;
  reg initiator_i2c_worker_50_dk_ack_check_inl5_inl5;
  reg initiator_i2c_worker_50_dk_ack_check_inl5_inl8;
  reg initiator_i2c_worker_50_dk_ack_check_inl5_inl9;
  reg initiator_i2c_worker_50_dk_ack_check_inl6_inl5;
  reg initiator_i2c_worker_50_dk_ack_check_inl6_inl8;
  reg initiator_i2c_worker_50_dk_ack_check_inl6_inl9;
  reg initiator_i2c_worker_50_dk_ack_check_inl7_inl5;
  reg initiator_i2c_worker_50_dk_ack_check_inl7_inl9;
  reg initiator_i2c_worker_50_dk_ack_check_inl8_inl9;
  reg initiator_i2c_worker_50_dk_b0_inl103;
  reg        [7:0] initiator_i2c_worker_50_dk_cmd;
  reg initiator_i2c_worker_50_dk_msb_inl10_inl5;
  reg initiator_i2c_worker_50_dk_msb_inl13_inl9;
  reg initiator_i2c_worker_50_dk_msb_inl4_inl3;
  reg        [7:0] initiator_i2c_worker_50_dk_n_1;
  reg        [7:0] initiator_i2c_worker_50_dk_r_addr2;
  reg        [7:0] initiator_i2c_worker_50_dk_r_addr3;
  reg        [7:0] initiator_i2c_worker_50_dk_r_addr4;
  reg        [7:0] initiator_i2c_worker_50_dk_r_data_inl10_inl53;
  reg        [7:0] initiator_i2c_worker_50_dk_r_data_inl13_inl93;
  reg        [7:0] initiator_i2c_worker_50_dk_r_data_inl4_inl33;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl10_inl93;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl23;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl33;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl43;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl83;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl53;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl93;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl53;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl93;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl5_inl23;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl6_inl43;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl7_inl43;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl7_inl83;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl8_inl53;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl8_inl83;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl9_inl83;
  reg        [7:0] initiator_i2c_worker_50_dk_raw_data_inl9_inl93;
  reg        [7:0] initiator_i2c_worker_50_dk_reg_addr83;
  reg        [7:0] initiator_i2c_worker_50_dk_reg_addr84;
  reg        [7:0] initiator_i2c_worker_50_dk_reg_addr_high3;
  reg        [7:0] initiator_i2c_worker_50_dk_reg_addr_high4;
  reg        [7:0] initiator_i2c_worker_50_dk_reg_addr_low3;
  reg        [7:0] initiator_i2c_worker_50_dk_reg_addr_low4;
  reg        [7:0] initiator_i2c_worker_50_dk_slave_addr83;
  reg        [8:0] initiator_i2c_worker_50_dk_state;
  reg        [7:0] initiator_i2c_worker_50_dk_w_addr2;
  reg        [7:0] initiator_i2c_worker_50_dk_w_addr3;
  reg        [7:0] initiator_i2c_worker_50_dk_w_addr4;
  reg        [7:0] initiator_i2c_worker_50_dk_w_addr5;
  reg        [7:0] initiator_i2c_worker_50_dk_w_data2;
  reg        [7:0] initiator_i2c_worker_50_dk_w_data3;
  reg        [7:0] initiator_i2c_worker_50_dk_w_data4;
  reg        [7:0] initiator_i2c_worker_50_dk_w_data5;
  reg        [7:0] initiator_worker_dj_debug_i3;
  reg        [5:0] initiator_worker_dj_state;
  reg        [7:0] initiator_worker_dj_v_inl6;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl104;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl10_inl54;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl10_inl94;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl13_inl94;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl2_inl24;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl2_inl34;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl2_inl44;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl2_inl84;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl3_inl54;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl3_inl94;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl4_inl54;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl4_inl94;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl4_inl34;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl5_inl24;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl6_inl44;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl7_inl44;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl7_inl84;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl8_inl54;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl8_inl84;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl9_inl84;
  wire signed [31:0] initiator_i2c_worker_50_dk_i_inl9_inl94;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3986;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3987;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3988;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3989;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3990;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3991;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3992;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3993;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3994;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3995;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3996;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3997;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3998;
  wire signed [31:0] initiator_i2c_worker_50_dk_t3999;
  wire signed [31:0] initiator_i2c_worker_50_dk_t4000;
  wire signed [31:0] initiator_i2c_worker_50_dk_t4001;
  wire signed [31:0] initiator_i2c_worker_50_dk_t4002;
  wire signed [31:0] initiator_worker_dj_counter8624;
  wire signed [31:0] initiator_worker_dj_data_i;
  wire signed [31:0] initiator_worker_dj_t911;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl103;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl10_inl53;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl10_inl93;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl13_inl93;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl2_inl23;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl2_inl33;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl2_inl43;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl2_inl83;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl3_inl53;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl3_inl93;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl4_inl53;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl1_inl4_inl93;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl4_inl33;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl5_inl23;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl6_inl43;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl7_inl43;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl7_inl83;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl8_inl53;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl8_inl83;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl9_inl83;
  reg signed [31:0] initiator_i2c_worker_50_dk_i_inl9_inl93;
  reg signed [31:0] initiator_worker_dj_counter8623;
  //combinations: 
  function [31:0] ov5640_data (
    input [8:0] ov5640_data_in
  );
  begin
    case (ov5640_data_in)
      0: begin
        ov5640_data = 3212049;
      end
      1: begin
        ov5640_data = 3147906;
      end
      2: begin
        ov5640_data = 3147842;
      end
      3: begin
        ov5640_data = 3212035;
      end
      4: begin
        ov5640_data = 3151871;
      end
      5: begin
        ov5640_data = 3152127;
      end
      6: begin
        ov5640_data = 3159066;
      end
      7: begin
        ov5640_data = 3159827;
      end
      8: begin
        ov5640_data = 3213313;
      end
      9: begin
        ov5640_data = 3551286;
      end
      10: begin
        ov5640_data = 3551502;
      end
      11: begin
        ov5640_data = 3551970;
      end
      12: begin
        ov5640_data = 3552018;
      end
      13: begin
        ov5640_data = 3547616;
      end
      14: begin
        ov5640_data = 3605664;
      end
      15: begin
        ov5640_data = 3605338;
      end
      16: begin
        ov5640_data = 3609976;
      end
      17: begin
        ov5640_data = 3610369;
      end
      18: begin
        ov5640_data = 3607392;
      end
      19: begin
        ov5640_data = 3605786;
      end
      20: begin
        ov5640_data = 3736834;
      end
      21: begin
        ov5640_data = 3737104;
      end
      22: begin
        ov5640_data = 3735818;
      end
      23: begin
        ov5640_data = 3617042;
      end
      24: begin
        ov5640_data = 3538952;
      end
      25: begin
        ov5640_data = 3539251;
      end
      26: begin
        ov5640_data = 3157344;
      end
      27: begin
        ov5640_data = 3547218;
      end
      28: begin
        ov5640_data = 3611424;
      end
      29: begin
        ov5640_data = 4660304;
      end
      30: begin
        ov5640_data = 3806019;
      end
      31: begin
        ov5640_data = 3807232;
      end
      32: begin
        ov5640_data = 3807736;
      end
      33: begin
        ov5640_data = 3552531;
      end
      34: begin
        ov5640_data = 3552771;
      end
      35: begin
        ov5640_data = 3552320;
      end
      36: begin
        ov5640_data = 3547649;
      end
      37: begin
        ov5640_data = 3932468;
      end
      38: begin
        ov5640_data = 3933224;
      end
      39: begin
        ov5640_data = 3933592;
      end
      40: begin
        ov5640_data = 3933696;
      end
      41: begin
        ov5640_data = 3933960;
      end
      42: begin
        ov5640_data = 3934208;
      end
      43: begin
        ov5640_data = 3934492;
      end
      44: begin
        ov5640_data = 3934876;
      end
      45: begin
        ov5640_data = 3935040;
      end
      46: begin
        ov5640_data = 3674112;
      end
      47: begin
        ov5640_data = 3674384;
      end
      48: begin
        ov5640_data = 3674624;
      end
      49: begin
        ov5640_data = 3606628;
      end
      50: begin
        ov5640_data = 4194562;
      end
      51: begin
        ov5640_data = 4195610;
      end
      52: begin
        ov5640_data = 3145728;
      end
      53: begin
        ov5640_data = 3147007;
      end
      54: begin
        ov5640_data = 3149400;
      end
      55: begin
        ov5640_data = 3157504;
      end
      56: begin
        ov5640_data = 4391008;
      end
      57: begin
        ov5640_data = 5250817;
      end
      58: begin
        ov5640_data = 4460032;
      end
      59: begin
        ov5640_data = 5243047;
      end
      60: begin
        ov5640_data = 3804976;
      end
      61: begin
        ov5640_data = 3805224;
      end
      62: begin
        ov5640_data = 3808048;
      end
      63: begin
        ov5640_data = 3808806;
      end
      64: begin
        ov5640_data = 3805536;
      end
      65: begin
        ov5640_data = 3809044;
      end
      66: begin
        ov5640_data = 5767203;
      end
      67: begin
        ov5640_data = 5767444;
      end
      68: begin
        ov5640_data = 5767695;
      end
      69: begin
        ov5640_data = 5767951;
      end
      70: begin
        ov5640_data = 5768210;
      end
      71: begin
        ov5640_data = 5768486;
      end
      72: begin
        ov5640_data = 5768716;
      end
      73: begin
        ov5640_data = 5768968;
      end
      74: begin
        ov5640_data = 5769221;
      end
      75: begin
        ov5640_data = 5769477;
      end
      76: begin
        ov5640_data = 5769736;
      end
      77: begin
        ov5640_data = 5769997;
      end
      78: begin
        ov5640_data = 5770248;
      end
      79: begin
        ov5640_data = 5770499;
      end
      80: begin
        ov5640_data = 5770752;
      end
      81: begin
        ov5640_data = 5771008;
      end
      82: begin
        ov5640_data = 5771267;
      end
      83: begin
        ov5640_data = 5771529;
      end
      84: begin
        ov5640_data = 5771783;
      end
      85: begin
        ov5640_data = 5772035;
      end
      86: begin
        ov5640_data = 5772288;
      end
      87: begin
        ov5640_data = 5772545;
      end
      88: begin
        ov5640_data = 5772803;
      end
      89: begin
        ov5640_data = 5773064;
      end
      90: begin
        ov5640_data = 5773325;
      end
      91: begin
        ov5640_data = 5773576;
      end
      92: begin
        ov5640_data = 5773829;
      end
      93: begin
        ov5640_data = 5774086;
      end
      94: begin
        ov5640_data = 5774344;
      end
      95: begin
        ov5640_data = 5774606;
      end
      96: begin
        ov5640_data = 5774889;
      end
      97: begin
        ov5640_data = 5775127;
      end
      98: begin
        ov5640_data = 5775377;
      end
      99: begin
        ov5640_data = 5775633;
      end
      100: begin
        ov5640_data = 5775893;
      end
      101: begin
        ov5640_data = 5776168;
      end
      102: begin
        ov5640_data = 5776454;
      end
      103: begin
        ov5640_data = 5776678;
      end
      104: begin
        ov5640_data = 5776904;
      end
      105: begin
        ov5640_data = 5777190;
      end
      106: begin
        ov5640_data = 5777508;
      end
      107: begin
        ov5640_data = 5777702;
      end
      108: begin
        ov5640_data = 5777956;
      end
      109: begin
        ov5640_data = 5778210;
      end
      110: begin
        ov5640_data = 5778468;
      end
      111: begin
        ov5640_data = 5778724;
      end
      112: begin
        ov5640_data = 5778950;
      end
      113: begin
        ov5640_data = 5779234;
      end
      114: begin
        ov5640_data = 5779520;
      end
      115: begin
        ov5640_data = 5779778;
      end
      116: begin
        ov5640_data = 5780004;
      end
      117: begin
        ov5640_data = 5780262;
      end
      118: begin
        ov5640_data = 5780516;
      end
      119: begin
        ov5640_data = 5780770;
      end
      120: begin
        ov5640_data = 5781026;
      end
      121: begin
        ov5640_data = 5781286;
      end
      122: begin
        ov5640_data = 5781572;
      end
      123: begin
        ov5640_data = 5781796;
      end
      124: begin
        ov5640_data = 5782054;
      end
      125: begin
        ov5640_data = 5782312;
      end
      126: begin
        ov5640_data = 5782594;
      end
      127: begin
        ov5640_data = 5782990;
      end
      128: begin
        ov5640_data = 5341439;
      end
      129: begin
        ov5640_data = 5341682;
      end
      130: begin
        ov5640_data = 5341696;
      end
      131: begin
        ov5640_data = 5341972;
      end
      132: begin
        ov5640_data = 5342245;
      end
      133: begin
        ov5640_data = 5342500;
      end
      134: begin
        ov5640_data = 5342729;
      end
      135: begin
        ov5640_data = 5342985;
      end
      136: begin
        ov5640_data = 5343241;
      end
      137: begin
        ov5640_data = 5343605;
      end
      138: begin
        ov5640_data = 5343828;
      end
      139: begin
        ov5640_data = 5344224;
      end
      140: begin
        ov5640_data = 5344434;
      end
      141: begin
        ov5640_data = 5344578;
      end
      142: begin
        ov5640_data = 5344829;
      end
      143: begin
        ov5640_data = 5345110;
      end
      144: begin
        ov5640_data = 5345350;
      end
      145: begin
        ov5640_data = 5345784;
      end
      146: begin
        ov5640_data = 5345796;
      end
      147: begin
        ov5640_data = 5346160;
      end
      148: begin
        ov5640_data = 5346544;
      end
      149: begin
        ov5640_data = 5346800;
      end
      150: begin
        ov5640_data = 5346819;
      end
      151: begin
        ov5640_data = 5347073;
      end
      152: begin
        ov5640_data = 5347332;
      end
      153: begin
        ov5640_data = 5347602;
      end
      154: begin
        ov5640_data = 5347844;
      end
      155: begin
        ov5640_data = 5348096;
      end
      156: begin
        ov5640_data = 5348358;
      end
      157: begin
        ov5640_data = 5348738;
      end
      158: begin
        ov5640_data = 5348920;
      end
      159: begin
        ov5640_data = 5537793;
      end
      160: begin
        ov5640_data = 5538056;
      end
      161: begin
        ov5640_data = 5538324;
      end
      162: begin
        ov5640_data = 5538600;
      end
      163: begin
        ov5640_data = 5538897;
      end
      164: begin
        ov5640_data = 5539173;
      end
      165: begin
        ov5640_data = 5539441;
      end
      166: begin
        ov5640_data = 5539709;
      end
      167: begin
        ov5640_data = 5539975;
      end
      168: begin
        ov5640_data = 5540241;
      end
      169: begin
        ov5640_data = 5540506;
      end
      170: begin
        ov5640_data = 5540778;
      end
      171: begin
        ov5640_data = 5541048;
      end
      172: begin
        ov5640_data = 5541325;
      end
      173: begin
        ov5640_data = 5541597;
      end
      174: begin
        ov5640_data = 5541866;
      end
      175: begin
        ov5640_data = 5541917;
      end
      176: begin
        ov5640_data = 5472542;
      end
      177: begin
        ov5640_data = 5472859;
      end
      178: begin
        ov5640_data = 5473032;
      end
      179: begin
        ov5640_data = 5473290;
      end
      180: begin
        ov5640_data = 5473662;
      end
      181: begin
        ov5640_data = 5473928;
      end
      182: begin
        ov5640_data = 5474172;
      end
      183: begin
        ov5640_data = 5474412;
      end
      184: begin
        ov5640_data = 5474576;
      end
      185: begin
        ov5640_data = 5474817;
      end
      186: begin
        ov5640_data = 5475224;
      end
      187: begin
        ov5640_data = 5603334;
      end
      188: begin
        ov5640_data = 5604160;
      end
      189: begin
        ov5640_data = 5604368;
      end
      190: begin
        ov5640_data = 5605648;
      end
      191: begin
        ov5640_data = 5605888;
      end
      192: begin
        ov5640_data = 5606392;
      end
      193: begin
        ov5640_data = 5250368;
      end
      194: begin
        ov5640_data = 5439496;
      end
      195: begin
        ov5640_data = 5439792;
      end
      196: begin
        ov5640_data = 5440016;
      end
      197: begin
        ov5640_data = 5440256;
      end
      198: begin
        ov5640_data = 5440520;
      end
      199: begin
        ov5640_data = 5440816;
      end
      200: begin
        ov5640_data = 5441032;
      end
      201: begin
        ov5640_data = 5441302;
      end
      202: begin
        ov5640_data = 5441800;
      end
      203: begin
        ov5640_data = 5442096;
      end
      204: begin
        ov5640_data = 5442308;
      end
      205: begin
        ov5640_data = 5442566;
      end
      206: begin
        ov5640_data = 5252352;
      end
      207: begin
        ov5640_data = 3147778;
      end
      208: begin
        ov5640_data = 3159313;
      end
      209: begin
        ov5640_data = 3159622;
      end
      210: begin
        ov5640_data = 3933960;
      end
      211: begin
        ov5640_data = 3678279;
      end
      212: begin
        ov5640_data = 3678465;
      end
      213: begin
        ov5640_data = 3675185;
      end
      214: begin
        ov5640_data = 3675441;
      end
      215: begin
        ov5640_data = 3670016;
      end
      216: begin
        ov5640_data = 3670272;
      end
      217: begin
        ov5640_data = 3670528;
      end
      218: begin
        ov5640_data = 3670788;
      end
      219: begin
        ov5640_data = 3671050;
      end
      220: begin
        ov5640_data = 3671359;
      end
      221: begin
        ov5640_data = 3671559;
      end
      222: begin
        ov5640_data = 3671963;
      end
      223: begin
        ov5640_data = 3672065;
      end
      224: begin
        ov5640_data = 3672544;
      end
      225: begin
        ov5640_data = 3672577;
      end
      226: begin
        ov5640_data = 3672848;
      end
      227: begin
        ov5640_data = 3673095;
      end
      228: begin
        ov5640_data = 3673448;
      end
      229: begin
        ov5640_data = 3673603;
      end
      230: begin
        ov5640_data = 3674072;
      end
      231: begin
        ov5640_data = 3674886;
      end
      232: begin
        ov5640_data = 3545088;
      end
      233: begin
        ov5640_data = 3543593;
      end
      234: begin
        ov5640_data = 3606866;
      end
      235: begin
        ov5640_data = 3607555;
      end
      236: begin
        ov5640_data = 3801623;
      end
      237: begin
        ov5640_data = 3801872;
      end
      238: begin
        ov5640_data = 3806231;
      end
      239: begin
        ov5640_data = 3806480;
      end
      240: begin
        ov5640_data = 4195330;
      end
      241: begin
        ov5640_data = 3146268;
      end
      242: begin
        ov5640_data = 3147459;
      end
      243: begin
        ov5640_data = 4657923;
      end
      244: begin
        ov5640_data = 4458244;
      end
      245: begin
        ov5640_data = 4590389;
      end
      246: begin
        ov5640_data = 4590626;
      end
      247: begin
        ov5640_data = 4732706;
      end
      248: begin
        ov5640_data = 3679234;
      end
      249: begin
        ov5640_data = 5243299;
      end
      250: begin
        ov5640_data = 3474176;
      end
      251: begin
        ov5640_data = 3151362;
      end
      252: begin
        ov5640_data = 3868426;
      end
      253: begin
        ov5640_data = 3866755;
      end
      254: begin
        ov5640_data = 3866624;
      end
      255: begin
        ov5640_data = 16777215;
      end
    endcase
  end
  endfunction
  assign initiator_i2c_worker_50_dk_b0_inl104 = ~initiator_i2c_worker_50_dk_b0_inl103;
  assign initiator_i2c_worker_50_dk_c1009 = (!initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c874);
  assign initiator_i2c_worker_50_dk_c1010 = (initiator_i2c_worker_50_dk_c3966 && initiator_i2c_worker_50_dk_c875);
  assign initiator_i2c_worker_50_dk_c1011 = (initiator_i2c_worker_50_dk_c3968 && initiator_i2c_worker_50_dk_c876);
  assign initiator_i2c_worker_50_dk_c1012 = (initiator_i2c_worker_50_dk_c3971 && initiator_i2c_worker_50_dk_c877);
  assign initiator_i2c_worker_50_dk_c1013 = (initiator_i2c_worker_50_dk_c3975 && initiator_i2c_worker_50_dk_c878);
  assign initiator_i2c_worker_50_dk_c1014 = (initiator_i2c_worker_50_dk_c3980 && initiator_i2c_worker_50_dk_c879);
  assign initiator_i2c_worker_50_dk_c1015 = (initiator_i2c_worker_50_dk_c3985 && !initiator_i2c_worker_50_dk_c879);
  assign initiator_i2c_worker_50_dk_c2913 = (initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl2);
  assign initiator_i2c_worker_50_dk_c2914 = (initiator_i2c_worker_50_dk_c1009 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl3);
  assign initiator_i2c_worker_50_dk_c2915 = (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl4);
  assign initiator_i2c_worker_50_dk_c2916 = (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl1_inl3_inl5);
  assign initiator_i2c_worker_50_dk_c2917 = (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl8);
  assign initiator_i2c_worker_50_dk_c2918 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl1_inl3_inl9);
  assign initiator_i2c_worker_50_dk_c2919 = (initiator_i2c_worker_50_dk_c1014 && initiator_i2c_worker_50_dk_c886_inl10);
  assign initiator_i2c_worker_50_dk_c2921 = (initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c896_inl5_inl2);
  assign initiator_i2c_worker_50_dk_c2923 = (initiator_i2c_worker_50_dk_c1009 && initiator_i2c_worker_50_dk_c903_inl4_inl3);
  assign initiator_i2c_worker_50_dk_c2925 = (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl6_inl4);
  assign initiator_i2c_worker_50_dk_c2927 = (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl8_inl5);
  assign initiator_i2c_worker_50_dk_c2929 = (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl7_inl8);
  assign initiator_i2c_worker_50_dk_c2931 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl9_inl9);
  assign initiator_i2c_worker_50_dk_c2935 = (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl7_inl4);
  assign initiator_i2c_worker_50_dk_c2937 = (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl1_inl4_inl5);
  assign initiator_i2c_worker_50_dk_c2939 = (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl8_inl8);
  assign initiator_i2c_worker_50_dk_c2941 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl10_inl9);
  assign initiator_i2c_worker_50_dk_c2944 = (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c903_inl10_inl5);
  assign initiator_i2c_worker_50_dk_c2946 = (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl9_inl8);
  assign initiator_i2c_worker_50_dk_c2948 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl1_inl4_inl9);
  assign initiator_i2c_worker_50_dk_c2952 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c903_inl13_inl9);
  assign initiator_i2c_worker_50_dk_c3966 = (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874);
  assign initiator_i2c_worker_50_dk_c3967 = (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874);
  assign initiator_i2c_worker_50_dk_c3968 = (initiator_i2c_worker_50_dk_c3967 && !initiator_i2c_worker_50_dk_c875);
  assign initiator_i2c_worker_50_dk_c3969 = (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874);
  assign initiator_i2c_worker_50_dk_c3970 = (initiator_i2c_worker_50_dk_c3969 && !initiator_i2c_worker_50_dk_c875);
  assign initiator_i2c_worker_50_dk_c3971 = (initiator_i2c_worker_50_dk_c3970 && !initiator_i2c_worker_50_dk_c876);
  assign initiator_i2c_worker_50_dk_c3972 = (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874);
  assign initiator_i2c_worker_50_dk_c3973 = (initiator_i2c_worker_50_dk_c3972 && !initiator_i2c_worker_50_dk_c875);
  assign initiator_i2c_worker_50_dk_c3974 = (initiator_i2c_worker_50_dk_c3973 && !initiator_i2c_worker_50_dk_c876);
  assign initiator_i2c_worker_50_dk_c3975 = (initiator_i2c_worker_50_dk_c3974 && !initiator_i2c_worker_50_dk_c877);
  assign initiator_i2c_worker_50_dk_c3976 = (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874);
  assign initiator_i2c_worker_50_dk_c3977 = (initiator_i2c_worker_50_dk_c3976 && !initiator_i2c_worker_50_dk_c875);
  assign initiator_i2c_worker_50_dk_c3978 = (initiator_i2c_worker_50_dk_c3977 && !initiator_i2c_worker_50_dk_c876);
  assign initiator_i2c_worker_50_dk_c3979 = (initiator_i2c_worker_50_dk_c3978 && !initiator_i2c_worker_50_dk_c877);
  assign initiator_i2c_worker_50_dk_c3980 = (initiator_i2c_worker_50_dk_c3979 && !initiator_i2c_worker_50_dk_c878);
  assign initiator_i2c_worker_50_dk_c3981 = (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874);
  assign initiator_i2c_worker_50_dk_c3982 = (initiator_i2c_worker_50_dk_c3981 && !initiator_i2c_worker_50_dk_c875);
  assign initiator_i2c_worker_50_dk_c3983 = (initiator_i2c_worker_50_dk_c3982 && !initiator_i2c_worker_50_dk_c876);
  assign initiator_i2c_worker_50_dk_c3984 = (initiator_i2c_worker_50_dk_c3983 && !initiator_i2c_worker_50_dk_c877);
  assign initiator_i2c_worker_50_dk_c3985 = (initiator_i2c_worker_50_dk_c3984 && !initiator_i2c_worker_50_dk_c878);
  assign initiator_i2c_worker_50_dk_c5923 = (initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl2);
  assign initiator_i2c_worker_50_dk_c5924 = (initiator_i2c_worker_50_dk_c1009 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl3);
  assign initiator_i2c_worker_50_dk_c5925 = (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl4);
  assign initiator_i2c_worker_50_dk_c5926 = (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl1_inl3_inl5);
  assign initiator_i2c_worker_50_dk_c5927 = (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl8);
  assign initiator_i2c_worker_50_dk_c5928 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl1_inl3_inl9);
  assign initiator_i2c_worker_50_dk_c5929 = (initiator_i2c_worker_50_dk_c1014 && initiator_i2c_worker_50_dk_c886_inl10);
  assign initiator_i2c_worker_50_dk_c5930 = (initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c896_inl5_inl2);
  assign initiator_i2c_worker_50_dk_c5931 = (initiator_i2c_worker_50_dk_c1009 && initiator_i2c_worker_50_dk_c903_inl4_inl3);
  assign initiator_i2c_worker_50_dk_c5932 = (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl6_inl4);
  assign initiator_i2c_worker_50_dk_c5933 = (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl8_inl5);
  assign initiator_i2c_worker_50_dk_c5934 = (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl7_inl8);
  assign initiator_i2c_worker_50_dk_c5935 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl9_inl9);
  assign initiator_i2c_worker_50_dk_c5936 = (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl7_inl4);
  assign initiator_i2c_worker_50_dk_c5937 = (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl1_inl4_inl5);
  assign initiator_i2c_worker_50_dk_c5938 = (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl8_inl8);
  assign initiator_i2c_worker_50_dk_c5939 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl10_inl9);
  assign initiator_i2c_worker_50_dk_c5940 = (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c903_inl10_inl5);
  assign initiator_i2c_worker_50_dk_c5941 = (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl9_inl8);
  assign initiator_i2c_worker_50_dk_c5942 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl1_inl4_inl9);
  assign initiator_i2c_worker_50_dk_c5943 = (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c903_inl13_inl9);
  assign initiator_i2c_worker_50_dk_c873 = (initiator_i2c_worker_50_dk_cmd == 1);
  assign initiator_i2c_worker_50_dk_c874 = (initiator_i2c_worker_50_dk_cmd == 2);
  assign initiator_i2c_worker_50_dk_c875 = (initiator_i2c_worker_50_dk_cmd == 5);
  assign initiator_i2c_worker_50_dk_c876 = (initiator_i2c_worker_50_dk_cmd == 6);
  assign initiator_i2c_worker_50_dk_c877 = (initiator_i2c_worker_50_dk_cmd == 3);
  assign initiator_i2c_worker_50_dk_c878 = (initiator_i2c_worker_50_dk_cmd == 4);
  assign initiator_i2c_worker_50_dk_c879 = (initiator_i2c_worker_50_dk_cmd == 7);
  assign initiator_i2c_worker_50_dk_c880 = (initiator_i2c_worker_50_dk_has_data_flag6 != 0);
  assign initiator_i2c_worker_50_dk_c881 = (initiator_i2c_worker_50_dk_has_data_flag6 != 0);
  assign initiator_i2c_worker_50_dk_c886_inl10 = (initiator_i2c_worker_50_dk_i_inl103 < initiator_i2c_worker_50_dk_t884);
  assign initiator_i2c_worker_50_dk_c896_inl10_inl9 = (initiator_i2c_worker_50_dk_i_inl10_inl93 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl1_inl2_inl2 = (initiator_i2c_worker_50_dk_i_inl1_inl2_inl23 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl1_inl2_inl3 = (initiator_i2c_worker_50_dk_i_inl1_inl2_inl33 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl1_inl2_inl4 = (initiator_i2c_worker_50_dk_i_inl1_inl2_inl43 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl1_inl2_inl8 = (initiator_i2c_worker_50_dk_i_inl1_inl2_inl83 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl1_inl3_inl5 = (initiator_i2c_worker_50_dk_i_inl1_inl3_inl53 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl1_inl3_inl9 = (initiator_i2c_worker_50_dk_i_inl1_inl3_inl93 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl1_inl4_inl5 = (initiator_i2c_worker_50_dk_i_inl1_inl4_inl53 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl1_inl4_inl9 = (initiator_i2c_worker_50_dk_i_inl1_inl4_inl93 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl5_inl2 = (initiator_i2c_worker_50_dk_i_inl5_inl23 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl6_inl4 = (initiator_i2c_worker_50_dk_i_inl6_inl43 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl7_inl4 = (initiator_i2c_worker_50_dk_i_inl7_inl43 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl7_inl8 = (initiator_i2c_worker_50_dk_i_inl7_inl83 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl8_inl5 = (initiator_i2c_worker_50_dk_i_inl8_inl53 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl8_inl8 = (initiator_i2c_worker_50_dk_i_inl8_inl83 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl9_inl8 = (initiator_i2c_worker_50_dk_i_inl9_inl83 < 8);
  assign initiator_i2c_worker_50_dk_c896_inl9_inl9 = (initiator_i2c_worker_50_dk_i_inl9_inl93 < 8);
  assign initiator_i2c_worker_50_dk_c898_inl10_inl9 = (initiator_i2c_worker_50_dk_t897_inl10_inl9 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl1_inl2_inl2 = (initiator_i2c_worker_50_dk_t897_inl1_inl2_inl2 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl1_inl2_inl3 = (initiator_i2c_worker_50_dk_t897_inl1_inl2_inl3 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl1_inl2_inl4 = (initiator_i2c_worker_50_dk_t897_inl1_inl2_inl4 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl1_inl2_inl8 = (initiator_i2c_worker_50_dk_t897_inl1_inl2_inl8 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl1_inl3_inl5 = (initiator_i2c_worker_50_dk_t897_inl1_inl3_inl5 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl1_inl3_inl9 = (initiator_i2c_worker_50_dk_t897_inl1_inl3_inl9 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl1_inl4_inl5 = (initiator_i2c_worker_50_dk_t897_inl1_inl4_inl5 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl1_inl4_inl9 = (initiator_i2c_worker_50_dk_t897_inl1_inl4_inl9 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl5_inl2 = (initiator_i2c_worker_50_dk_t897_inl5_inl2 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl6_inl4 = (initiator_i2c_worker_50_dk_t897_inl6_inl4 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl7_inl4 = (initiator_i2c_worker_50_dk_t897_inl7_inl4 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl7_inl8 = (initiator_i2c_worker_50_dk_t897_inl7_inl8 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl8_inl5 = (initiator_i2c_worker_50_dk_t897_inl8_inl5 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl8_inl8 = (initiator_i2c_worker_50_dk_t897_inl8_inl8 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl9_inl8 = (initiator_i2c_worker_50_dk_t897_inl9_inl8 == 128);
  assign initiator_i2c_worker_50_dk_c898_inl9_inl9 = (initiator_i2c_worker_50_dk_t897_inl9_inl9 == 128);
  assign initiator_i2c_worker_50_dk_c903_inl10_inl5 = (initiator_i2c_worker_50_dk_i_inl10_inl53 < 8);
  assign initiator_i2c_worker_50_dk_c903_inl13_inl9 = (initiator_i2c_worker_50_dk_i_inl13_inl93 < 8);
  assign initiator_i2c_worker_50_dk_c903_inl4_inl3 = (initiator_i2c_worker_50_dk_i_inl4_inl33 < 8);
  assign initiator_i2c_worker_50_dk_data16_inl62 = initiator_i2c_worker_50_dk_reg_addr_high3;
  assign initiator_i2c_worker_50_dk_data16_inl63 = (initiator_i2c_worker_50_dk_t887_inl6 | initiator_i2c_worker_50_dk_reg_addr_low3);
  assign initiator_i2c_worker_50_dk_data16_inl72 = initiator_i2c_worker_50_dk_reg_addr_high4;
  assign initiator_i2c_worker_50_dk_data16_inl73 = (initiator_i2c_worker_50_dk_t887_inl7 | initiator_i2c_worker_50_dk_reg_addr_low4);
  assign initiator_i2c_worker_50_dk_has_data_flag6 = initiator_i2c_worker_50_dk_c873 ? 0 : initiator_i2c_worker_50_dk_c1009 ? 1 : initiator_i2c_worker_50_dk_c1010 ? 0 : initiator_i2c_worker_50_dk_c1011 ? 1 : initiator_i2c_worker_50_dk_c1012 ? 0 : initiator_i2c_worker_50_dk_c1013 ? 1 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? 0 : initiator_i2c_worker_50_dk_c1015 ? 0 : 'bz;
  assign initiator_i2c_worker_50_dk_high_addr16_inl8 = (initiator_i2c_worker_50_dk_t890_inl8 >>> 8);
  assign initiator_i2c_worker_50_dk_high_addr16_inl9 = (initiator_i2c_worker_50_dk_t888_inl9 >>> 8);
  assign initiator_i2c_worker_50_dk_high_addr8_inl8 = (initiator_i2c_worker_50_dk_high_addr16_inl8 & 255);
  assign initiator_i2c_worker_50_dk_high_addr8_inl9 = (initiator_i2c_worker_50_dk_high_addr16_inl9 & 255);
  assign initiator_i2c_worker_50_dk_i_inl104 = (initiator_i2c_worker_50_dk_i_inl103 + 1);
  assign initiator_i2c_worker_50_dk_i_inl10_inl54 = (initiator_i2c_worker_50_dk_i_inl10_inl53 + 1);
  assign initiator_i2c_worker_50_dk_i_inl10_inl94 = (initiator_i2c_worker_50_dk_i_inl10_inl93 + 1);
  assign initiator_i2c_worker_50_dk_i_inl13_inl94 = (initiator_i2c_worker_50_dk_i_inl13_inl93 + 1);
  assign initiator_i2c_worker_50_dk_i_inl1_inl2_inl24 = (initiator_i2c_worker_50_dk_i_inl1_inl2_inl23 + 1);
  assign initiator_i2c_worker_50_dk_i_inl1_inl2_inl34 = (initiator_i2c_worker_50_dk_i_inl1_inl2_inl33 + 1);
  assign initiator_i2c_worker_50_dk_i_inl1_inl2_inl44 = (initiator_i2c_worker_50_dk_i_inl1_inl2_inl43 + 1);
  assign initiator_i2c_worker_50_dk_i_inl1_inl2_inl84 = (initiator_i2c_worker_50_dk_i_inl1_inl2_inl83 + 1);
  assign initiator_i2c_worker_50_dk_i_inl1_inl3_inl54 = (initiator_i2c_worker_50_dk_i_inl1_inl3_inl53 + 1);
  assign initiator_i2c_worker_50_dk_i_inl1_inl3_inl94 = (initiator_i2c_worker_50_dk_i_inl1_inl3_inl93 + 1);
  assign initiator_i2c_worker_50_dk_i_inl1_inl4_inl54 = (initiator_i2c_worker_50_dk_i_inl1_inl4_inl53 + 1);
  assign initiator_i2c_worker_50_dk_i_inl1_inl4_inl94 = (initiator_i2c_worker_50_dk_i_inl1_inl4_inl93 + 1);
  assign initiator_i2c_worker_50_dk_i_inl4_inl34 = (initiator_i2c_worker_50_dk_i_inl4_inl33 + 1);
  assign initiator_i2c_worker_50_dk_i_inl5_inl24 = (initiator_i2c_worker_50_dk_i_inl5_inl23 + 1);
  assign initiator_i2c_worker_50_dk_i_inl6_inl44 = (initiator_i2c_worker_50_dk_i_inl6_inl43 + 1);
  assign initiator_i2c_worker_50_dk_i_inl7_inl44 = (initiator_i2c_worker_50_dk_i_inl7_inl43 + 1);
  assign initiator_i2c_worker_50_dk_i_inl7_inl84 = (initiator_i2c_worker_50_dk_i_inl7_inl83 + 1);
  assign initiator_i2c_worker_50_dk_i_inl8_inl54 = (initiator_i2c_worker_50_dk_i_inl8_inl53 + 1);
  assign initiator_i2c_worker_50_dk_i_inl8_inl84 = (initiator_i2c_worker_50_dk_i_inl8_inl83 + 1);
  assign initiator_i2c_worker_50_dk_i_inl9_inl84 = (initiator_i2c_worker_50_dk_i_inl9_inl83 + 1);
  assign initiator_i2c_worker_50_dk_i_inl9_inl94 = (initiator_i2c_worker_50_dk_i_inl9_inl93 + 1);
  assign initiator_i2c_worker_50_dk_low_addr8_inl8 = (initiator_i2c_worker_50_dk_data16_inl63 & 255);
  assign initiator_i2c_worker_50_dk_low_addr8_inl9 = (initiator_i2c_worker_50_dk_data16_inl73 & 255);
  assign initiator_i2c_worker_50_dk_msb_inl10_inl9 = initiator_i2c_worker_50_dk_t4001;
  assign initiator_i2c_worker_50_dk_msb_inl1_inl2_inl2 = initiator_i2c_worker_50_dk_t3986;
  assign initiator_i2c_worker_50_dk_msb_inl1_inl2_inl3 = initiator_i2c_worker_50_dk_t3988;
  assign initiator_i2c_worker_50_dk_msb_inl1_inl2_inl4 = initiator_i2c_worker_50_dk_t3989;
  assign initiator_i2c_worker_50_dk_msb_inl1_inl2_inl8 = initiator_i2c_worker_50_dk_t3995;
  assign initiator_i2c_worker_50_dk_msb_inl1_inl3_inl5 = initiator_i2c_worker_50_dk_t3992;
  assign initiator_i2c_worker_50_dk_msb_inl1_inl3_inl9 = initiator_i2c_worker_50_dk_t3999;
  assign initiator_i2c_worker_50_dk_msb_inl1_inl4_inl5 = initiator_i2c_worker_50_dk_t3994;
  assign initiator_i2c_worker_50_dk_msb_inl1_inl4_inl9 = initiator_i2c_worker_50_dk_t4002;
  assign initiator_i2c_worker_50_dk_msb_inl5_inl2 = initiator_i2c_worker_50_dk_t3987;
  assign initiator_i2c_worker_50_dk_msb_inl6_inl4 = initiator_i2c_worker_50_dk_t3990;
  assign initiator_i2c_worker_50_dk_msb_inl7_inl4 = initiator_i2c_worker_50_dk_t3991;
  assign initiator_i2c_worker_50_dk_msb_inl7_inl8 = initiator_i2c_worker_50_dk_t3996;
  assign initiator_i2c_worker_50_dk_msb_inl8_inl5 = initiator_i2c_worker_50_dk_t3993;
  assign initiator_i2c_worker_50_dk_msb_inl8_inl8 = initiator_i2c_worker_50_dk_t3997;
  assign initiator_i2c_worker_50_dk_msb_inl9_inl8 = initiator_i2c_worker_50_dk_t3998;
  assign initiator_i2c_worker_50_dk_msb_inl9_inl9 = initiator_i2c_worker_50_dk_t4000;
  assign initiator_i2c_worker_50_dk_r_data6 = initiator_i2c_worker_50_dk_c873 ? 0 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_r_data_inl4_inl33 : initiator_i2c_worker_50_dk_c1010 ? 0 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_r_data_inl10_inl53 : initiator_i2c_worker_50_dk_c1012 ? 0 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_r_data_inl13_inl93 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? 0 : initiator_i2c_worker_50_dk_c1015 ? 0 : 'bz;
  assign initiator_i2c_worker_50_dk_r_data_inl10_inl54 = (initiator_i2c_worker_50_dk_r_data_inl10_inl53 << 1);
  assign initiator_i2c_worker_50_dk_r_data_inl10_inl55 = (initiator_i2c_worker_50_dk_r_data_inl10_inl54 | initiator_i2c_worker_50_dk_msb_inl10_inl5);
  assign initiator_i2c_worker_50_dk_r_data_inl13_inl94 = (initiator_i2c_worker_50_dk_r_data_inl13_inl93 << 1);
  assign initiator_i2c_worker_50_dk_r_data_inl13_inl95 = (initiator_i2c_worker_50_dk_r_data_inl13_inl94 | initiator_i2c_worker_50_dk_msb_inl13_inl9);
  assign initiator_i2c_worker_50_dk_r_data_inl4_inl34 = (initiator_i2c_worker_50_dk_r_data_inl4_inl33 << 1);
  assign initiator_i2c_worker_50_dk_r_data_inl4_inl35 = (initiator_i2c_worker_50_dk_r_data_inl4_inl34 | initiator_i2c_worker_50_dk_msb_inl4_inl3);
  assign initiator_i2c_worker_50_dk_raw_data_inl10_inl94 = (initiator_i2c_worker_50_dk_raw_data_inl10_inl93 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl24 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl23 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl34 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl33 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl44 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl43 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl84 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl83 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl54 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl53 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl94 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl93 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl54 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl53 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl94 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl93 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl5_inl24 = (initiator_i2c_worker_50_dk_raw_data_inl5_inl23 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl6_inl44 = (initiator_i2c_worker_50_dk_raw_data_inl6_inl43 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl7_inl44 = (initiator_i2c_worker_50_dk_raw_data_inl7_inl43 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl7_inl84 = (initiator_i2c_worker_50_dk_raw_data_inl7_inl83 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl8_inl54 = (initiator_i2c_worker_50_dk_raw_data_inl8_inl53 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl8_inl84 = (initiator_i2c_worker_50_dk_raw_data_inl8_inl83 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl9_inl84 = (initiator_i2c_worker_50_dk_raw_data_inl9_inl83 << 1);
  assign initiator_i2c_worker_50_dk_raw_data_inl9_inl94 = (initiator_i2c_worker_50_dk_raw_data_inl9_inl93 << 1);
  assign initiator_i2c_worker_50_dk_res2 = (initiator_i2c_worker_50_dk_cmd | 128);
  assign initiator_i2c_worker_50_dk_res3 = (initiator_i2c_worker_50_dk_res2 | 64);
  assign initiator_i2c_worker_50_dk_res4 = initiator_i2c_worker_50_dk_c880 ? initiator_i2c_worker_50_dk_res3 : !initiator_i2c_worker_50_dk_c880 ? initiator_i2c_worker_50_dk_res2 : 'bz;
  assign initiator_i2c_worker_50_dk_t3986 = initiator_i2c_worker_50_dk_c898_inl1_inl2_inl2 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3987 = initiator_i2c_worker_50_dk_c898_inl5_inl2 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3988 = initiator_i2c_worker_50_dk_c898_inl1_inl2_inl3 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3989 = initiator_i2c_worker_50_dk_c898_inl1_inl2_inl4 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3990 = initiator_i2c_worker_50_dk_c898_inl6_inl4 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3991 = initiator_i2c_worker_50_dk_c898_inl7_inl4 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3992 = initiator_i2c_worker_50_dk_c898_inl1_inl3_inl5 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3993 = initiator_i2c_worker_50_dk_c898_inl8_inl5 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3994 = initiator_i2c_worker_50_dk_c898_inl1_inl4_inl5 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3995 = initiator_i2c_worker_50_dk_c898_inl1_inl2_inl8 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3996 = initiator_i2c_worker_50_dk_c898_inl7_inl8 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3997 = initiator_i2c_worker_50_dk_c898_inl8_inl8 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3998 = initiator_i2c_worker_50_dk_c898_inl9_inl8 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t3999 = initiator_i2c_worker_50_dk_c898_inl1_inl3_inl9 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t4000 = initiator_i2c_worker_50_dk_c898_inl9_inl9 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t4001 = initiator_i2c_worker_50_dk_c898_inl10_inl9 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t4002 = initiator_i2c_worker_50_dk_c898_inl1_inl4_inl9 ? 1 : 0;
  assign initiator_i2c_worker_50_dk_t884 = (initiator_i2c_worker_50_dk_n_1 + 1);
  assign initiator_i2c_worker_50_dk_t887_inl6 = (initiator_i2c_worker_50_dk_data16_inl62 << 8);
  assign initiator_i2c_worker_50_dk_t887_inl7 = (initiator_i2c_worker_50_dk_data16_inl72 << 8);
  assign initiator_i2c_worker_50_dk_t888_inl9 = (initiator_i2c_worker_50_dk_data16_inl73 & 65280);
  assign initiator_i2c_worker_50_dk_t890_inl8 = (initiator_i2c_worker_50_dk_data16_inl63 & 65280);
  assign initiator_i2c_worker_50_dk_t894_inl2_inl2 = (initiator_i2c_worker_50_dk_w_addr2 << 1);
  assign initiator_i2c_worker_50_dk_t894_inl2_inl3 = (initiator_i2c_worker_50_dk_r_addr2 << 1);
  assign initiator_i2c_worker_50_dk_t894_inl2_inl4 = (initiator_i2c_worker_50_dk_w_addr3 << 1);
  assign initiator_i2c_worker_50_dk_t894_inl2_inl8 = (initiator_i2c_worker_50_dk_w_addr4 << 1);
  assign initiator_i2c_worker_50_dk_t894_inl3_inl5 = (initiator_i2c_worker_50_dk_slave_addr83 << 1);
  assign initiator_i2c_worker_50_dk_t894_inl3_inl9 = (initiator_i2c_worker_50_dk_r_addr3 << 1);
  assign initiator_i2c_worker_50_dk_t894_inl4_inl5 = (initiator_i2c_worker_50_dk_slave_addr83 << 1);
  assign initiator_i2c_worker_50_dk_t894_inl4_inl9 = (initiator_i2c_worker_50_dk_r_addr3 << 1);
  assign initiator_i2c_worker_50_dk_t895_inl2_inl2 = (initiator_i2c_worker_50_dk_t894_inl2_inl2 | 0);
  assign initiator_i2c_worker_50_dk_t895_inl2_inl3 = (initiator_i2c_worker_50_dk_t894_inl2_inl3 | 1);
  assign initiator_i2c_worker_50_dk_t895_inl2_inl4 = (initiator_i2c_worker_50_dk_t894_inl2_inl4 | 0);
  assign initiator_i2c_worker_50_dk_t895_inl2_inl8 = (initiator_i2c_worker_50_dk_t894_inl2_inl8 | 0);
  assign initiator_i2c_worker_50_dk_t895_inl3_inl5 = (initiator_i2c_worker_50_dk_t894_inl3_inl5 | 0);
  assign initiator_i2c_worker_50_dk_t895_inl3_inl9 = (initiator_i2c_worker_50_dk_t894_inl3_inl9 | 0);
  assign initiator_i2c_worker_50_dk_t895_inl4_inl5 = (initiator_i2c_worker_50_dk_t894_inl4_inl5 | 1);
  assign initiator_i2c_worker_50_dk_t895_inl4_inl9 = (initiator_i2c_worker_50_dk_t894_inl4_inl9 | 1);
  assign initiator_i2c_worker_50_dk_t897_inl10_inl9 = (initiator_i2c_worker_50_dk_raw_data_inl10_inl93 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl1_inl2_inl2 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl23 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl1_inl2_inl3 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl33 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl1_inl2_inl4 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl43 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl1_inl2_inl8 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl83 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl1_inl3_inl5 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl53 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl1_inl3_inl9 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl93 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl1_inl4_inl5 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl53 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl1_inl4_inl9 = (initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl93 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl5_inl2 = (initiator_i2c_worker_50_dk_raw_data_inl5_inl23 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl6_inl4 = (initiator_i2c_worker_50_dk_raw_data_inl6_inl43 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl7_inl4 = (initiator_i2c_worker_50_dk_raw_data_inl7_inl43 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl7_inl8 = (initiator_i2c_worker_50_dk_raw_data_inl7_inl83 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl8_inl5 = (initiator_i2c_worker_50_dk_raw_data_inl8_inl53 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl8_inl8 = (initiator_i2c_worker_50_dk_raw_data_inl8_inl83 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl9_inl8 = (initiator_i2c_worker_50_dk_raw_data_inl9_inl83 & 128);
  assign initiator_i2c_worker_50_dk_t897_inl9_inl9 = (initiator_i2c_worker_50_dk_raw_data_inl9_inl93 & 128);
  assign initiator_worker_dj_c2957 = (initiator_worker_dj_c910 && !initiator_worker_dj_c917_inl6);
  assign initiator_worker_dj_c5944 = (initiator_worker_dj_c910 && !initiator_worker_dj_c917_inl6);
  assign initiator_worker_dj_c910 = (initiator_worker_dj_counter8623 < 256);
  assign initiator_worker_dj_c917_inl6 = (initiator_worker_dj_t916_inl6 == 128);
  assign initiator_worker_dj_counter8624 = (initiator_worker_dj_counter8623 + 1);
  assign initiator_worker_dj_data_i = ov5640_data(initiator_worker_dj_counter8623);
  assign initiator_worker_dj_debug_i4 = (initiator_worker_dj_debug_i3 + 1);
  assign initiator_worker_dj_reg_addr = (initiator_worker_dj_t911 & 65535);
  assign initiator_worker_dj_send_data = (initiator_worker_dj_data_i & 255);
  assign initiator_worker_dj_t911 = (initiator_worker_dj_data_i >>> 8);
  assign initiator_worker_dj_t912_inl6 = (initiator_worker_dj_reg_addr >>> 8);
  assign initiator_worker_dj_t913_inl6 = (initiator_worker_dj_t912_inl6 & 255);
  assign initiator_worker_dj_t914_inl6 = (initiator_worker_dj_reg_addr & 255);
  assign initiator_worker_dj_t916_inl6 = (initiator_worker_dj_v_inl6 & 128);
  //sub modules
  //i2c_cmd_q instance
  FIFO#(
    .LENGTH(1),
    .ADDR_WIDTH(1),
    .DATA_WIDTH(8)
    )
    i2c_cmd_q(
      .clk(clk),
      .rst(rst),
      .din(i2c_cmd_q_din),
      .write(i2c_cmd_q_write),
      .full(i2c_cmd_q_full),
      .dout(i2c_cmd_q_dout),
      .read(i2c_cmd_q_read),
      .empty(i2c_cmd_q_empty),
      .will_full(i2c_cmd_q_will_full),
      .will_empty(i2c_cmd_q_will_empty)
    );
  //i2c_res_q instance
  FIFO#(
    .LENGTH(1),
    .ADDR_WIDTH(1),
    .DATA_WIDTH(8)
    )
    i2c_res_q(
      .clk(clk),
      .rst(rst),
      .din(i2c_res_q_din),
      .write(i2c_res_q_write),
      .full(i2c_res_q_full),
      .dout(i2c_res_q_dout),
      .read(i2c_res_q_read),
      .empty(i2c_res_q_empty),
      .will_full(i2c_res_q_will_full),
      .will_empty(i2c_res_q_will_empty)
    );
  
  
  always @(posedge clk) begin
    if (rst) begin
      debug_print_pin <= 0;
      done <= 0;
      i2c_cmd_q_din <= 0;
      i2c_cmd_q_write <= 0;
      i2c_res_q_read <= 0;
      initiator_worker_dj_counter8623 <= 0;
      initiator_worker_dj_debug_i3 <= 0;
      initiator_worker_dj_v_inl6 <= 0;
      initiator_worker_dj_state <= ov5640_initiator_worker_dj_b1_INIT;
    end else begin //if (rst)
      case(initiator_worker_dj_state)
      ov5640_initiator_worker_dj_b1_INIT: begin
        done <= 0;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_b1_S1;
      end
      ov5640_initiator_worker_dj_b1_S1: begin
        debug_print_pin <= 1;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L1_while2_S0;
      end
      ov5640_initiator_worker_dj_L1_while2_S0: begin
        done <= 0;
        initiator_worker_dj_counter8623 <= 0;
        initiator_worker_dj_debug_i3 <= 17;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L1_while2_S1;
      end
      ov5640_initiator_worker_dj_L1_while2_S1: begin
        debug_print_pin <= 16;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_fortest4_S0;
      end
      ov5640_initiator_worker_dj_L1_forelse9_S1: begin
        debug_print_pin <= 242;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L1_forelse9_S2;
      end
      ov5640_initiator_worker_dj_L1_forelse9_S2: begin
        if (resend == 1) begin
          debug_print_pin <= 243;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L1_while2_S0;
        end
      end
      ov5640_initiator_worker_dj_L2_fortest4_S0: begin
        /* initiator_worker_dj_c910 <= (initiator_worker_dj_counter8623 < 256); */
        if (initiator_worker_dj_c910) begin
          debug_print_pin <= initiator_worker_dj_debug_i3;
          /* initiator_worker_dj_data_i <= ov5640_data(initiator_worker_dj_counter8623); */
          /* initiator_worker_dj_t911 <= (initiator_worker_dj_data_i >>> 8); */
          /* initiator_worker_dj_send_data <= (initiator_worker_dj_data_i & 255); */
          /* initiator_worker_dj_reg_addr <= (initiator_worker_dj_t911 & 65535); */
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S1;
        end else begin
          done <= 1;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L1_forelse9_S1;
        end
      end
      ov5640_initiator_worker_dj_L2_forbody5_S1: begin
        debug_print_pin <= 33;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S2;
      end
      ov5640_initiator_worker_dj_L2_forbody5_S2: begin
        if (i2c_cmd_q_full == 0) begin
          i2c_cmd_q_write <= 1;
          i2c_cmd_q_din <= 3;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S4;
        end
      end
      ov5640_initiator_worker_dj_L2_forbody5_S4: begin
        i2c_cmd_q_write <= 0;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S5;
      end
      ov5640_initiator_worker_dj_L2_forbody5_S5: begin
        if (i2c_cmd_q_full == 0) begin
          i2c_cmd_q_write <= 1;
          i2c_cmd_q_din <= 60;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S7;
        end
      end
      ov5640_initiator_worker_dj_L2_forbody5_S7: begin
        i2c_cmd_q_write <= 0;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S8;
      end
      ov5640_initiator_worker_dj_L2_forbody5_S8: begin
        if (i2c_cmd_q_full == 0) begin
          i2c_cmd_q_write <= 1;
          i2c_cmd_q_din <= initiator_worker_dj_t913_inl6;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S10;
        end
        /* initiator_worker_dj_t912_inl6 <= (initiator_worker_dj_reg_addr >>> 8); */
        /* initiator_worker_dj_t913_inl6 <= (initiator_worker_dj_t912_inl6 & 255); */
      end
      ov5640_initiator_worker_dj_L2_forbody5_S10: begin
        i2c_cmd_q_write <= 0;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S11;
      end
      ov5640_initiator_worker_dj_L2_forbody5_S11: begin
        if (i2c_cmd_q_full == 0) begin
          i2c_cmd_q_write <= 1;
          i2c_cmd_q_din <= initiator_worker_dj_t914_inl6;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S13;
        end
        /* initiator_worker_dj_t914_inl6 <= (initiator_worker_dj_reg_addr & 255); */
      end
      ov5640_initiator_worker_dj_L2_forbody5_S13: begin
        i2c_cmd_q_write <= 0;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S14;
      end
      ov5640_initiator_worker_dj_L2_forbody5_S14: begin
        if (i2c_cmd_q_full == 0) begin
          i2c_cmd_q_write <= 1;
          i2c_cmd_q_din <= initiator_worker_dj_send_data;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S16;
        end
      end
      ov5640_initiator_worker_dj_L2_forbody5_S16: begin
        i2c_cmd_q_write <= 0;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_forbody5_S17;
      end
      ov5640_initiator_worker_dj_L2_forbody5_S17: begin
        debug_print_pin <= 36;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L3_while6_S0;
      end
      ov5640_initiator_worker_dj_L3_while6_S0: begin
        if (i2c_res_q_empty == 0) begin
          i2c_res_q_read <= 1;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L3_while6_S2;
        end
      end
      ov5640_initiator_worker_dj_L3_while6_S2: begin
        i2c_res_q_read <= 0;
        initiator_worker_dj_v_inl6 <= i2c_res_q_dout;
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L3_while6_S3;
      end
      ov5640_initiator_worker_dj_L3_while6_S3: begin
        debug_print_pin <= initiator_worker_dj_v_inl6;
        /* initiator_worker_dj_t916_inl6 <= (initiator_worker_dj_v_inl6 & 128); */
        /* initiator_worker_dj_c917_inl6 <= (initiator_worker_dj_t916_inl6 == 128); */
        initiator_worker_dj_state <= ov5640_initiator_worker_dj_L3_while6_S4;
      end
      ov5640_initiator_worker_dj_L3_while6_S4: begin
        if (initiator_worker_dj_c917_inl6) begin
          debug_print_pin <= 47;
          /* initiator_worker_dj_debug_i4 <= (initiator_worker_dj_debug_i3 + 1); */
          /* initiator_worker_dj_counter8624 <= (initiator_worker_dj_counter8623 + 1); */
          initiator_worker_dj_counter8623 <= initiator_worker_dj_counter8624;
          initiator_worker_dj_debug_i3 <= initiator_worker_dj_debug_i4;
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L2_fortest4_S0;
        end else begin
          /* initiator_worker_dj_c5944 <= (initiator_worker_dj_c910 && !initiator_worker_dj_c917_inl6); */
          /* initiator_worker_dj_c2957 <= (initiator_worker_dj_c910 && !initiator_worker_dj_c917_inl6); */
          initiator_worker_dj_state <= ov5640_initiator_worker_dj_L3_while6_S0;
        end
      end
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (rst) begin
      i2c_cmd_q_read <= 0;
      i2c_res_q_din <= 0;
      i2c_res_q_write <= 0;
      i2c_scl_o <= 0;
      i2c_scl_t <= 1;
      i2c_sda_o <= 0;
      i2c_sda_t <= 1;
      initiator_i2c_worker_50_dk_ack_check_inl3_inl2 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl3_inl3 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl3_inl4 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl3_inl8 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl4_inl2 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl4_inl4 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl4_inl8 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl5_inl4 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl5_inl5 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl5_inl8 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl5_inl9 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl6_inl5 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl6_inl8 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl6_inl9 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl7_inl5 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl7_inl9 <= 0;
      initiator_i2c_worker_50_dk_ack_check_inl8_inl9 <= 0;
      initiator_i2c_worker_50_dk_b0_inl103 <= 0;
      initiator_i2c_worker_50_dk_cmd <= 0;
      initiator_i2c_worker_50_dk_i_inl103 <= 0;
      initiator_i2c_worker_50_dk_i_inl10_inl53 <= 0;
      initiator_i2c_worker_50_dk_i_inl10_inl93 <= 0;
      initiator_i2c_worker_50_dk_i_inl13_inl93 <= 0;
      initiator_i2c_worker_50_dk_i_inl1_inl2_inl23 <= 0;
      initiator_i2c_worker_50_dk_i_inl1_inl2_inl33 <= 0;
      initiator_i2c_worker_50_dk_i_inl1_inl2_inl43 <= 0;
      initiator_i2c_worker_50_dk_i_inl1_inl2_inl83 <= 0;
      initiator_i2c_worker_50_dk_i_inl1_inl3_inl53 <= 0;
      initiator_i2c_worker_50_dk_i_inl1_inl3_inl93 <= 0;
      initiator_i2c_worker_50_dk_i_inl1_inl4_inl53 <= 0;
      initiator_i2c_worker_50_dk_i_inl1_inl4_inl93 <= 0;
      initiator_i2c_worker_50_dk_i_inl4_inl33 <= 0;
      initiator_i2c_worker_50_dk_i_inl5_inl23 <= 0;
      initiator_i2c_worker_50_dk_i_inl6_inl43 <= 0;
      initiator_i2c_worker_50_dk_i_inl7_inl43 <= 0;
      initiator_i2c_worker_50_dk_i_inl7_inl83 <= 0;
      initiator_i2c_worker_50_dk_i_inl8_inl53 <= 0;
      initiator_i2c_worker_50_dk_i_inl8_inl83 <= 0;
      initiator_i2c_worker_50_dk_i_inl9_inl83 <= 0;
      initiator_i2c_worker_50_dk_i_inl9_inl93 <= 0;
      initiator_i2c_worker_50_dk_msb_inl10_inl5 <= 0;
      initiator_i2c_worker_50_dk_msb_inl13_inl9 <= 0;
      initiator_i2c_worker_50_dk_msb_inl4_inl3 <= 0;
      initiator_i2c_worker_50_dk_n_1 <= 0;
      initiator_i2c_worker_50_dk_r_addr2 <= 0;
      initiator_i2c_worker_50_dk_r_addr3 <= 0;
      initiator_i2c_worker_50_dk_r_addr4 <= 0;
      initiator_i2c_worker_50_dk_r_data_inl10_inl53 <= 0;
      initiator_i2c_worker_50_dk_r_data_inl13_inl93 <= 0;
      initiator_i2c_worker_50_dk_r_data_inl4_inl33 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl10_inl93 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl23 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl33 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl43 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl83 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl53 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl93 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl53 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl93 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl5_inl23 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl6_inl43 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl7_inl43 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl7_inl83 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl8_inl53 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl8_inl83 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl9_inl83 <= 0;
      initiator_i2c_worker_50_dk_raw_data_inl9_inl93 <= 0;
      initiator_i2c_worker_50_dk_reg_addr83 <= 0;
      initiator_i2c_worker_50_dk_reg_addr84 <= 0;
      initiator_i2c_worker_50_dk_reg_addr_high3 <= 0;
      initiator_i2c_worker_50_dk_reg_addr_high4 <= 0;
      initiator_i2c_worker_50_dk_reg_addr_low3 <= 0;
      initiator_i2c_worker_50_dk_reg_addr_low4 <= 0;
      initiator_i2c_worker_50_dk_slave_addr83 <= 0;
      initiator_i2c_worker_50_dk_w_addr2 <= 0;
      initiator_i2c_worker_50_dk_w_addr3 <= 0;
      initiator_i2c_worker_50_dk_w_addr4 <= 0;
      initiator_i2c_worker_50_dk_w_addr5 <= 0;
      initiator_i2c_worker_50_dk_w_data2 <= 0;
      initiator_i2c_worker_50_dk_w_data3 <= 0;
      initiator_i2c_worker_50_dk_w_data4 <= 0;
      initiator_i2c_worker_50_dk_w_data5 <= 0;
      initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_b1_INIT;
    end else begin //if (rst)
      case(initiator_i2c_worker_50_dk_state)
      ov5640_initiator_i2c_worker_50_dk_b1_INIT: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_b1_S1;
      end
      ov5640_initiator_i2c_worker_50_dk_b1_S1: begin
        i2c_scl_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_b1_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_b1_S2: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_b1_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_b1_S3: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_while2_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_while2_S0: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_while2_S2;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_while2_S2: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_cmd <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_while2_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_while2_S3: begin
        /* initiator_i2c_worker_50_dk_res2 <= (initiator_i2c_worker_50_dk_cmd | 128); */
        /* initiator_i2c_worker_50_dk_c873 <= (initiator_i2c_worker_50_dk_cmd == 1); */
        /* initiator_i2c_worker_50_dk_c874 <= (initiator_i2c_worker_50_dk_cmd == 2); */
        /* initiator_i2c_worker_50_dk_c875 <= (initiator_i2c_worker_50_dk_cmd == 5); */
        /* initiator_i2c_worker_50_dk_c876 <= (initiator_i2c_worker_50_dk_cmd == 6); */
        /* initiator_i2c_worker_50_dk_c877 <= (initiator_i2c_worker_50_dk_cmd == 3); */
        /* initiator_i2c_worker_50_dk_c878 <= (initiator_i2c_worker_50_dk_cmd == 4); */
        /* initiator_i2c_worker_50_dk_c879 <= (initiator_i2c_worker_50_dk_cmd == 7); */
        /* initiator_i2c_worker_50_dk_c1009 <= (!initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c874); */
        /* initiator_i2c_worker_50_dk_c3966 <= (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874); */
        /* initiator_i2c_worker_50_dk_c3967 <= (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874); */
        /* initiator_i2c_worker_50_dk_c3969 <= (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874); */
        /* initiator_i2c_worker_50_dk_c3972 <= (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874); */
        /* initiator_i2c_worker_50_dk_c3976 <= (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874); */
        /* initiator_i2c_worker_50_dk_c3981 <= (!initiator_i2c_worker_50_dk_c873 && !initiator_i2c_worker_50_dk_c874); */
        /* initiator_i2c_worker_50_dk_c1010 <= (initiator_i2c_worker_50_dk_c3966 && initiator_i2c_worker_50_dk_c875); */
        /* initiator_i2c_worker_50_dk_c3968 <= (initiator_i2c_worker_50_dk_c3967 && !initiator_i2c_worker_50_dk_c875); */
        /* initiator_i2c_worker_50_dk_c3970 <= (initiator_i2c_worker_50_dk_c3969 && !initiator_i2c_worker_50_dk_c875); */
        /* initiator_i2c_worker_50_dk_c3973 <= (initiator_i2c_worker_50_dk_c3972 && !initiator_i2c_worker_50_dk_c875); */
        /* initiator_i2c_worker_50_dk_c3977 <= (initiator_i2c_worker_50_dk_c3976 && !initiator_i2c_worker_50_dk_c875); */
        /* initiator_i2c_worker_50_dk_c3982 <= (initiator_i2c_worker_50_dk_c3981 && !initiator_i2c_worker_50_dk_c875); */
        /* initiator_i2c_worker_50_dk_c1011 <= (initiator_i2c_worker_50_dk_c3968 && initiator_i2c_worker_50_dk_c876); */
        /* initiator_i2c_worker_50_dk_c3971 <= (initiator_i2c_worker_50_dk_c3970 && !initiator_i2c_worker_50_dk_c876); */
        /* initiator_i2c_worker_50_dk_c3974 <= (initiator_i2c_worker_50_dk_c3973 && !initiator_i2c_worker_50_dk_c876); */
        /* initiator_i2c_worker_50_dk_c3978 <= (initiator_i2c_worker_50_dk_c3977 && !initiator_i2c_worker_50_dk_c876); */
        /* initiator_i2c_worker_50_dk_c3983 <= (initiator_i2c_worker_50_dk_c3982 && !initiator_i2c_worker_50_dk_c876); */
        /* initiator_i2c_worker_50_dk_c1012 <= (initiator_i2c_worker_50_dk_c3971 && initiator_i2c_worker_50_dk_c877); */
        /* initiator_i2c_worker_50_dk_c3975 <= (initiator_i2c_worker_50_dk_c3974 && !initiator_i2c_worker_50_dk_c877); */
        /* initiator_i2c_worker_50_dk_c3979 <= (initiator_i2c_worker_50_dk_c3978 && !initiator_i2c_worker_50_dk_c877); */
        /* initiator_i2c_worker_50_dk_c3984 <= (initiator_i2c_worker_50_dk_c3983 && !initiator_i2c_worker_50_dk_c877); */
        /* initiator_i2c_worker_50_dk_c1013 <= (initiator_i2c_worker_50_dk_c3975 && initiator_i2c_worker_50_dk_c878); */
        /* initiator_i2c_worker_50_dk_c3980 <= (initiator_i2c_worker_50_dk_c3979 && !initiator_i2c_worker_50_dk_c878); */
        /* initiator_i2c_worker_50_dk_c3985 <= (initiator_i2c_worker_50_dk_c3984 && !initiator_i2c_worker_50_dk_c878); */
        /* initiator_i2c_worker_50_dk_c1014 <= (initiator_i2c_worker_50_dk_c3980 && initiator_i2c_worker_50_dk_c879); */
        /* initiator_i2c_worker_50_dk_c1015 <= (initiator_i2c_worker_50_dk_c3985 && !initiator_i2c_worker_50_dk_c879); */
        if (initiator_i2c_worker_50_dk_c873) begin
          if (i2c_cmd_q_empty == 0) begin
            i2c_cmd_q_read <= 1;
            initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S2;
          end
        end else if (initiator_i2c_worker_50_dk_c1009) begin
          if (i2c_cmd_q_empty == 0) begin
            i2c_cmd_q_read <= 1;
            initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S2;
          end
        end else if (initiator_i2c_worker_50_dk_c1010) begin
          if (i2c_cmd_q_empty == 0) begin
            i2c_cmd_q_read <= 1;
            initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S2;
          end
        end else if (initiator_i2c_worker_50_dk_c1011) begin
          if (i2c_cmd_q_empty == 0) begin
            i2c_cmd_q_read <= 1;
            initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S2;
          end
        end else if (initiator_i2c_worker_50_dk_c1012) begin
          if (i2c_cmd_q_empty == 0) begin
            i2c_cmd_q_read <= 1;
            initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S2;
          end
        end else if (initiator_i2c_worker_50_dk_c1013) begin
          if (i2c_cmd_q_empty == 0) begin
            i2c_cmd_q_read <= 1;
            initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S2;
          end
        end else if (initiator_i2c_worker_50_dk_c1014) begin
          if (i2c_cmd_q_empty == 0) begin
            i2c_cmd_q_read <= 1;
            initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S2;
          end
        end else if (initiator_i2c_worker_50_dk_c1015) begin
          /* initiator_i2c_worker_50_dk_c885 <= (initiator_i2c_worker_50_dk_cmd == 0); */
          if (!(initiator_i2c_worker_50_dk_cmd === 0)) begin
            $display("ASSERTION FAILED: i2c_module.py [342]: assert(cmd == NOP_CMD)"); $finish;
          end
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S0;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S2: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_w_addr2 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S3: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S5;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S5: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_w_data2 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S6: begin
        i2c_sda_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S7: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S8: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t894_inl2_inl2 <= (initiator_i2c_worker_50_dk_w_addr2 << 1); */
        /* initiator_i2c_worker_50_dk_t895_inl2_inl2 <= (initiator_i2c_worker_50_dk_t894_inl2_inl2 | 0); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen4_S9: begin
        initiator_i2c_worker_50_dk_i_inl1_inl2_inl23 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl23 <= initiator_i2c_worker_50_dk_t895_inl2_inl2;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L21_fortest5_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S2: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_r_addr2 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S3: begin
        i2c_sda_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S4: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S5: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t894_inl2_inl3 <= (initiator_i2c_worker_50_dk_r_addr2 << 1); */
        /* initiator_i2c_worker_50_dk_t895_inl2_inl3 <= (initiator_i2c_worker_50_dk_t894_inl2_inl3 | 1); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen16_S6: begin
        initiator_i2c_worker_50_dk_i_inl1_inl2_inl33 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl33 <= initiator_i2c_worker_50_dk_t895_inl2_inl3;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L19_fortest17_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S2: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_w_addr3 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S3: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S5;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S5: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_reg_addr83 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S6: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S8;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S8: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_w_data3 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S9: begin
        i2c_sda_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S10: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S11;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S11: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t894_inl2_inl4 <= (initiator_i2c_worker_50_dk_w_addr3 << 1); */
        /* initiator_i2c_worker_50_dk_t895_inl2_inl4 <= (initiator_i2c_worker_50_dk_t894_inl2_inl4 | 0); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S12;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen25_S12: begin
        initiator_i2c_worker_50_dk_i_inl1_inl2_inl43 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl43 <= initiator_i2c_worker_50_dk_t895_inl2_inl4;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L16_fortest26_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S2: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_slave_addr83 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S3: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S5;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S5: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_reg_addr84 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S6: begin
        i2c_sda_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S7: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S8: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t894_inl3_inl5 <= (initiator_i2c_worker_50_dk_slave_addr83 << 1); */
        /* initiator_i2c_worker_50_dk_t895_inl3_inl5 <= (initiator_i2c_worker_50_dk_t894_inl3_inl5 | 0); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen38_S9: begin
        initiator_i2c_worker_50_dk_i_inl1_inl3_inl53 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl53 <= initiator_i2c_worker_50_dk_t895_inl3_inl5;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L12_fortest39_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S2: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_w_addr4 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S3: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S5;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S5: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_reg_addr_high3 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S6: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S8;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S8: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_reg_addr_low3 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S9: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S11;
        end
        /* initiator_i2c_worker_50_dk_data16_inl62 <= initiator_i2c_worker_50_dk_reg_addr_high3; */
        /* initiator_i2c_worker_50_dk_t887_inl6 <= (initiator_i2c_worker_50_dk_data16_inl62 << 8); */
        /* initiator_i2c_worker_50_dk_data16_inl63 <= (initiator_i2c_worker_50_dk_t887_inl6 | initiator_i2c_worker_50_dk_reg_addr_low3); */
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S11: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_w_data4 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S12;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S12: begin
        if (i2c_res_q_full == 0) begin
          i2c_res_q_write <= 1;
          i2c_res_q_din <= 39;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S14;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S14: begin
        i2c_res_q_write <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S15;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S15: begin
        i2c_sda_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S16;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S16: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S17;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S17: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t894_inl2_inl8 <= (initiator_i2c_worker_50_dk_w_addr4 << 1); */
        /* initiator_i2c_worker_50_dk_t895_inl2_inl8 <= (initiator_i2c_worker_50_dk_t894_inl2_inl8 | 0); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S18;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen55_S18: begin
        initiator_i2c_worker_50_dk_i_inl1_inl2_inl83 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl83 <= initiator_i2c_worker_50_dk_t895_inl2_inl8;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L8_fortest56_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S2: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_r_addr3 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S3: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S5;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S5: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_reg_addr_high4 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S6: begin
        if (i2c_cmd_q_empty == 0) begin
          i2c_cmd_q_read <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S8;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S8: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_reg_addr_low4 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S9: begin
        i2c_sda_o <= 0;
        /* initiator_i2c_worker_50_dk_data16_inl72 <= initiator_i2c_worker_50_dk_reg_addr_high4; */
        /* initiator_i2c_worker_50_dk_t887_inl7 <= (initiator_i2c_worker_50_dk_data16_inl72 << 8); */
        /* initiator_i2c_worker_50_dk_data16_inl73 <= (initiator_i2c_worker_50_dk_t887_inl7 | initiator_i2c_worker_50_dk_reg_addr_low4); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S10: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S11;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S11: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t894_inl3_inl9 <= (initiator_i2c_worker_50_dk_r_addr3 << 1); */
        /* initiator_i2c_worker_50_dk_t895_inl3_inl9 <= (initiator_i2c_worker_50_dk_t894_inl3_inl9 | 0); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S12;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen72_S12: begin
        initiator_i2c_worker_50_dk_i_inl1_inl3_inl93 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl93 <= initiator_i2c_worker_50_dk_t895_inl3_inl9;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L3_fortest73_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S2: begin
        i2c_cmd_q_read <= 0;
        initiator_i2c_worker_50_dk_n_1 <= i2c_cmd_q_dout;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S3: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t884 <= (initiator_i2c_worker_50_dk_n_1 + 1); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S4: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S5: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S6: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen93_S7: begin
        initiator_i2c_worker_50_dk_b0_inl103 <= 0;
        initiator_i2c_worker_50_dk_i_inl103 <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L2_fortest94_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl3_inl2 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S6: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S7: begin
        initiator_i2c_worker_50_dk_i_inl5_inl23 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl5_inl23 <= initiator_i2c_worker_50_dk_w_data2;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L22_fortest9_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl3_inl3 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S6: begin
        i2c_sda_t <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S7: begin
        initiator_i2c_worker_50_dk_i_inl4_inl33 <= 0;
        initiator_i2c_worker_50_dk_r_data_inl4_inl33 <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L20_fortest21_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl3_inl4 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S6: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S7: begin
        initiator_i2c_worker_50_dk_i_inl6_inl43 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl6_inl43 <= initiator_i2c_worker_50_dk_reg_addr83;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L17_fortest30_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl5_inl5 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S6: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S7: begin
        initiator_i2c_worker_50_dk_i_inl8_inl53 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl8_inl53 <= initiator_i2c_worker_50_dk_reg_addr84;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L13_fortest43_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl3_inl8 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S6: begin
        if (i2c_res_q_full == 0) begin
          i2c_res_q_write <= 1;
          i2c_res_q_din <= 41;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S8;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S8: begin
        i2c_res_q_write <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S9: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t890_inl8 <= (initiator_i2c_worker_50_dk_data16_inl63 & 65280); */
        /* initiator_i2c_worker_50_dk_high_addr16_inl8 <= (initiator_i2c_worker_50_dk_t890_inl8 >>> 8); */
        /* initiator_i2c_worker_50_dk_high_addr8_inl8 <= (initiator_i2c_worker_50_dk_high_addr16_inl8 & 255); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S10: begin
        initiator_i2c_worker_50_dk_i_inl7_inl83 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl7_inl83 <= initiator_i2c_worker_50_dk_high_addr8_inl8;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L9_fortest60_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl5_inl9 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S4: begin
        i2c_sda_o <= 1;
        /* initiator_i2c_worker_50_dk_t888_inl9 <= (initiator_i2c_worker_50_dk_data16_inl73 & 65280); */
        /* initiator_i2c_worker_50_dk_high_addr16_inl9 <= (initiator_i2c_worker_50_dk_t888_inl9 >>> 8); */
        /* initiator_i2c_worker_50_dk_high_addr8_inl9 <= (initiator_i2c_worker_50_dk_high_addr16_inl9 & 255); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S6: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S7: begin
        initiator_i2c_worker_50_dk_i_inl9_inl93 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl9_inl93 <= initiator_i2c_worker_50_dk_high_addr8_inl9;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L4_fortest77_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl4_inl2 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S6: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S7: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S8: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S9: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S1: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S2: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S3: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S5: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S6: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S7: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S8: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S9: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S10: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl4_inl4 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S6: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S7: begin
        initiator_i2c_worker_50_dk_i_inl7_inl43 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl7_inl43 <= initiator_i2c_worker_50_dk_w_data3;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L18_fortest34_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl6_inl5 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S6: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S7: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S8: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S9: begin
        i2c_sda_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S10: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S11;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S11: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t894_inl4_inl5 <= (initiator_i2c_worker_50_dk_slave_addr83 << 1); */
        /* initiator_i2c_worker_50_dk_t895_inl4_inl5 <= (initiator_i2c_worker_50_dk_t894_inl4_inl5 | 1); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S12;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S12: begin
        initiator_i2c_worker_50_dk_i_inl1_inl4_inl53 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl53 <= initiator_i2c_worker_50_dk_t895_inl4_inl5;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L14_fortest47_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl4_inl8 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S4: begin
        i2c_sda_o <= 1;
        /* initiator_i2c_worker_50_dk_low_addr8_inl8 <= (initiator_i2c_worker_50_dk_data16_inl63 & 255); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S6: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S7: begin
        initiator_i2c_worker_50_dk_i_inl8_inl83 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl8_inl83 <= initiator_i2c_worker_50_dk_low_addr8_inl8;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L10_fortest64_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl6_inl9 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S4: begin
        i2c_sda_o <= 1;
        /* initiator_i2c_worker_50_dk_low_addr8_inl9 <= (initiator_i2c_worker_50_dk_data16_inl73 & 255); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S6: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S7: begin
        initiator_i2c_worker_50_dk_i_inl10_inl93 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl10_inl93 <= initiator_i2c_worker_50_dk_low_addr8_inl9;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L5_fortest81_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl5_inl4 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S6: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S7: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S8: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S9: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl7_inl5 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S6: begin
        i2c_sda_t <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S7: begin
        initiator_i2c_worker_50_dk_i_inl10_inl53 <= 0;
        initiator_i2c_worker_50_dk_r_data_inl10_inl53 <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L15_fortest51_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl5_inl8 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S6: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S7: begin
        initiator_i2c_worker_50_dk_i_inl9_inl83 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl9_inl83 <= initiator_i2c_worker_50_dk_w_data4;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L11_fortest68_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl7_inl9 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S6: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S7: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S8: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S9: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S10: begin
        i2c_sda_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S11;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S11: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S12;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S12: begin
        i2c_sda_t <= 0;
        /* initiator_i2c_worker_50_dk_t894_inl4_inl9 <= (initiator_i2c_worker_50_dk_r_addr3 << 1); */
        /* initiator_i2c_worker_50_dk_t895_inl4_inl9 <= (initiator_i2c_worker_50_dk_t894_inl4_inl9 | 1); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S13;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S13: begin
        initiator_i2c_worker_50_dk_i_inl1_inl4_inl93 <= 0;
        initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl93 <= initiator_i2c_worker_50_dk_t895_inl4_inl9;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L6_fortest85_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S1: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S2: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S3: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S5: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S6: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S7: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S8: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S9: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S10: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl6_inl8 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S6: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S7: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S8: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S9: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S10: begin
        if (i2c_res_q_full == 0) begin
          i2c_res_q_write <= 1;
          i2c_res_q_din <= 38;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S12;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S12: begin
        i2c_res_q_write <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S2: begin
        initiator_i2c_worker_50_dk_ack_check_inl8_inl9 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S3: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S5: begin
        i2c_sda_t <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S6: begin
        i2c_sda_t <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S7: begin
        initiator_i2c_worker_50_dk_i_inl13_inl93 <= 0;
        initiator_i2c_worker_50_dk_r_data_inl13_inl93 <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L7_fortest89_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S1: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S2: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S3: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S4: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S5;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S5: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S6;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S6: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S7;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S7: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S8;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S8: begin
        i2c_sda_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S9;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S9: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S10;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S10: begin
        /*wait a cycle*/
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_b13_S0: begin
        /* initiator_i2c_worker_50_dk_res3 <= (initiator_i2c_worker_50_dk_res2 | 64); */
        /* initiator_i2c_worker_50_dk_has_data_flag6 <= initiator_i2c_worker_50_dk_c873 ? 0 : initiator_i2c_worker_50_dk_c1009 ? 1 : initiator_i2c_worker_50_dk_c1010 ? 0 : initiator_i2c_worker_50_dk_c1011 ? 1 : initiator_i2c_worker_50_dk_c1012 ? 0 : initiator_i2c_worker_50_dk_c1013 ? 1 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? 0 : initiator_i2c_worker_50_dk_c1015 ? 0 : 'bz; */
        initiator_i2c_worker_50_dk_r_addr4 <= initiator_i2c_worker_50_dk_c873 ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_r_addr2 : initiator_i2c_worker_50_dk_c1010 ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1012 ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_r_addr3 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1015 ? initiator_i2c_worker_50_dk_r_addr4 : 'bz;
        initiator_i2c_worker_50_dk_w_addr5 <= initiator_i2c_worker_50_dk_c873 ? initiator_i2c_worker_50_dk_w_addr2 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_w_addr5 : initiator_i2c_worker_50_dk_c1010 ? initiator_i2c_worker_50_dk_w_addr3 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_w_addr5 : initiator_i2c_worker_50_dk_c1012 ? initiator_i2c_worker_50_dk_w_addr4 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_w_addr5 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? initiator_i2c_worker_50_dk_w_addr5 : initiator_i2c_worker_50_dk_c1015 ? initiator_i2c_worker_50_dk_w_addr5 : 'bz;
        initiator_i2c_worker_50_dk_w_data5 <= initiator_i2c_worker_50_dk_c873 ? initiator_i2c_worker_50_dk_w_data2 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_w_data5 : initiator_i2c_worker_50_dk_c1010 ? initiator_i2c_worker_50_dk_w_data3 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_w_data5 : initiator_i2c_worker_50_dk_c1012 ? initiator_i2c_worker_50_dk_w_data4 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_w_data5 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? initiator_i2c_worker_50_dk_w_data5 : initiator_i2c_worker_50_dk_c1015 ? initiator_i2c_worker_50_dk_w_data5 : 'bz;
        /* initiator_i2c_worker_50_dk_c880 <= (initiator_i2c_worker_50_dk_has_data_flag6 != 0); */
        /* initiator_i2c_worker_50_dk_res4 <= initiator_i2c_worker_50_dk_c880 ? initiator_i2c_worker_50_dk_res3 : !initiator_i2c_worker_50_dk_c880 ? initiator_i2c_worker_50_dk_res2 : 'bz; */
        /* initiator_i2c_worker_50_dk_r_data6 <= initiator_i2c_worker_50_dk_c873 ? 0 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_r_data_inl4_inl33 : initiator_i2c_worker_50_dk_c1010 ? 0 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_r_data_inl10_inl53 : initiator_i2c_worker_50_dk_c1012 ? 0 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_r_data_inl13_inl93 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? 0 : initiator_i2c_worker_50_dk_c1015 ? 0 : 'bz; */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S1;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_b13_S1: begin
        if (i2c_res_q_full == 0) begin
          i2c_res_q_write <= 1;
          i2c_res_q_din <= initiator_i2c_worker_50_dk_res4;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S3;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_b13_S3: begin
        i2c_res_q_write <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S4;
      end
      ov5640_initiator_i2c_worker_50_dk_L1_b13_S4: begin
        /* initiator_i2c_worker_50_dk_c881 <= (initiator_i2c_worker_50_dk_has_data_flag6 != 0); */
        if (initiator_i2c_worker_50_dk_c881) begin
          if (i2c_res_q_full == 0) begin
            i2c_res_q_write <= 1;
            i2c_res_q_din <= initiator_i2c_worker_50_dk_r_data6;
            initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_ifthen14_S2;
          end
        end else begin
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_while2_S0;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L1_ifthen14_S2: begin
        i2c_res_q_write <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_while2_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L10_fortest64_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl8_inl8 <= (initiator_i2c_worker_50_dk_i_inl8_inl83 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl8_inl8) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl8_inl8;
          /* initiator_i2c_worker_50_dk_t897_inl8_inl8 <= (initiator_i2c_worker_50_dk_raw_data_inl8_inl83 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl8_inl84 <= (initiator_i2c_worker_50_dk_raw_data_inl8_inl83 << 1); */
          /* initiator_i2c_worker_50_dk_c5938 <= (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl8_inl8); */
          /* initiator_i2c_worker_50_dk_c2939 <= (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl8_inl8); */
          /* initiator_i2c_worker_50_dk_c898_inl8_inl8 <= (initiator_i2c_worker_50_dk_t897_inl8_inl8 == 128); */
          /* initiator_i2c_worker_50_dk_t3997 <= initiator_i2c_worker_50_dk_c898_inl8_inl8 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl8_inl8 <= initiator_i2c_worker_50_dk_t3997; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse67_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L10_forbody65_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl8_inl84 <= (initiator_i2c_worker_50_dk_i_inl8_inl83 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl8_inl83 <= initiator_i2c_worker_50_dk_raw_data_inl8_inl84;
        initiator_i2c_worker_50_dk_i_inl8_inl83 <= initiator_i2c_worker_50_dk_i_inl8_inl84;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L10_fortest64_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L11_fortest68_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl9_inl8 <= (initiator_i2c_worker_50_dk_i_inl9_inl83 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl9_inl8) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl9_inl8;
          /* initiator_i2c_worker_50_dk_t897_inl9_inl8 <= (initiator_i2c_worker_50_dk_raw_data_inl9_inl83 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl9_inl84 <= (initiator_i2c_worker_50_dk_raw_data_inl9_inl83 << 1); */
          /* initiator_i2c_worker_50_dk_c5941 <= (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl9_inl8); */
          /* initiator_i2c_worker_50_dk_c2946 <= (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl9_inl8); */
          /* initiator_i2c_worker_50_dk_c898_inl9_inl8 <= (initiator_i2c_worker_50_dk_t897_inl9_inl8 == 128); */
          /* initiator_i2c_worker_50_dk_t3998 <= initiator_i2c_worker_50_dk_c898_inl9_inl8 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl9_inl8 <= initiator_i2c_worker_50_dk_t3998; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse71_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L11_forbody69_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl9_inl84 <= (initiator_i2c_worker_50_dk_i_inl9_inl83 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl9_inl83 <= initiator_i2c_worker_50_dk_raw_data_inl9_inl84;
        initiator_i2c_worker_50_dk_i_inl9_inl83 <= initiator_i2c_worker_50_dk_i_inl9_inl84;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L11_fortest68_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L12_fortest39_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl1_inl3_inl5 <= (initiator_i2c_worker_50_dk_i_inl1_inl3_inl53 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl1_inl3_inl5) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl1_inl3_inl5;
          /* initiator_i2c_worker_50_dk_t897_inl1_inl3_inl5 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl53 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl54 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl53 << 1); */
          /* initiator_i2c_worker_50_dk_c5926 <= (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl1_inl3_inl5); */
          /* initiator_i2c_worker_50_dk_c2916 <= (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl1_inl3_inl5); */
          /* initiator_i2c_worker_50_dk_c898_inl1_inl3_inl5 <= (initiator_i2c_worker_50_dk_t897_inl1_inl3_inl5 == 128); */
          /* initiator_i2c_worker_50_dk_t3992 <= initiator_i2c_worker_50_dk_c898_inl1_inl3_inl5 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl1_inl3_inl5 <= initiator_i2c_worker_50_dk_t3992; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse42_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L12_forbody40_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl1_inl3_inl54 <= (initiator_i2c_worker_50_dk_i_inl1_inl3_inl53 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl53 <= initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl54;
        initiator_i2c_worker_50_dk_i_inl1_inl3_inl53 <= initiator_i2c_worker_50_dk_i_inl1_inl3_inl54;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L12_fortest39_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L13_fortest43_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl8_inl5 <= (initiator_i2c_worker_50_dk_i_inl8_inl53 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl8_inl5) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl8_inl5;
          /* initiator_i2c_worker_50_dk_t897_inl8_inl5 <= (initiator_i2c_worker_50_dk_raw_data_inl8_inl53 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl8_inl54 <= (initiator_i2c_worker_50_dk_raw_data_inl8_inl53 << 1); */
          /* initiator_i2c_worker_50_dk_c5933 <= (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl8_inl5); */
          /* initiator_i2c_worker_50_dk_c2927 <= (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl8_inl5); */
          /* initiator_i2c_worker_50_dk_c898_inl8_inl5 <= (initiator_i2c_worker_50_dk_t897_inl8_inl5 == 128); */
          /* initiator_i2c_worker_50_dk_t3993 <= initiator_i2c_worker_50_dk_c898_inl8_inl5 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl8_inl5 <= initiator_i2c_worker_50_dk_t3993; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse46_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L13_forbody44_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl8_inl54 <= (initiator_i2c_worker_50_dk_i_inl8_inl53 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl8_inl53 <= initiator_i2c_worker_50_dk_raw_data_inl8_inl54;
        initiator_i2c_worker_50_dk_i_inl8_inl53 <= initiator_i2c_worker_50_dk_i_inl8_inl54;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L13_fortest43_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L14_fortest47_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl1_inl4_inl5 <= (initiator_i2c_worker_50_dk_i_inl1_inl4_inl53 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl1_inl4_inl5) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl1_inl4_inl5;
          /* initiator_i2c_worker_50_dk_t897_inl1_inl4_inl5 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl53 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl54 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl53 << 1); */
          /* initiator_i2c_worker_50_dk_c5937 <= (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl1_inl4_inl5); */
          /* initiator_i2c_worker_50_dk_c2937 <= (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c896_inl1_inl4_inl5); */
          /* initiator_i2c_worker_50_dk_c898_inl1_inl4_inl5 <= (initiator_i2c_worker_50_dk_t897_inl1_inl4_inl5 == 128); */
          /* initiator_i2c_worker_50_dk_t3994 <= initiator_i2c_worker_50_dk_c898_inl1_inl4_inl5 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl1_inl4_inl5 <= initiator_i2c_worker_50_dk_t3994; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse50_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L14_forbody48_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl1_inl4_inl54 <= (initiator_i2c_worker_50_dk_i_inl1_inl4_inl53 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl53 <= initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl54;
        initiator_i2c_worker_50_dk_i_inl1_inl4_inl53 <= initiator_i2c_worker_50_dk_i_inl1_inl4_inl54;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L14_fortest47_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L15_fortest51_S0: begin
        /* initiator_i2c_worker_50_dk_c903_inl10_inl5 <= (initiator_i2c_worker_50_dk_i_inl10_inl53 < 8); */
        if (initiator_i2c_worker_50_dk_c903_inl10_inl5) begin
          i2c_scl_o <= 1;
          /* initiator_i2c_worker_50_dk_r_data_inl10_inl54 <= (initiator_i2c_worker_50_dk_r_data_inl10_inl53 << 1); */
          /* initiator_i2c_worker_50_dk_c5940 <= (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c903_inl10_inl5); */
          /* initiator_i2c_worker_50_dk_c2944 <= (initiator_i2c_worker_50_dk_c1011 && initiator_i2c_worker_50_dk_c903_inl10_inl5); */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S1;
        end else begin
          i2c_sda_t <= 0;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse54_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S1: begin
        initiator_i2c_worker_50_dk_msb_inl10_inl5 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S2: begin
        i2c_scl_o <= 0;
        /* initiator_i2c_worker_50_dk_r_data_inl10_inl55 <= (initiator_i2c_worker_50_dk_r_data_inl10_inl54 | initiator_i2c_worker_50_dk_msb_inl10_inl5); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L15_forbody52_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl10_inl54 <= (initiator_i2c_worker_50_dk_i_inl10_inl53 + 1); */
        initiator_i2c_worker_50_dk_r_data_inl10_inl53 <= initiator_i2c_worker_50_dk_r_data_inl10_inl55;
        initiator_i2c_worker_50_dk_i_inl10_inl53 <= initiator_i2c_worker_50_dk_i_inl10_inl54;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L15_fortest51_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L16_fortest26_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl1_inl2_inl4 <= (initiator_i2c_worker_50_dk_i_inl1_inl2_inl43 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl1_inl2_inl4) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl1_inl2_inl4;
          /* initiator_i2c_worker_50_dk_t897_inl1_inl2_inl4 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl43 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl44 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl43 << 1); */
          /* initiator_i2c_worker_50_dk_c5925 <= (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl4); */
          /* initiator_i2c_worker_50_dk_c2915 <= (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl4); */
          /* initiator_i2c_worker_50_dk_c898_inl1_inl2_inl4 <= (initiator_i2c_worker_50_dk_t897_inl1_inl2_inl4 == 128); */
          /* initiator_i2c_worker_50_dk_t3989 <= initiator_i2c_worker_50_dk_c898_inl1_inl2_inl4 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl1_inl2_inl4 <= initiator_i2c_worker_50_dk_t3989; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse29_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L16_forbody27_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl1_inl2_inl44 <= (initiator_i2c_worker_50_dk_i_inl1_inl2_inl43 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl43 <= initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl44;
        initiator_i2c_worker_50_dk_i_inl1_inl2_inl43 <= initiator_i2c_worker_50_dk_i_inl1_inl2_inl44;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L16_fortest26_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L17_fortest30_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl6_inl4 <= (initiator_i2c_worker_50_dk_i_inl6_inl43 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl6_inl4) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl6_inl4;
          /* initiator_i2c_worker_50_dk_t897_inl6_inl4 <= (initiator_i2c_worker_50_dk_raw_data_inl6_inl43 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl6_inl44 <= (initiator_i2c_worker_50_dk_raw_data_inl6_inl43 << 1); */
          /* initiator_i2c_worker_50_dk_c5932 <= (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl6_inl4); */
          /* initiator_i2c_worker_50_dk_c2925 <= (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl6_inl4); */
          /* initiator_i2c_worker_50_dk_c898_inl6_inl4 <= (initiator_i2c_worker_50_dk_t897_inl6_inl4 == 128); */
          /* initiator_i2c_worker_50_dk_t3990 <= initiator_i2c_worker_50_dk_c898_inl6_inl4 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl6_inl4 <= initiator_i2c_worker_50_dk_t3990; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse33_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L17_forbody31_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl6_inl44 <= (initiator_i2c_worker_50_dk_i_inl6_inl43 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl6_inl43 <= initiator_i2c_worker_50_dk_raw_data_inl6_inl44;
        initiator_i2c_worker_50_dk_i_inl6_inl43 <= initiator_i2c_worker_50_dk_i_inl6_inl44;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L17_fortest30_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L18_fortest34_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl7_inl4 <= (initiator_i2c_worker_50_dk_i_inl7_inl43 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl7_inl4) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl7_inl4;
          /* initiator_i2c_worker_50_dk_t897_inl7_inl4 <= (initiator_i2c_worker_50_dk_raw_data_inl7_inl43 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl7_inl44 <= (initiator_i2c_worker_50_dk_raw_data_inl7_inl43 << 1); */
          /* initiator_i2c_worker_50_dk_c5936 <= (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl7_inl4); */
          /* initiator_i2c_worker_50_dk_c2935 <= (initiator_i2c_worker_50_dk_c1010 && initiator_i2c_worker_50_dk_c896_inl7_inl4); */
          /* initiator_i2c_worker_50_dk_c898_inl7_inl4 <= (initiator_i2c_worker_50_dk_t897_inl7_inl4 == 128); */
          /* initiator_i2c_worker_50_dk_t3991 <= initiator_i2c_worker_50_dk_c898_inl7_inl4 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl7_inl4 <= initiator_i2c_worker_50_dk_t3991; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse37_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L18_forbody35_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl7_inl44 <= (initiator_i2c_worker_50_dk_i_inl7_inl43 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl7_inl43 <= initiator_i2c_worker_50_dk_raw_data_inl7_inl44;
        initiator_i2c_worker_50_dk_i_inl7_inl43 <= initiator_i2c_worker_50_dk_i_inl7_inl44;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L18_fortest34_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L19_fortest17_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl1_inl2_inl3 <= (initiator_i2c_worker_50_dk_i_inl1_inl2_inl33 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl1_inl2_inl3) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl1_inl2_inl3;
          /* initiator_i2c_worker_50_dk_t897_inl1_inl2_inl3 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl33 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl34 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl33 << 1); */
          /* initiator_i2c_worker_50_dk_c5924 <= (initiator_i2c_worker_50_dk_c1009 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl3); */
          /* initiator_i2c_worker_50_dk_c2914 <= (initiator_i2c_worker_50_dk_c1009 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl3); */
          /* initiator_i2c_worker_50_dk_c898_inl1_inl2_inl3 <= (initiator_i2c_worker_50_dk_t897_inl1_inl2_inl3 == 128); */
          /* initiator_i2c_worker_50_dk_t3988 <= initiator_i2c_worker_50_dk_c898_inl1_inl2_inl3 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl1_inl2_inl3 <= initiator_i2c_worker_50_dk_t3988; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse20_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L19_forbody18_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl1_inl2_inl34 <= (initiator_i2c_worker_50_dk_i_inl1_inl2_inl33 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl33 <= initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl34;
        initiator_i2c_worker_50_dk_i_inl1_inl2_inl33 <= initiator_i2c_worker_50_dk_i_inl1_inl2_inl34;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L19_fortest17_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L2_fortest94_S0: begin
        /* initiator_i2c_worker_50_dk_c886_inl10 <= (initiator_i2c_worker_50_dk_i_inl103 < initiator_i2c_worker_50_dk_t884); */
        if (initiator_i2c_worker_50_dk_c886_inl10) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_b0_inl103;
          /* initiator_i2c_worker_50_dk_b0_inl104 <= ~initiator_i2c_worker_50_dk_b0_inl103; */
          /* initiator_i2c_worker_50_dk_c5929 <= (initiator_i2c_worker_50_dk_c1014 && initiator_i2c_worker_50_dk_c886_inl10); */
          /* initiator_i2c_worker_50_dk_c2919 <= (initiator_i2c_worker_50_dk_c1014 && initiator_i2c_worker_50_dk_c886_inl10); */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S1;
        end else begin
          /* initiator_i2c_worker_50_dk_res3 <= (initiator_i2c_worker_50_dk_res2 | 64); */
          /* initiator_i2c_worker_50_dk_has_data_flag6 <= initiator_i2c_worker_50_dk_c873 ? 0 : initiator_i2c_worker_50_dk_c1009 ? 1 : initiator_i2c_worker_50_dk_c1010 ? 0 : initiator_i2c_worker_50_dk_c1011 ? 1 : initiator_i2c_worker_50_dk_c1012 ? 0 : initiator_i2c_worker_50_dk_c1013 ? 1 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? 0 : initiator_i2c_worker_50_dk_c1015 ? 0 : 'bz; */
          initiator_i2c_worker_50_dk_r_addr4 <= initiator_i2c_worker_50_dk_c873 ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_r_addr2 : initiator_i2c_worker_50_dk_c1010 ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1012 ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_r_addr3 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? initiator_i2c_worker_50_dk_r_addr4 : initiator_i2c_worker_50_dk_c1015 ? initiator_i2c_worker_50_dk_r_addr4 : 'bz;
          initiator_i2c_worker_50_dk_w_addr5 <= initiator_i2c_worker_50_dk_c873 ? initiator_i2c_worker_50_dk_w_addr2 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_w_addr5 : initiator_i2c_worker_50_dk_c1010 ? initiator_i2c_worker_50_dk_w_addr3 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_w_addr5 : initiator_i2c_worker_50_dk_c1012 ? initiator_i2c_worker_50_dk_w_addr4 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_w_addr5 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? initiator_i2c_worker_50_dk_w_addr5 : initiator_i2c_worker_50_dk_c1015 ? initiator_i2c_worker_50_dk_w_addr5 : 'bz;
          initiator_i2c_worker_50_dk_w_data5 <= initiator_i2c_worker_50_dk_c873 ? initiator_i2c_worker_50_dk_w_data2 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_w_data5 : initiator_i2c_worker_50_dk_c1010 ? initiator_i2c_worker_50_dk_w_data3 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_w_data5 : initiator_i2c_worker_50_dk_c1012 ? initiator_i2c_worker_50_dk_w_data4 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_w_data5 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? initiator_i2c_worker_50_dk_w_data5 : initiator_i2c_worker_50_dk_c1015 ? initiator_i2c_worker_50_dk_w_data5 : 'bz;
          /* initiator_i2c_worker_50_dk_c880 <= (initiator_i2c_worker_50_dk_has_data_flag6 != 0); */
          /* initiator_i2c_worker_50_dk_res4 <= initiator_i2c_worker_50_dk_c880 ? initiator_i2c_worker_50_dk_res3 : !initiator_i2c_worker_50_dk_c880 ? initiator_i2c_worker_50_dk_res2 : 'bz; */
          /* initiator_i2c_worker_50_dk_r_data6 <= initiator_i2c_worker_50_dk_c873 ? 0 : initiator_i2c_worker_50_dk_c1009 ? initiator_i2c_worker_50_dk_r_data_inl4_inl33 : initiator_i2c_worker_50_dk_c1010 ? 0 : initiator_i2c_worker_50_dk_c1011 ? initiator_i2c_worker_50_dk_r_data_inl10_inl53 : initiator_i2c_worker_50_dk_c1012 ? 0 : initiator_i2c_worker_50_dk_c1013 ? initiator_i2c_worker_50_dk_r_data_inl13_inl93 : (initiator_i2c_worker_50_dk_c1014 && !initiator_i2c_worker_50_dk_c886_inl10) ? 0 : initiator_i2c_worker_50_dk_c1015 ? 0 : 'bz; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_b13_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L2_forbody95_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl104 <= (initiator_i2c_worker_50_dk_i_inl103 + 1); */
        initiator_i2c_worker_50_dk_b0_inl103 <= initiator_i2c_worker_50_dk_b0_inl104;
        initiator_i2c_worker_50_dk_i_inl103 <= initiator_i2c_worker_50_dk_i_inl104;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L2_fortest94_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L20_fortest21_S0: begin
        /* initiator_i2c_worker_50_dk_c903_inl4_inl3 <= (initiator_i2c_worker_50_dk_i_inl4_inl33 < 8); */
        if (initiator_i2c_worker_50_dk_c903_inl4_inl3) begin
          i2c_scl_o <= 1;
          /* initiator_i2c_worker_50_dk_r_data_inl4_inl34 <= (initiator_i2c_worker_50_dk_r_data_inl4_inl33 << 1); */
          /* initiator_i2c_worker_50_dk_c5931 <= (initiator_i2c_worker_50_dk_c1009 && initiator_i2c_worker_50_dk_c903_inl4_inl3); */
          /* initiator_i2c_worker_50_dk_c2923 <= (initiator_i2c_worker_50_dk_c1009 && initiator_i2c_worker_50_dk_c903_inl4_inl3); */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S1;
        end else begin
          i2c_sda_t <= 0;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse24_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S1: begin
        initiator_i2c_worker_50_dk_msb_inl4_inl3 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S2: begin
        i2c_scl_o <= 0;
        /* initiator_i2c_worker_50_dk_r_data_inl4_inl35 <= (initiator_i2c_worker_50_dk_r_data_inl4_inl34 | initiator_i2c_worker_50_dk_msb_inl4_inl3); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L20_forbody22_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl4_inl34 <= (initiator_i2c_worker_50_dk_i_inl4_inl33 + 1); */
        initiator_i2c_worker_50_dk_r_data_inl4_inl33 <= initiator_i2c_worker_50_dk_r_data_inl4_inl35;
        initiator_i2c_worker_50_dk_i_inl4_inl33 <= initiator_i2c_worker_50_dk_i_inl4_inl34;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L20_fortest21_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L21_fortest5_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl1_inl2_inl2 <= (initiator_i2c_worker_50_dk_i_inl1_inl2_inl23 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl1_inl2_inl2) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl1_inl2_inl2;
          /* initiator_i2c_worker_50_dk_t897_inl1_inl2_inl2 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl23 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl24 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl23 << 1); */
          /* initiator_i2c_worker_50_dk_c5923 <= (initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl2); */
          /* initiator_i2c_worker_50_dk_c2913 <= (initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl2); */
          /* initiator_i2c_worker_50_dk_c898_inl1_inl2_inl2 <= (initiator_i2c_worker_50_dk_t897_inl1_inl2_inl2 == 128); */
          /* initiator_i2c_worker_50_dk_t3986 <= initiator_i2c_worker_50_dk_c898_inl1_inl2_inl2 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl1_inl2_inl2 <= initiator_i2c_worker_50_dk_t3986; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse8_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L21_forbody6_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl1_inl2_inl24 <= (initiator_i2c_worker_50_dk_i_inl1_inl2_inl23 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl23 <= initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl24;
        initiator_i2c_worker_50_dk_i_inl1_inl2_inl23 <= initiator_i2c_worker_50_dk_i_inl1_inl2_inl24;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L21_fortest5_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L22_fortest9_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl5_inl2 <= (initiator_i2c_worker_50_dk_i_inl5_inl23 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl5_inl2) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl5_inl2;
          /* initiator_i2c_worker_50_dk_t897_inl5_inl2 <= (initiator_i2c_worker_50_dk_raw_data_inl5_inl23 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl5_inl24 <= (initiator_i2c_worker_50_dk_raw_data_inl5_inl23 << 1); */
          /* initiator_i2c_worker_50_dk_c5930 <= (initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c896_inl5_inl2); */
          /* initiator_i2c_worker_50_dk_c2921 <= (initiator_i2c_worker_50_dk_c873 && initiator_i2c_worker_50_dk_c896_inl5_inl2); */
          /* initiator_i2c_worker_50_dk_c898_inl5_inl2 <= (initiator_i2c_worker_50_dk_t897_inl5_inl2 == 128); */
          /* initiator_i2c_worker_50_dk_t3987 <= initiator_i2c_worker_50_dk_c898_inl5_inl2 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl5_inl2 <= initiator_i2c_worker_50_dk_t3987; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse12_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L22_forbody10_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl5_inl24 <= (initiator_i2c_worker_50_dk_i_inl5_inl23 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl5_inl23 <= initiator_i2c_worker_50_dk_raw_data_inl5_inl24;
        initiator_i2c_worker_50_dk_i_inl5_inl23 <= initiator_i2c_worker_50_dk_i_inl5_inl24;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L22_fortest9_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L3_fortest73_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl1_inl3_inl9 <= (initiator_i2c_worker_50_dk_i_inl1_inl3_inl93 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl1_inl3_inl9) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl1_inl3_inl9;
          /* initiator_i2c_worker_50_dk_t897_inl1_inl3_inl9 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl93 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl94 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl93 << 1); */
          /* initiator_i2c_worker_50_dk_c5928 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl1_inl3_inl9); */
          /* initiator_i2c_worker_50_dk_c2918 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl1_inl3_inl9); */
          /* initiator_i2c_worker_50_dk_c898_inl1_inl3_inl9 <= (initiator_i2c_worker_50_dk_t897_inl1_inl3_inl9 == 128); */
          /* initiator_i2c_worker_50_dk_t3999 <= initiator_i2c_worker_50_dk_c898_inl1_inl3_inl9 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl1_inl3_inl9 <= initiator_i2c_worker_50_dk_t3999; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse76_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L3_forbody74_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl1_inl3_inl94 <= (initiator_i2c_worker_50_dk_i_inl1_inl3_inl93 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl93 <= initiator_i2c_worker_50_dk_raw_data_inl1_inl3_inl94;
        initiator_i2c_worker_50_dk_i_inl1_inl3_inl93 <= initiator_i2c_worker_50_dk_i_inl1_inl3_inl94;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L3_fortest73_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L4_fortest77_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl9_inl9 <= (initiator_i2c_worker_50_dk_i_inl9_inl93 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl9_inl9) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl9_inl9;
          /* initiator_i2c_worker_50_dk_t897_inl9_inl9 <= (initiator_i2c_worker_50_dk_raw_data_inl9_inl93 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl9_inl94 <= (initiator_i2c_worker_50_dk_raw_data_inl9_inl93 << 1); */
          /* initiator_i2c_worker_50_dk_c5935 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl9_inl9); */
          /* initiator_i2c_worker_50_dk_c2931 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl9_inl9); */
          /* initiator_i2c_worker_50_dk_c898_inl9_inl9 <= (initiator_i2c_worker_50_dk_t897_inl9_inl9 == 128); */
          /* initiator_i2c_worker_50_dk_t4000 <= initiator_i2c_worker_50_dk_c898_inl9_inl9 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl9_inl9 <= initiator_i2c_worker_50_dk_t4000; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse80_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L4_forbody78_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl9_inl94 <= (initiator_i2c_worker_50_dk_i_inl9_inl93 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl9_inl93 <= initiator_i2c_worker_50_dk_raw_data_inl9_inl94;
        initiator_i2c_worker_50_dk_i_inl9_inl93 <= initiator_i2c_worker_50_dk_i_inl9_inl94;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L4_fortest77_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L5_fortest81_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl10_inl9 <= (initiator_i2c_worker_50_dk_i_inl10_inl93 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl10_inl9) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl10_inl9;
          /* initiator_i2c_worker_50_dk_t897_inl10_inl9 <= (initiator_i2c_worker_50_dk_raw_data_inl10_inl93 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl10_inl94 <= (initiator_i2c_worker_50_dk_raw_data_inl10_inl93 << 1); */
          /* initiator_i2c_worker_50_dk_c5939 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl10_inl9); */
          /* initiator_i2c_worker_50_dk_c2941 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl10_inl9); */
          /* initiator_i2c_worker_50_dk_c898_inl10_inl9 <= (initiator_i2c_worker_50_dk_t897_inl10_inl9 == 128); */
          /* initiator_i2c_worker_50_dk_t4001 <= initiator_i2c_worker_50_dk_c898_inl10_inl9 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl10_inl9 <= initiator_i2c_worker_50_dk_t4001; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse84_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L5_forbody82_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl10_inl94 <= (initiator_i2c_worker_50_dk_i_inl10_inl93 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl10_inl93 <= initiator_i2c_worker_50_dk_raw_data_inl10_inl94;
        initiator_i2c_worker_50_dk_i_inl10_inl93 <= initiator_i2c_worker_50_dk_i_inl10_inl94;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L5_fortest81_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L6_fortest85_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl1_inl4_inl9 <= (initiator_i2c_worker_50_dk_i_inl1_inl4_inl93 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl1_inl4_inl9) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl1_inl4_inl9;
          /* initiator_i2c_worker_50_dk_t897_inl1_inl4_inl9 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl93 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl94 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl93 << 1); */
          /* initiator_i2c_worker_50_dk_c5942 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl1_inl4_inl9); */
          /* initiator_i2c_worker_50_dk_c2948 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c896_inl1_inl4_inl9); */
          /* initiator_i2c_worker_50_dk_c898_inl1_inl4_inl9 <= (initiator_i2c_worker_50_dk_t897_inl1_inl4_inl9 == 128); */
          /* initiator_i2c_worker_50_dk_t4002 <= initiator_i2c_worker_50_dk_c898_inl1_inl4_inl9 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl1_inl4_inl9 <= initiator_i2c_worker_50_dk_t4002; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse88_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L6_forbody86_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl1_inl4_inl94 <= (initiator_i2c_worker_50_dk_i_inl1_inl4_inl93 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl93 <= initiator_i2c_worker_50_dk_raw_data_inl1_inl4_inl94;
        initiator_i2c_worker_50_dk_i_inl1_inl4_inl93 <= initiator_i2c_worker_50_dk_i_inl1_inl4_inl94;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L6_fortest85_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L7_fortest89_S0: begin
        /* initiator_i2c_worker_50_dk_c903_inl13_inl9 <= (initiator_i2c_worker_50_dk_i_inl13_inl93 < 8); */
        if (initiator_i2c_worker_50_dk_c903_inl13_inl9) begin
          i2c_scl_o <= 1;
          /* initiator_i2c_worker_50_dk_r_data_inl13_inl94 <= (initiator_i2c_worker_50_dk_r_data_inl13_inl93 << 1); */
          /* initiator_i2c_worker_50_dk_c5943 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c903_inl13_inl9); */
          /* initiator_i2c_worker_50_dk_c2952 <= (initiator_i2c_worker_50_dk_c1013 && initiator_i2c_worker_50_dk_c903_inl13_inl9); */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S1;
        end else begin
          i2c_sda_t <= 0;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse92_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S1: begin
        initiator_i2c_worker_50_dk_msb_inl13_inl9 <= i2c_sda_i;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S2: begin
        i2c_scl_o <= 0;
        /* initiator_i2c_worker_50_dk_r_data_inl13_inl95 <= (initiator_i2c_worker_50_dk_r_data_inl13_inl94 | initiator_i2c_worker_50_dk_msb_inl13_inl9); */
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L7_forbody90_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl13_inl94 <= (initiator_i2c_worker_50_dk_i_inl13_inl93 + 1); */
        initiator_i2c_worker_50_dk_r_data_inl13_inl93 <= initiator_i2c_worker_50_dk_r_data_inl13_inl95;
        initiator_i2c_worker_50_dk_i_inl13_inl93 <= initiator_i2c_worker_50_dk_i_inl13_inl94;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L7_fortest89_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L8_fortest56_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl1_inl2_inl8 <= (initiator_i2c_worker_50_dk_i_inl1_inl2_inl83 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl1_inl2_inl8) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl1_inl2_inl8;
          /* initiator_i2c_worker_50_dk_t897_inl1_inl2_inl8 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl83 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl84 <= (initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl83 << 1); */
          /* initiator_i2c_worker_50_dk_c5927 <= (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl8); */
          /* initiator_i2c_worker_50_dk_c2917 <= (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl1_inl2_inl8); */
          /* initiator_i2c_worker_50_dk_c898_inl1_inl2_inl8 <= (initiator_i2c_worker_50_dk_t897_inl1_inl2_inl8 == 128); */
          /* initiator_i2c_worker_50_dk_t3995 <= initiator_i2c_worker_50_dk_c898_inl1_inl2_inl8 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl1_inl2_inl8 <= initiator_i2c_worker_50_dk_t3995; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse59_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L8_forbody57_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl1_inl2_inl84 <= (initiator_i2c_worker_50_dk_i_inl1_inl2_inl83 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl83 <= initiator_i2c_worker_50_dk_raw_data_inl1_inl2_inl84;
        initiator_i2c_worker_50_dk_i_inl1_inl2_inl83 <= initiator_i2c_worker_50_dk_i_inl1_inl2_inl84;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L8_fortest56_S0;
      end
      ov5640_initiator_i2c_worker_50_dk_L9_fortest60_S0: begin
        /* initiator_i2c_worker_50_dk_c896_inl7_inl8 <= (initiator_i2c_worker_50_dk_i_inl7_inl83 < 8); */
        if (initiator_i2c_worker_50_dk_c896_inl7_inl8) begin
          i2c_sda_o <= initiator_i2c_worker_50_dk_msb_inl7_inl8;
          /* initiator_i2c_worker_50_dk_t897_inl7_inl8 <= (initiator_i2c_worker_50_dk_raw_data_inl7_inl83 & 128); */
          /* initiator_i2c_worker_50_dk_raw_data_inl7_inl84 <= (initiator_i2c_worker_50_dk_raw_data_inl7_inl83 << 1); */
          /* initiator_i2c_worker_50_dk_c5934 <= (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl7_inl8); */
          /* initiator_i2c_worker_50_dk_c2929 <= (initiator_i2c_worker_50_dk_c1012 && initiator_i2c_worker_50_dk_c896_inl7_inl8); */
          /* initiator_i2c_worker_50_dk_c898_inl7_inl8 <= (initiator_i2c_worker_50_dk_t897_inl7_inl8 == 128); */
          /* initiator_i2c_worker_50_dk_t3996 <= initiator_i2c_worker_50_dk_c898_inl7_inl8 ? 1 : 0; */
          /* initiator_i2c_worker_50_dk_msb_inl7_inl8 <= initiator_i2c_worker_50_dk_t3996; */
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S1;
        end else begin
          i2c_sda_t <= 1;
          initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L1_forelse63_S1;
        end
      end
      ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S1: begin
        i2c_scl_o <= 1;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S2;
      end
      ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S2: begin
        i2c_scl_o <= 0;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S3;
      end
      ov5640_initiator_i2c_worker_50_dk_L9_forbody61_S3: begin
        /* initiator_i2c_worker_50_dk_i_inl7_inl84 <= (initiator_i2c_worker_50_dk_i_inl7_inl83 + 1); */
        initiator_i2c_worker_50_dk_raw_data_inl7_inl83 <= initiator_i2c_worker_50_dk_raw_data_inl7_inl84;
        initiator_i2c_worker_50_dk_i_inl7_inl83 <= initiator_i2c_worker_50_dk_i_inl7_inl84;
        initiator_i2c_worker_50_dk_state <= ov5640_initiator_i2c_worker_50_dk_L9_fortest60_S0;
      end
      endcase
    end
  end
  

endmodule


module top(
	input                       clk,
	input                       rst_n,
	inout                       cmos_scl,          //cmos i2c clock
	inout                       cmos_sda,          //cmos i2c data
	input                       cmos_vsync,        //cmos vsync
	input                       cmos_href,         //cmos hsync refrence,data valid
	input                       cmos_pclk,         //cmos pxiel clock
    output                      cmos_xclk,         //cmos externl clock 
	input   [7:0]               cmos_db,           //cmos data
	output                      cmos_rst_n,        //cmos reset 
	output                      cmos_pwdn,         //cmos power down
	
	output [5:0] 				led6_n,
    output                      scl,
    output                      sda,
    output                      xclk,         //cmos externl clock 

	output [14-1:0]             ddr_addr,       //ROW_WIDTH=14
	output [3-1:0]              ddr_bank,       //BANK_WIDTH=3
	output                      ddr_cs,
	output                      ddr_ras,
	output                      ddr_cas,
	output                      ddr_we,
	output                      ddr_ck,
	output                      ddr_ck_n,
	output                      ddr_cke,
	output                      ddr_odt,
	output                      ddr_reset_n,
	output [2-1:0]              ddr_dm,         //DM_WIDTH=2
	inout [16-1:0]              ddr_dq,         //DQ_WIDTH=16
	inout [2-1:0]               ddr_dqs,        //DQS_WIDTH=2
	inout [2-1:0]               ddr_dqs_n,      //DQS_WIDTH=2

	output                      lcd_dclk,	
	output                      lcd_hs,            //lcd horizontal synchronization
	output                      lcd_vs,            //lcd vertical synchronization        
	output                      lcd_de,            //lcd data enable     
	output[4:0]                 lcd_r,             //lcd red
	output[5:0]                 lcd_g,             //lcd green
	output[4:0]                 lcd_b	           //lcd blue
);

//memory interface
wire                   memory_clk         ;
wire                   dma_clk         	  ;
wire                   pll_lock           ;
wire                   cmd_ready          ;
wire[2:0]              cmd                ;
wire                   cmd_en             ;
wire[5:0]              app_burst_number   ;
wire[ADDR_WIDTH-1:0]   addr               ;
wire                   wr_data_rdy        ;
wire                   wr_data_en         ;//
wire                   wr_data_end        ;//
wire[DATA_WIDTH-1:0]   wr_data            ;   
wire[DATA_WIDTH/8-1:0] wr_data_mask       ;   
wire                   rd_data_valid      ;  
wire                   rd_data_end        ;//unused 
wire[DATA_WIDTH-1:0]   rd_data            ;   
wire                   init_calib_complete;

//According to IP parameters to choose
`define	    WR_VIDEO_WIDTH_16
`define	DEF_WR_VIDEO_WIDTH 16

`define	    RD_VIDEO_WIDTH_16
`define	DEF_RD_VIDEO_WIDTH 16

`define	USE_THREE_FRAME_BUFFER

`define	DEF_ADDR_WIDTH 28 
`define	DEF_SRAM_DATA_WIDTH 128
//
//=========================================================
//SRAM parameters
parameter ADDR_WIDTH          = `DEF_ADDR_WIDTH;    //存储单元是byte，总容量=2^27*16bit = 2Gbit,增加1位rank地址，{rank[0],bank[2:0],row[13:0],cloumn[9:0]}
parameter DATA_WIDTH          = `DEF_SRAM_DATA_WIDTH;   //与生成DDR3IP有关，此ddr3 2Gbit, x16， 时钟比例1:4 ，则固定128bit
parameter WR_VIDEO_WIDTH      = `DEF_WR_VIDEO_WIDTH;  
parameter RD_VIDEO_WIDTH      = `DEF_RD_VIDEO_WIDTH;  

wire                            video_clk;         //video pixel clock
//-------------------
//syn_code
wire                      syn_off0_re;  // ofifo read enable signal
wire                      syn_off0_vs;
wire                      syn_off0_hs;
                          
wire                      off0_syn_de  ;
wire [RD_VIDEO_WIDTH-1:0] off0_syn_data;

wire[15:0]                      cmos_16bit_data;
wire                            cmos_16bit_clk;
wire[15:0] 						write_data;

wire[9:0]                       lut_index;
wire[31:0]                      lut_data;

wire cmos_clk;
wire cmos_clk12M;
assign xclk = cmos_clk12M;
assign cmos_xclk = cmos_clk12M;
assign cmos_pwdn = 1'b0;
assign cmos_rst_n = 1'b1;
assign write_data = {cmos_16bit_data[4:0],cmos_16bit_data[10:5],cmos_16bit_data[15:11]};

//状态指示灯
// assign state_led[3] = 
// assign state_led[2] = 
//assign state_led[1] = rst_n; //复位指示灯
//assign state_led[0] = init_calib_complete; //DDR3初始化指示灯

reg [31:0] old_saved_b_counter;
reg [31:0] saved_b_counter;
reg [31:0] diff_b_counter;
reg [31:0] b_counter;
reg [31:0] c_counter;
localparam CLK27M = 'd27_000_000;
localparam CLK48M = 'd480_000_000;
reg clk48m_led;
always@(posedge clk) begin
    if ( c_counter == (CLK27M - 1)) begin
        c_counter <= 'd0;
        old_saved_b_counter <= saved_b_counter;
        saved_b_counter <= b_counter;
    end else begin
        if ( c_counter == 'd0) begin
            if ( saved_b_counter > old_saved_b_counter ) begin
                diff_b_counter <= saved_b_counter - old_saved_b_counter;
            end
        end
        c_counter <= c_counter + 'd1;
    end
end

always@(posedge cmos_pclk) begin
    b_counter <= b_counter + 'd1;
end

//assign state_led[2] = clk48m_led;
//assign state_led = saved_b_counter[31:27];
//assign state_led = diff_b_counter[31:28];
//assign state_led = diff_b_counter[27:24];
//assign state_led = diff_b_counter[23:20];

//generate the CMOS sensor clock and the SDRAM controller clock
sys_pll sys_pll_m0(
	.clkin                     (cmos_clk                  ),
	.clkout                    (video_clk 	              )
	);
cmos_pll cmos_pll_m0(
	.clkin                     (clk                      		),
	.clkout                    (cmos_clk 	              		),
    .clkoutd                   (cmos_clk12M                     )
	);

mem_pll mem_pll_m0(
	.clkin                     (cmos_clk                        ),
	.clkout                    (memory_clk 	              		),
	.lock 					   (pll_lock 						)
	);

//I2C master controller
//`define USE_ORIGNAL_I2C_CONFIG
`ifdef USE_ORIGNAL_I2C_CONFIG
i2c_config i2c_config_m0(
	.rst                        (~rst_n                   ),
	.clk                        (clk                      ),
	.clk_div_cnt                (16'd500                  ),
	.i2c_addr_2byte             (1'b1                     ),
	.lut_index                  (lut_index                ),
	.lut_dev_addr               (lut_data[31:24]          ),
	.lut_reg_addr               (lut_data[23:8]           ),
	.lut_reg_data               (lut_data[7:0]            ),
	.error                      (                         ),
	.done                       (                         ),
	.i2c_scl                    (cmos_scl                 ),
	.i2c_sda                    (cmos_sda                 ),
    .scl(scl),
    .sda(sda)
);
//configure look-up table
lut_ov5640_rgb565_480_272 lut_ov5640_rgb565_480_272_m0(
	.lut_index                  (lut_index                ),
	.lut_data                   (lut_data                 )
);
//CMOS sensor 8bit data is converted to 16bit data
`else
wire i2c_scl_o;
wire i2c_scl_t;
wire i2c_scl_i;

wire i2c_sda_o;
wire i2c_sda_t;
wire i2c_sda_i;

wire i2c_clk;
reg [9:0] i2c_clk_divider = 10'd0;
reg once_reset = 1'b1;
assign i2c_clk = i2c_clk_divider[9];

always @(posedge clk) begin
    i2c_clk_divider <= i2c_clk_divider + 10'd1;

    if (i2c_clk_divider[7] == 1'b1) begin
        once_reset <= 1'b0;
    end
end

wire [7:0] debug_print_pin;
assign led6_n = ~debug_print_pin[5:0];

ov5640_initiator ov5640_initiator0 (
    .clk(i2c_clk),
    .rst(once_reset),

    .resend(1'b0),

    .i2c_scl_i(i2c_scl_i),
    .i2c_scl_o(i2c_scl_o),
    .i2c_scl_t(i2c_scl_t),

    .i2c_sda_i(i2c_sda_i),
    .i2c_sda_o(i2c_sda_o),
    .i2c_sda_t(i2c_sda_t),

    .done(),
    .debug_print_pin(debug_print_pin)
);

assign scl = i2c_scl_i;
assign sda = i2c_sda_i;

IOBUF scl_iobuf(
    .O(i2c_scl_i),
    .IO(cmos_scl),
    .I(i2c_scl_o),
    .OEN(i2c_scl_t)
);

IOBUF sda_iobuf(
    .O(i2c_sda_i),
    .IO(cmos_sda),
    .I(i2c_sda_o),
    .OEN(i2c_sda_t)
);
`endif

wire[15:0]                      cmos_16bit_data_m0;
wire                            cmos_16bit_clk_m0;
wire cmos_16bit_wr_m0;
cmos_8_16bit cmos_8_16bit_m0(
	.rst                        (~rst_n                   ),
	.pclk                       (cmos_pclk                ),
	.pdata_i                    (cmos_db                  ),
	.de_i                       (cmos_href                ),
	.pdata_o                    (cmos_16bit_data_m0       ),
	.hblank                     (cmos_16bit_wr_m0         ),
	.de_o                       (cmos_16bit_clk_m0        )
);

wire cmos_16bit_wr;
reg [7:0] cam_data8;
reg cam_de;

//assign cmos_16bit_data = {cmos_db[7:3], cmos_db[7:2], cmos_db[7:3]};
//assign cmos_16bit_data = {5'b00000, 6'b111111, 5'b00000};
//assign cmos_16bit_data = {cam_data8[7:3], cam_data8[7:2], cam_data8[7:3]};
//assign cmos_16bit_data = {hcount[9:7] ,2'b0 , hcount[5:0], 5'b0};
//assign cmos_16bit_data = {6'd0, hcount};
//assign cmos_16bit_wr = cmos_href_d;
//assign cmos_16bit_clk = cmos_pclk;

//assign cmos_16bit_data = cmos_16bit_data_m0;
//assign cmos_16bit_wr = cmos_16bit_wr_m0;
assign cmos_16bit_clk = cmos_16bit_clk_m0;

reg cmos_href_d;
reg [9:0] hcount;
always@(posedge cmos_pclk) 
begin
    cam_data8 <= cmos_db;
    cam_de <= cmos_href;

    if ( cmos_href_d & ~cmos_href ) begin
        hcount <= 10'd0;
        cam_de <= 1'b0;
    end else if ( cmos_href ) begin
        //cam_data8 <= hcount[7:0];
        if ( hcount == 10'd479 ) begin
            cam_de <= 1'b0;
        end else begin
            hcount <= hcount + 10'd1;
            cam_de <= 1'b1;
        end
    end

    cmos_href_d <= cmos_href;
end

//----------------------------------------------------------------
localparam BW_DATA_WIDTH = 7;
logic lb_de_w;

logic [BW_DATA_WIDTH-1:0] lb_data0_w;
logic [BW_DATA_WIDTH-1:0] lb_data1_w;
logic [BW_DATA_WIDTH-1:0] lb_data2_w;

logic [BW_DATA_WIDTH-1:0] lb_data_i;

assign lb_data_i = 
        {1'b0, ({1'b0, cmos_16bit_data_m0[15:11]} + {1'b0, cmos_16bit_data_m0[4:0]})} + 
        {1'b0, cmos_16bit_data_m0[10:5]};

logic [15:0] my_data_r;
logic do_red = ( my_data_r == cmos_16bit_data_m0 )?1:0;
always @(posedge cmos_16bit_clk_m0) begin
    my_data_r <= cmos_16bit_data_m0;
end

linebuffer #(
    .DATA_WIDTH(BW_DATA_WIDTH),
    .MAX_DATA_LENGTH(480)
) linebuffer0 (
    .clk(cmos_16bit_clk_m0),

    .vsync_i(cmos_vsync),
    .de_i(cmos_16bit_wr_m0),
    .data_i(lb_data_i),

    .de_o(lb_de_w),
    .data0_o(lb_data0_w),
    .data1_o(lb_data1_w),
    .data2_o(lb_data2_w)
);

/*
assign cmos_16bit_data = {
    lb_data1_w[BW_DATA_WIDTH-1:BW_DATA_WIDTH-5],
    lb_data1_w[BW_DATA_WIDTH-1:BW_DATA_WIDTH-6],
    lb_data1_w[BW_DATA_WIDTH-1:BW_DATA_WIDTH-5]};
assign cmos_16bit_wr = lb_de_w;
*/


logic f33_de;
logic [BW_DATA_WIDTH-1:0] f33_data;

edge_filter3x3 
#(
    .DATA_WIDTH(BW_DATA_WIDTH)
)
filter3x3_0 (
    .clk(cmos_16bit_clk_m0),

    .vsync_i(cmos_vsync),
    .de_i(lb_de_w),
    .data0_i(lb_data0_w),
    .data1_i(lb_data1_w),
    .data2_i(lb_data2_w),

    .de_o(f33_de),
    .data_o(f33_data)
);

/*
assign cmos_16bit_data = {
    f33_data[BW_DATA_WIDTH-1:BW_DATA_WIDTH-5],
    f33_data[BW_DATA_WIDTH-1:BW_DATA_WIDTH-6],
    f33_data[BW_DATA_WIDTH-1:BW_DATA_WIDTH-5]};
*/
assign cmos_16bit_wr = f33_de;

assign cmos_16bit_data = 
    (f33_data[BW_DATA_WIDTH-1:BW_DATA_WIDTH-2] == 2'b00)?
    cmos_16bit_data_m0:
    {f33_data[BW_DATA_WIDTH-1:BW_DATA_WIDTH-5],
     f33_data[BW_DATA_WIDTH-1:BW_DATA_WIDTH-6],
     f33_data[BW_DATA_WIDTH-1:BW_DATA_WIDTH-5]};

//The video output timing generator and generate a frame read data request
wire out_de;
syn_gen syn_gen_inst
(                                   
    .I_pxl_clk   (video_clk       ),//9Mhz    //32Mhz    //40MHz      //65MHz      //74.25MHz    //148.5
    .I_rst_n     (rst_n           ),//480x272 //800x480  //800x600    //1024x768   //1280x720    //1920x1080    
    .I_h_total   (16'd525         ),//16'd525 //16'd1056 // 16'd1056  // 16'd1344  // 16'd1650   // 16'd2200  
    .I_h_sync    (16'd41          ),//16'd41  //16'd128  // 16'd128   // 16'd136   // 16'd40     // 16'd44   
    .I_h_bporch  (16'd2           ),//16'd2   //16'd88   // 16'd88    // 16'd160   // 16'd220    // 16'd148   
    .I_h_res     (16'd480         ),//16'd480 //16'd800  // 16'd800   // 16'd1024  // 16'd1280   // 16'd1920  
    .I_v_total   (16'd284         ),//16'd284 //16'd505  // 16'd628   // 16'd806   // 16'd750    // 16'd1125   
    .I_v_sync    (16'd10          ),//16'd10  //16'd3    // 16'd4     // 16'd6     // 16'd5      // 16'd5      
    .I_v_bporch  (16'd2           ),//16'd2   //16'd21   // 16'd23    // 16'd29    // 16'd20     // 16'd36      
    .I_v_res     (16'd272         ),//16'd272 //16'd480  // 16'd600   // 16'd768   // 16'd720    // 16'd1080   
    .I_rd_hres   (16'd480         ),
    .I_rd_vres   (16'd272         ),
    .I_hs_pol    (1'b1            ),//HS polarity , 0:负极性，1：正极性
    .I_vs_pol    (1'b1            ),//VS polarity , 0:负极性，1：正极性
    .O_rden      (syn_off0_re     ),
    .O_de        (out_de          ),   
    .O_hs        (syn_off0_hs     ),
    .O_vs        (syn_off0_vs     )
);

/*//测试图
//--------------------------
wire        tp0_vs_in  ;
wire        tp0_hs_in  ;
wire        tp0_de_in ;
wire [ 7:0] tp0_data_r;
wire [ 7:0] tp0_data_g;
wire [ 7:0] tp0_data_b;
testpattern testpattern_inst
(
    .I_pxl_clk   (video_clk              ),//pixel clock
    .I_rst_n     (rst_n             ),//low active 
    .I_mode      (3'b000 ),//data select
    .I_single_r  (8'd255               ),
    .I_single_g  (8'd255             ),
    .I_single_b  (8'd255               ),                  //800x600    //1024x768   //1280x720   //1920x1080 
    .I_h_total   (16'd1056        ),//hor total time  // 12'd1056  // 12'd1344  // 12'd1650  // 12'd2200
    .I_h_sync    (16'd128         ),//hor sync time   // 12'd128   // 12'd136   // 12'd40    // 12'd44  
    .I_h_bporch  (16'd88          ),//hor back porch  // 12'd88    // 12'd160   // 12'd220   // 12'd148 
    .I_h_res     (16'd800         ),//hor resolution  // 12'd800   // 12'd1024  // 12'd1280  // 12'd1920
    .I_v_total   (16'd628         ),//ver total time  // 12'd628   // 12'd806   // 12'd750   // 12'd1125 
    .I_v_sync    (16'd4           ),//ver sync time   // 12'd4     // 12'd6     // 12'd5     // 12'd5   
    .I_v_bporch  (16'd23          ),//ver back porch  // 12'd23    // 12'd29    // 12'd20    // 12'd36  
    .I_v_res     (16'd600         ),//ver resolution  // 12'd600   // 12'd768   // 12'd720   // 12'd1080 
    .I_hs_pol    (1'b1               ),//0,负极性;1,正极性
    .I_vs_pol    (1'b1               ),//0,负极性;1,正极性
    .O_de        (tp0_de_in          ),   
    .O_hs        (tp0_hs_in          ),
    .O_vs        (tp0_vs_in          ),
    .O_data_r    (tp0_data_r         ),   
    .O_data_g    (tp0_data_g         ),
    .O_data_b    (tp0_data_b         )
);*/

Video_Frame_Buffer_Top Video_Frame_Buffer_Top_inst
( 
    .I_rst_n              (init_calib_complete ),//rst_n            ),
    .I_dma_clk            (dma_clk          ),   //sram_clk         ),
`ifdef USE_THREE_FRAME_BUFFER 
    .I_wr_halt            (1'd0             ), //1:halt,  0:no halt
    .I_rd_halt            (1'd0             ), //1:halt,  0:no halt
`endif
    // video data input             
    .I_vin0_clk           (cmos_16bit_clk   ),
    .I_vin0_vs_n          (~cmos_vsync      ),//只接收负极性
    .I_vin0_de            (cmos_16bit_wr    ),
    .I_vin0_data          (cmos_16bit_data  ),
    .O_vin0_fifo_full     (                 ),
    // video data output            
    .I_vout0_clk          (video_clk        ),
    .I_vout0_vs_n         (~syn_off0_vs     ),//只接收负极性
    .I_vout0_de           (syn_off0_re      ),
    .O_vout0_den          (off0_syn_de      ),
    .O_vout0_data         (off0_syn_data    ),
    .O_vout0_fifo_empty   (                 ),
    // ddr write request
    .I_cmd_ready          (cmd_ready          ),
    .O_cmd                (cmd                ),//0:write;  1:read
    .O_cmd_en             (cmd_en             ),
    .O_app_burst_number   (app_burst_number   ),
    .O_addr               (addr               ),//[ADDR_WIDTH-1:0]
    .I_wr_data_rdy        (wr_data_rdy        ),
    .O_wr_data_en         (wr_data_en         ),//
    .O_wr_data_end        (wr_data_end        ),//
    .O_wr_data            (wr_data            ),//[DATA_WIDTH-1:0]
    .O_wr_data_mask       (wr_data_mask       ),
    .I_rd_data_valid      (rd_data_valid      ),
    .I_rd_data_end        (rd_data_end        ),//unused 
    .I_rd_data            (rd_data            ),//[DATA_WIDTH-1:0]
    .I_init_calib_complete(init_calib_complete)
); 


localparam N = 7; //delay N clocks
                          
reg  [N-1:0]  Pout_hs_dn   ;
reg  [N-1:0]  Pout_vs_dn   ;
reg  [N-1:0]  Pout_de_dn   ;

always@(posedge video_clk or negedge rst_n)
begin
    if(!rst_n)
        begin                          
            Pout_hs_dn  <= {N{1'b1}};
            Pout_vs_dn  <= {N{1'b1}}; 
            Pout_de_dn  <= {N{1'b0}}; 
        end
    else 
        begin                          
            Pout_hs_dn  <= {Pout_hs_dn[N-2:0],syn_off0_hs};
            Pout_vs_dn  <= {Pout_vs_dn[N-2:0],syn_off0_vs}; 
            Pout_de_dn  <= {Pout_de_dn[N-2:0],out_de}; 
        end
end

//---------------------------------------------
`ifdef RD_VIDEO_WIDTH_16     
    assign {lcd_r,lcd_g,lcd_b}    = off0_syn_de ? off0_syn_data[15:0] : 16'h0000;//{r,g,b}
    assign lcd_vs      			  = Pout_vs_dn[4];//syn_off0_vs;
    assign lcd_hs      			  = Pout_hs_dn[4];//syn_off0_hs;
    assign lcd_de      			  = Pout_de_dn[4];//off0_syn_de;
    assign lcd_dclk    			  = video_clk;//video_clk_phs;
`endif

`ifdef RD_VIDEO_WIDTH_24 
    assign {lcd_r,lcd_g,lcd_b}    = off0_syn_de ? off0_syn_data[23:0] : 24'h0000;//{r,g,b}
    assign lcd_vs      			  = Pout_vs_dn[4];//syn_off0_vs;
    assign lcd_hs      			  = Pout_hs_dn[4];//syn_off0_hs;
    assign lcd_de      			  = Pout_de_dn[4];//off0_syn_de;
    assign lcd_dclk    			  = video_clk;//video_clk_phs;
`endif

`ifdef RD_VIDEO_WIDTH_32 
    assign {lcd_r,lcd_g,lcd_b}    = off0_syn_de ? off0_syn_data[23:0] : 24'h0000;//{r,g,b}
    assign lcd_vs      			  = Pout_vs_dn[4];//syn_off0_vs;
    assign lcd_hs      			  = Pout_hs_dn[4];//syn_off0_hs;
    assign lcd_de      			  = Pout_de_dn[4];//off0_syn_de;
    assign lcd_dclk    			  = video_clk;//video_clk_phs;
`endif

DDR3MI DDR3_Memory_Interface_Top_inst 
(
    .clk                (video_clk          ),
    .memory_clk         (memory_clk         ),
    .pll_lock           (pll_lock           ),
    .rst_n              (rst_n              ), //rst_n
    .app_burst_number   (app_burst_number   ),
    .cmd_ready          (cmd_ready          ),
    .cmd                (cmd                ),
    .cmd_en             (cmd_en             ),
    .addr               (addr               ),
    .wr_data_rdy        (wr_data_rdy        ),
    .wr_data            (wr_data            ),
    .wr_data_en         (wr_data_en         ),
    .wr_data_end        (wr_data_end        ),
    .wr_data_mask       (wr_data_mask       ),
    .rd_data            (rd_data            ),
    .rd_data_valid      (rd_data_valid      ),
    .rd_data_end        (rd_data_end        ),
    .sr_req             (1'b0               ),
    .ref_req            (1'b0               ),
    .sr_ack             (                   ),
    .ref_ack            (                   ),
    .init_calib_complete(init_calib_complete),
    .clk_out            (dma_clk            ),
    .burst              (1'b1               ),
    // mem interface
    .ddr_rst            (                 ),
    .O_ddr_addr         (ddr_addr         ),
    .O_ddr_ba           (ddr_bank         ),
    .O_ddr_cs_n         (ddr_cs         ),
    .O_ddr_ras_n        (ddr_ras        ),
    .O_ddr_cas_n        (ddr_cas        ),
    .O_ddr_we_n         (ddr_we         ),
    .O_ddr_clk          (ddr_ck          ),
    .O_ddr_clk_n        (ddr_ck_n        ),
    .O_ddr_cke          (ddr_cke          ),
    .O_ddr_odt          (ddr_odt          ),
    .O_ddr_reset_n      (ddr_reset_n      ),
    .O_ddr_dqm          (ddr_dm           ),
    .IO_ddr_dq          (ddr_dq           ),
    .IO_ddr_dqs         (ddr_dqs          ),
    .IO_ddr_dqs_n       (ddr_dqs_n        )
);

endmodule

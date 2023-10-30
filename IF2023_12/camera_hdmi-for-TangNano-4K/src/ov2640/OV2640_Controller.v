module OV2640_Controller (
    input clk,                              // 50Mhz clock signal
    input resend,                           // Reset signal
    output config_finished,                 // Flag to indicate that the configuration is finished
    output sioc,                            // SCCB interface - clock signal
    inout siod,                             // SCCB interface - data signal
    output reset,                           // RESET signal for OV2640
    output pwdn                             // PWDN signal for OV2640
);

    // Internal signals
    wire [15:0] command;
    wire finished;
    wire taken;
    reg send = 0;
   
    // Signal for testing
    assign config_finished = finished;
    
    // Signals for RESET and PWDN OV2640
    assign reset = 1;
    assign pwdn = 0;
    
    // Signal to indicate that the configuration is finshied    
    always @ (posedge clk) begin
        send = ~finished;
    end
    
    reg resend_d;
    reg resend_dd;
    reg resend_ddd;
    reg my_reset = 0;
    always @ (posedge clk) begin
        my_reset <= ~resend_d & resend;
        resend_ddd <= resend_dd;
        resend_dd <= resend_d;
        resend_d <= resend;
    end
`define USE_POLYPHONY
`ifdef USE_POLYPHONY
    ov2640_m ov2640_m(
        .clk(clk),
        .rst(my_reset),

        .advance(taken),
        .command(command),
        .finished(finished),
        .resend(resend_ddd)
    );
`else
    // Create an instance of a LUT table 
    OV2640_Registers LUT(
        .clk(clk),                          // 50Mhz clock signal
        .advance(taken),                    // Flag to advance to next register
        .command(command),                  // register value and data for OV2640
        .finished(finished),                // Flag to indicate the configuration is finshed
        .resend(resend)                     // Re-configure flag for OV2640
    );
`endif
    
    // Create an instance of a SCCB interface
    I2C_Interface #(
        .SID (8'h60) 
    ) I2C (
        .clk(clk),                          // 50Mhz clock signal
        .taken(taken),                      // Flag to advance to next register
        .siod(siod),                        // Clock signal for SCCB interface
        .sioc(sioc),                        // Data signal for SCCB interface 
        .send(send),                        // Continue to configure OV2640
        .rega(command[15:8]),               // Register address
        .value(command[7:0])                // Data to write into register
    );
    
endmodule

module piano_system(
  input  wire        CLOCK_50,
  input  wire [3:0]  KEY,
  inout  wire        PS2_CLK,
  inout  wire        PS2_DAT,
  
  // VGA outputs
  output wire [7:0]  VGA_R,
  output wire [7:0]  VGA_G,
  output wire [7:0]  VGA_B,
  output wire        VGA_HS,
  output wire        VGA_VS,
  output wire        VGA_BLANK_N,
  output wire        VGA_SYNC_N,
  output wire        VGA_CLK,

  // Audio codec I/O
  inout  wire        AUD_ADCLRCK,
  inout  wire        AUD_ADCDAT,
  inout  wire        AUD_BCLK,
  inout  wire        AUD_DACLRCK,
  output wire        AUD_XCK,
  output wire        AUD_DACDAT,
  inout  wire        FPGA_I2C_SDAT,
  inout  wire        FPGA_I2C_SCLK,

  // Tone outputs (first octave)
  output wire        cIn,
  output wire        dIn,
  output wire        eIn,
  output wire        fIn,
  output wire        gIn,
  output wire        aIn,
  output wire        bIn,
  
  // Tone outputs (black keys first octave)
  output wire        csIn,
  output wire        dsIn,
  output wire        fsIn,
  output wire        gsIn,
  output wire        asIn,

  // Tone outputs (second octave)
  output wire        cIn2,
  output wire        dIn2,
  output wire        eIn2,
  output wire        fIn2,
  output wire        gIn2,
  output wire        aIn2,
  output wire        bIn2,

  // Tone outputs (black keys second octave)
  output wire        csIn2,
  output wire        dsIn2,
  output wire        fsIn2,
  output wire        gsIn2,
  output wire        asIn2
);

  //------------------------------------------------------------------------
  // Internal nets
  //------------------------------------------------------------------------
  wire [5:0] key_data;
  wire       key_valid;
  wire [1:0] key_type;
  wire [2:0] color_output;

  //------------------------------------------------------------------------
  // PS/2 keyboard interface
  //------------------------------------------------------------------------
  keyboard u_keyboard (
    .CLOCK_50   (CLOCK_50),
    .resetn     (KEY[0]),
    .PS2_CLK    (PS2_CLK),
    .PS2_DAT    (PS2_DAT),
    .key_data   (key_data),
    .key_valid  (key_valid),
    .LEDR       (/*unused*/),
    .HEX5       (/*unused*/)
  );

  //------------------------------------------------------------------------
  // Key-to-color/type mapping
  //------------------------------------------------------------------------
  key_selection u_keysel (
    .resetn      (KEY[0]),
    .CLOCK_50    (CLOCK_50),
    .key_data    (key_data),
    .key_valid   (key_valid),
    .color_output(color_output),
    .key_type    (key_type)
  );

  //------------------------------------------------------------------------
  // VGA graphics rendering
  //------------------------------------------------------------------------
  reducedKeys u_gfx (
    .CLOCK_50    (CLOCK_50),
    .resetn      (KEY[0]),
    .color_input (color_output),
    .key_type    (key_type),
    .VGA_R       (VGA_R),
    .VGA_G       (VGA_G),
    .VGA_B       (VGA_B),
    .VGA_HS      (VGA_HS),
    .VGA_VS      (VGA_VS),
    .VGA_BLANK_N (VGA_BLANK_N),
    .VGA_SYNC_N  (VGA_SYNC_N),
    .VGA_CLK     (VGA_CLK)
  );

  //------------------------------------------------------------------------
  // Tone generation (delays, toggles)
  //------------------------------------------------------------------------
  audio u_audio (
    .CLOCK_50   (CLOCK_50),
    .resetn     (KEY[0]),
    .key_type   (key_type),
    .cIn        (cIn),
    .dIn        (dIn),
    .eIn        (eIn),
    .fIn        (fIn),
    .gIn        (gIn),
    .aIn        (aIn),
    .bIn        (bIn),
    .csIn       (csIn),
    .dsIn       (dsIn),
    .fsIn       (fsIn),
    .gsIn       (gsIn),
    .asIn       (asIn),
    .cIn2       (cIn2),
    .dIn2       (dIn2),
    .eIn2       (eIn2),
    .fIn2       (fIn2),
    .gIn2       (gIn2),
    .aIn2       (aIn2),
    .bIn2       (bIn2),
    .csIn2      (csIn2),
    .dsIn2      (dsIn2),
    .fsIn2      (fsIn2),
    .gsIn2      (gsIn2),
    .asIn2      (asIn2)
  );

  //------------------------------------------------------------------------
  // Audio codec interface & mixing
  //------------------------------------------------------------------------
  audio_controller u_ctrl (
    .CLOCK_50     (CLOCK_50),
    .resetn       (KEY[0]),
    .tone_inputs  ({cIn, dIn, eIn, fIn, gIn, aIn, bIn,
                     csIn, dsIn, fsIn, gsIn, asIn,
                     cIn2, dIn2, eIn2, fIn2, gIn2, aIn2, bIn2,
                     csIn2, dsIn2, fsIn2, gsIn2, asIn2}),
    .AUD_ADCDAT   (AUD_ADCDAT),
    .AUD_BCLK     (AUD_BCLK),
    .AUD_ADCLRCK  (AUD_ADCLRCK),
    .AUD_DACLRCK  (AUD_DACLRCK),
    .AUD_XCK      (AUD_XCK),
    .AUD_DACDAT   (AUD_DACDAT),
    .FPGA_I2C_SDAT(FPGA_I2C_SDAT),
    .FPGA_I2C_SCLK(FPGA_I2C_SCLK)
  );

endmodule

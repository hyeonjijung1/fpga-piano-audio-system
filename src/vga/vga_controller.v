module vga_controller(
  input  wire        clock,
  input  wire        resetn,
  input  wire [2:0]  colour,
  output wire [7:0]  VGA_R,
  output wire [7:0]  VGA_G,
  output wire [7:0]  VGA_B,
  output wire        VGA_HS,
  output wire        VGA_VS,
  output wire        VGA_BLANK_N,
  output wire        VGA_SYNC_N,
  output wire        VGA_CLK
);

  // Pixel coordinates
  reg [7:0] X_count;
  reg [6:0] Y_count;
  wire plot = 1'b1;

  // Generate X,Y for VGA adapter
  always @(posedge clock) begin
    if (!resetn) begin
      X_count <= 8'd0;
      Y_count <= 7'd0;
    end else begin
      if (X_count == 8'd159) begin
        X_count <= 8'd0;
        if (Y_count == 7'd119)
          Y_count <= 7'd0;
        else
          Y_count <= Y_count + 1;
      end else begin
        X_count <= X_count + 1;
      end
    end
  end

  // Connect to Altera VGA adapter
  vga_adapter VGA (
    .resetn      (resetn),
    .clock       (clock),
    .colour      (colour),
    .x           (X_count),
    .y           (Y_count),
    .plot        (plot),
    .VGA_R       (VGA_R),
    .VGA_G       (VGA_G),
    .VGA_B       (VGA_B),
    .VGA_HS      (VGA_HS),
    .VGA_VS      (VGA_VS),
    .VGA_BLANK_N (VGA_BLANK_N),
    .VGA_SYNC_N  (VGA_SYNC_N),
    .VGA_CLK     (VGA_CLK)
  );

  defparam VGA.RESOLUTION = "160x120";
  defparam VGA.MONOCHROME = "FALSE";
  defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
  defparam VGA.BACKGROUND_IMAGE = "no_keys_pressed.mif";

endmodule

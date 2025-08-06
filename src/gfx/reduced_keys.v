module reducedKeys(SW, KEY, CLOCK_50,HEX5, HEX3, HEX2, HEX1, HEX0, LEDR, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK,
// Bidirectionals PS2_CLK, PS2_DAT,
// Outputs
cIn, dIn, eIn, fIn, gIn, aIn, bIn,
csIn, dsIn, fsIn, gsIn, asIn,
cIn2, dIn2, eIn2, fIn2, gIn2, aIn2, bIn2, csIn2, dsIn2, fsIn2, gsIn2, asIn2,
//for audio
AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, FPGA_I2C_SDAT, AUD_XCK, AUD_DACDAT, FPGA_I2C_SCLK);
input [3:0] KEY;
input CLOCK_50;
output [6:0] HEX3, HEX2, HEX1, HEX0;
input [5:0] SW;
output [7:0] VGA_R; output [7:0] VGA_G; output [7:0] VGA_B; output VGA_HS;
output VGA_VS;
output VGA_BLANK_N;

 output VGA_SYNC_N; output VGA_CLK;
reg [7:0] X;
reg [6:0] Y;
reg [7:0] X_count;
reg [6:0] Y_count;
wire [2:0] VGA_COLOR;
wire plot;
wire [1:0] key_type;
wire [5:0] key;
wire [2:0] color;
reg [2:0] color_output;
wire [2:0] color0; wire [2:0] color1; wire [2:0] color2; wire [2:0] color3; wire [2:0] color4; wire [2:0] color5; wire [2:0] color6; wire [2:0] color7; wire [2:0] color8; wire [2:0] color9; wire [2:0] color10; wire [2:0] color11; wire [2:0] color12; wire [2:0] color13; wire [2:0] color14; wire [2:0] color15;
//reg [15:0] P;
wire load_enable;
wire key_load_enable;

 //reg [89:0] queue = 90'b00000000001000010001000101000111001001001011001100011100000100000100010100 1101010111;
no_keys_pressed b0(160*Y + X, CLOCK_50, color0); Q_key b1(160*Y + X, CLOCK_50, color1);
E_key b3(160*Y + X, CLOCK_50, color2);
T_key b5(160*Y + X, CLOCK_50, color3);
Y_key b6(160*Y + X, CLOCK_50, color4); I_key b8(160*Y + X, CLOCK_50, color5); P_key b10(160*Y + X, CLOCK_50, color6); S_key b12(160*Y + X, CLOCK_50, color7); D_key b13(160*Y + X, CLOCK_50, color8); G_key b15(160*Y + X, CLOCK_50, color9); J_key b17(160*Y + X, CLOCK_50, color10); K_key b18(160*Y + X, CLOCK_50, color11); Z_key b20(160*Y + X, CLOCK_50, color12); C_key b22(160*Y + X, CLOCK_50, color13); B_key b24(160*Y + X, CLOCK_50, color14);
//regn UY (LEDR[5:0], KEY[0], ~KEY[1], CLOCK_50, key);
//three_second T(KEY[0], CLOCK_50, load_enable); //key_prompt_shift_register S1(CLOCK_50, KEY[0], load_enable, queue, key);
key_selection K1(KEY[0], LEDR[5:0], color0, color1, color2, color3, color4, color5, color6, color7, color8, color9, color10, color11, color12, color13, color14, CLOCK_50, key_type, color);
assign plot = 1'b1;
always @ (posedge CLOCK_50) begin
if (plot) begin
if (X_count == 8'd160 && ~(Y_count == 8'd120)) begin
X_count <= 8'd0;
Y_count <= Y_count + 1;
end else if (X_count == 8'd159 && Y_count == 8'd119) begin
X_count <= 8'd0; Y_count <= 8'd0;

 end end
end
X <= 0;
Y <= 0; end else begin
X_count <= X_count + 1; X <= X_count;
Y <= Y_count; color_output <= color;
// erase_draw U2(start_X, start_Y, CLOCK_50, KEY[0], load_enable, X, Y, VGA_COLOR, plot);
keyboard KEYBOARD (
// Inputs .CLOCK_50(CLOCK_50), .KEY(KEY),
// Bidirectionals .PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT),
// Outputs
.LEDR(LEDR), .HEX5(HEX5),
.cIn(cIn), .dIn(dIn), .eIn(eIn), .fIn(fIn), .gIn(gIn), .aIn(aIn), .bIn(bIn),
.csIn(csIn), .dsIn(dsIn), .fsIn(fsIn), .gsIn(gsIn), .asIn(asIn),
.cIn2(cIn2), .dIn2(dIn2), .eIn2(eIn2), .fIn2(fIn2), .gIn2(gIn2), .aIn2(aIn2), .bIn2(bIn2), .csIn2(csIn2), .dsIn2(dsIn2), .fsIn2(fsIn2), .gsIn2(gsIn2), .asIn2(asIn2),
//for audio
.AUD_ADCDAT(AUD_ADCDAT), .AUD_BCLK(AUD_BCLK), .AUD_ADCLRCK(AUD_ADCLRCK), .AUD_DACLRCK(AUD_DACLRCK), .FPGA_I2C_SDAT(FPGA_I2C_SDAT), .AUD_XCK(AUD_XCK), .AUD_DACDAT(AUD_DACDAT), .FPGA_I2C_SCLK(FPGA_I2C_SCLK) );
// Bidirectionals
inout PS2_CLK; inout PS2_DAT;

 // Outputs
output [5:0] LEDR;
output [6:0] HEX5;
output cIn, dIn, eIn, fIn, gIn, aIn, bIn;
output csIn, dsIn, fsIn, gsIn, asIn;
output cIn2, dIn2, eIn2, fIn2, gIn2, aIn2, bIn2; output csIn2, dsIn2, fsIn2, gsIn2, asIn2;
/***************************************************************************** * Internal Wires and Registers Declarations * *****************************************************************************/
//for audio
input AUD_ADCDAT; inout AUD_BCLK;
inout AUD_ADCLRCK; inout AUD_DACLRCK; inout FPGA_I2C_SDAT; output AUD_XCK;
output AUD_DACDAT; output FPGA_I2C_SCLK;
vga_adapter VGA ( .resetn(KEY[0]),
.clock(CLOCK_50), .colour(color_output), .x(X),
.y(Y),
.plot(plot), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_HS(VGA_HS),

 .VGA_VS(VGA_VS), .VGA_BLANK_N(VGA_BLANK_N), .VGA_SYNC_N(VGA_SYNC_N), .VGA_CLK(VGA_CLK));
defparam VGA.RESOLUTION = "160x120"; defparam VGA.MONOCHROME = "FALSE";
defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
defparam VGA.BACKGROUND_IMAGE = "no_keys_pressed.mif";
//counter part2(1'b1, KEY[0], KEY[2], Q);
// hexadecimaldisplay part2A({load_enable, 3'b000}, HEX0); // hexadecimaldisplay part2B(Q[7:4], HEX1); //hexadecimaldisplay part2C(Q[11:8], HEX2); //hexadecimaldisplay part2D(Q[15:12], HEX3);
endmodule

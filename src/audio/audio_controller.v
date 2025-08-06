module audio ( // Inputs CLOCK_50, KEY,
AUD_ADCDAT,
// Bidirectionals AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK,
FPGA_I2C_SDAT,
// Outputs AUD_XCK, AUD_DACDAT,
FPGA_I2C_SCLK,
cIn, dIn, eIn, fIn, gIn, aIn, bIn,
csIn, dsIn, fsIn, gsIn, asIn,
cIn2, dIn2, eIn2, fIn2, gIn2, aIn2, bIn2, csIn2, dsIn2, fsIn2, gsIn2, asIn2
);
/***************************************************************************** * Parameter Declarations * *****************************************************************************/
/*****************************************************************************

 * Port Declarations *
*****************************************************************************/ // Inputs
input CLOCK_50;
input [3:0] KEY;
input AUD_ADCDAT;
// Bidirectionals
inout AUD_BCLK; inout AUD_ADCLRCK; inout AUD_DACLRCK;
inout FPGA_I2C_SDAT;
// Outputs
output AUD_XCK; output AUD_DACDAT;
output FPGA_I2C_SCLK;
//first octave
input cIn, dIn, eIn, fIn, gIn, aIn, bIn; input csIn, dsIn, fsIn, gsIn, asIn;
//second octave
input cIn2, dIn2, eIn2, fIn2, gIn2, aIn2, bIn2; input csIn2, dsIn2, fsIn2, gsIn2, asIn2;
/***************************************************************************** * Internal Wires and Registers Declarations * *****************************************************************************/
// Internal Wires
wire audio_in_available;
wire [31:0] left_channel_audio_in; wire [31:0] right_channel_audio_in; wire read_audio_in;
wire audio_out_allowed;
wire [31:0] left_channel_audio_out; wire [31:0] right_channel_audio_out; wire write_audio_out;
// Internal Registers

 reg [18:0] cDelay, dDelay, eDelay, fDelay, gDelay, aDelay, bDelay; wire [18:0] C3, D3, E3, F3, G3, A3, B3;
reg[18:0] csDelay, dsDelay, fsDelay, gsDelay, asDelay; wire [18:0] C3s, D3s, F3s, G3s, A3s;
reg cSnd, dSnd, eSnd, fSnd, gSnd, aSnd, bSnd; reg csSnd, dsSnd, fsSnd, gsSnd, asSnd;
//second octave
reg [18:0] cDelay2, dDelay2, eDelay2, fDelay2, gDelay2, aDelay2, bDelay2; wire [18:0] C4, D4, E4, F4, G4, A4, B4;
reg[18:0] csDelay2, dsDelay2, fsDelay2, gsDelay2, asDelay2; wire [18:0] C4s, D4s, F4s, G4s, A4s;
reg cSnd2, dSnd2, eSnd2, fSnd2, gSnd2, aSnd2, bSnd2; reg csSnd2, dsSnd2, fsSnd2, gsSnd2, asSnd2;
// State Machine Registers
/***************************************************************************** * Finite State Machine(s) * *****************************************************************************/
/***************************************************************************** * Sequential Logic * *****************************************************************************/
//second octave //white tiles
always @(posedge CLOCK_50) if(cDelay2 == C4) begin cDelay2 <= 0;
cSnd2 <= !cSnd2;
end else cDelay2 <= cDelay2 + 1;
always @(posedge CLOCK_50) if(dDelay2 == D4) begin dDelay2 <= 0;

 dSnd2 <= !dSnd2;
end else dDelay2 <= dDelay2 + 1;
always @(posedge CLOCK_50) if(eDelay2 == E4) begin eDelay2 <= 0;
eSnd2 <= !eSnd2;
end else eDelay2 <= eDelay2 + 1;
always @(posedge CLOCK_50) if(fDelay2 == F4) begin
fDelay2 <= 0;
fSnd2 <= !fSnd2;
end else fDelay2 <= fDelay2 + 1;
always @(posedge CLOCK_50) if(gDelay2 == G4) begin gDelay2 <= 0;
gSnd2 <= !gSnd2;
end else gDelay2 <= gDelay2 + 1;
always @(posedge CLOCK_50) if(aDelay2 == A4) begin aDelay2 <= 0;
aSnd2 <= !aSnd2;
end else aDelay2 <= aDelay2 + 1;
always @(posedge CLOCK_50) if(bDelay2 == B4) begin bDelay2 <= 0;
bSnd2 <= !bSnd2;
end else bDelay2 <= bDelay2 + 1; //black tiles
always @(posedge CLOCK_50) if(csDelay2 == C4s) begin csDelay2 <= 0;
csSnd2 <= !csSnd2;
end else csDelay2 <= csDelay2 + 1;
always @(posedge CLOCK_50) if(dsDelay2 == D4s) begin dsDelay2 <= 0;

 dsSnd2 <= !dsSnd2;
end else dsDelay2 <= dsDelay2 + 1;
always @(posedge CLOCK_50) if(fsDelay2 == F4s) begin fsDelay2 <= 0;
fsSnd2 <= !fsSnd2;
end else fsDelay2 <= fsDelay2 + 1;
always @(posedge CLOCK_50) if(gsDelay2 == G4s) begin gsDelay2 <= 0;
gsSnd2 <= !gsSnd2;
end else gsDelay2 <= gsDelay2 + 1;
always @(posedge CLOCK_50) if(asDelay2 == A4s) begin asDelay2 <= 0;
asSnd2 <= !asSnd2;
end else asDelay2 <= asDelay2 + 1;
//first octave //white tiles
always @(posedge CLOCK_50) if(cDelay == C3) begin
cDelay <= 0;
cSnd <= !cSnd;
end else cDelay <= cDelay + 1;
always @(posedge CLOCK_50) if(dDelay == D3) begin
dDelay <= 0;
dSnd <= !dSnd;
end else dDelay <= dDelay + 1;
always @(posedge CLOCK_50) if(eDelay == E3) begin
eDelay <= 0;
eSnd <= !eSnd;
end else eDelay <= eDelay + 1;
always @(posedge CLOCK_50) if(fDelay == F3) begin

 fDelay <= 0;
fSnd <= !fSnd;
end else fDelay <= fDelay + 1;
always @(posedge CLOCK_50) if(gDelay == G3) begin
gDelay <= 0;
gSnd <= !gSnd;
end else gDelay <= gDelay + 1;
always @(posedge CLOCK_50) if(aDelay == A3) begin
aDelay <= 0;
aSnd <= !aSnd;
end else aDelay <= aDelay + 1;
always @(posedge CLOCK_50) if(bDelay == B3) begin
bDelay <= 0;
bSnd <= !bSnd;
end else bDelay <= bDelay + 1; //black tiles
always @(posedge CLOCK_50) if(csDelay == C3s) begin csDelay <= 0;
csSnd <= !csSnd;
end else csDelay <= csDelay + 1;
always @(posedge CLOCK_50) if(dsDelay == D3s) begin dsDelay <= 0;
dsSnd <= !dsSnd;
end else dsDelay <= dsDelay + 1;
always @(posedge CLOCK_50) if(fsDelay == F3s) begin
fsDelay <= 0;
fsSnd <= !fsSnd;
end else fsDelay <= fsDelay + 1;
always @(posedge CLOCK_50) if(gsDelay == G3s) begin

 gsDelay <= 0;
gsSnd <= !gsSnd;
end else gsDelay <= gsDelay + 1;
always @(posedge CLOCK_50) if(asDelay == A3s) begin asDelay <= 0;
asSnd <= !asSnd;
end else asDelay <= asDelay + 1; /*****************************************************************************
* Combinational Logic * *****************************************************************************/
//first octave
assign C3 = 18'd190080; // 262 Hz assign D3 = 18'd170068; // 294 Hz assign E3 = 18'd151515; // 330 Hz assign F3 = 18'd143003; // 349 Hz assign G3 = 18'd127551; // 392 Hz assign A3 = 18'd113636; // 440 Hz assign B3 = 18'd101214; // 494 Hz
assign C3s = 18'd180129; // 277 Hz assign D3s = 18'd160458; // 311 Hz assign F3s = 18'd135135; // 370 Hz assign G3s = 18'd120481; // 415 Hz assign A3s = 18'd107290; // 466 Hz
//second octave
assign C4 = 18'd95238; assign D4 = 18'd85470; assign E4 = 18'd75758; assign F4 = 18'd71644; assign G4 = 18'd63723; assign A4 = 18'd56818; assign B4 = 18'd50584;
// 524 Hz // 588 Hz // 660 Hz
// 698 Hz // 784 Hz // 880 Hz
// 988 Hz
// Frequencies for C4s, D4s, E4s, etc. (sharp notes of the 2nd octave)
assign C4s = 18'd90177; assign D4s = 18'd80290; assign F4s = 18'd67567; assign G4s = 18'd60240; assign A4s = 18'd53598;
// 554 Hz // 622 Hz // 740 Hz // 830 Hz // 932 Hz

 wire [31:0] sound = ((cIn == 0) ? 0 : cSnd ? 32'd100000000 : -32'd100000000)+((dIn == 0) ? 0 : dSnd ? 32'd100000000 : -32'd100000000)+
((eIn == 0) ? 0 : eSnd ? 32'd100000000 : -32'd100000000)+((fIn == 0) ? 0 : fSnd ? 32'd100000000 : -32'd100000000)+
((gIn == 0) ? 0 : gSnd ? 32'd100000000 : -32'd100000000)+((aIn == 0) ? 0 : aSnd ? 32'd100000000 : -32'd100000000)+
((bIn == 0) ? 0 : bSnd ? 32'd100000000 : -32'd100000000)+((csIn == 0) ? 0 : csSnd ? 32'd100000000 : -32'd100000000)+
((dsIn == 0) ? 0 : dsSnd ? 32'd100000000 : -32'd100000000)+((fsIn == 0) ? 0 : fsSnd ? 32'd100000000 : -32'd100000000)+
((gsIn == 0) ? 0 : gsSnd ? 32'd100000000 : -32'd100000000)+((asIn == 0) ? 0 : asSnd ? 32'd100000000 : -32'd100000000)+
((cIn2 == 0) ? 0 : cSnd2 ? 32'd100000000 : -32'd100000000)+((dIn2 == 0) ? 0 : dSnd2 ? 32'd100000000 : -32'd100000000)+
((eIn2 == 0) ? 0 : eSnd2 ? 32'd100000000 : -32'd100000000)+((fIn2 == 0) ? 0 : fSnd2 ? 32'd100000000 : -32'd100000000)+
((gIn2 == 0) ? 0 : gSnd2 ? 32'd100000000 : -32'd100000000)+((aIn2 == 0) ? 0 : aSnd2 ? 32'd100000000 : -32'd100000000)+
((bIn2 == 0) ? 0 : bSnd2 ? 32'd100000000 : -32'd100000000)+((csIn2 == 0) ? 0 : csSnd2 ? 32'd100000000 : -32'd100000000)+
((dsIn2 == 0) ? 0 : dsSnd2 ? 32'd100000000 : -32'd100000000)+((fsIn2 == 0) ? 0 : fsSnd2 ? 32'd100000000 : -32'd100000000)+
((gsIn2 == 0) ? 0 : gsSnd2 ? 32'd100000000 : -32'd100000000)+((asIn2 == 0) ? 0 : asSnd2 ? 32'd100000000 : -32'd100000000);
assign read_audio_in = audio_in_available & audio_out_allowed;
assign left_channel_audio_out = left_channel_audio_in+sound; assign right_channel_audio_out = right_channel_audio_in+sound; assign write_audio_out = audio_in_available & audio_out_allowed;
/***************************************************************************** * Internal Modules * *****************************************************************************/
Audio_Controller Audio_Controller ( // Inputs
.CLOCK_50 (CLOCK_50),
.reset (~KEY[0]),
.clear_audio_in_memory (), .read_audio_in (read_audio_in),

 .clear_audio_out_memory (), .left_channel_audio_out (left_channel_audio_out), .right_channel_audio_out (right_channel_audio_out), .write_audio_out (write_audio_out),
.AUD_ADCDAT (AUD_ADCDAT),
// Bidirectionals
.AUD_BCLK (AUD_BCLK), .AUD_ADCLRCK (AUD_ADCLRCK), .AUD_DACLRCK (AUD_DACLRCK),
// Outputs
.audio_in_available (audio_in_available), .left_channel_audio_in (left_channel_audio_in), .right_channel_audio_in (right_channel_audio_in),
.audio_out_allowed (audio_out_allowed),
.AUD_XCK (AUD_XCK), .AUD_DACDAT (AUD_DACDAT)
);
avconf #(.USE_MIC_INPUT(1)) avc ( .FPGA_I2C_SCLK (FPGA_I2C_SCLK), .FPGA_I2C_SDAT (FPGA_I2C_SDAT), .CLOCK_50 (CLOCK_50),
.reset (~KEY[0]) );
endmodule
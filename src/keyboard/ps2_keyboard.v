module keyboard ( // Inputs
CLOCK_50, KEY,
// Bidirectionals PS2_CLK, PS2_DAT,
// Outputs
VGA_COLOR <= 3'b110; end
x_out <= x_coor;
y_out <= y_coor; drawDone <= 1'b1;
LEDR, HEX5,
cIn, dIn, eIn, fIn, gIn, aIn, bIn,
csIn, dsIn, fsIn, gsIn, asIn,
cIn2, dIn2, eIn2, fIn2, gIn2, aIn2, bIn2, csIn2, dsIn2, fsIn2, gsIn2, asIn2,
//for audio
AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, FPGA_I2C_SDAT, AUD_XCK, AUD_DACDAT, FPGA_I2C_SCLK
);
/***************************************************************************** * Parameter Declarations * *****************************************************************************/
/*****************************************************************************

 * Port Declarations * *****************************************************************************/
// Inputs
input CLOCK_50; input [3:0] KEY;
// Bidirectionals
inout PS2_CLK; inout PS2_DAT;
// Outputs
output reg [5:0] LEDR;
output reg [6:0] HEX5;
output reg cIn, dIn, eIn, fIn, gIn, aIn, bIn;
output reg csIn, dsIn, fsIn, gsIn, asIn;
output reg cIn2, dIn2, eIn2, fIn2, gIn2, aIn2, bIn2; output reg csIn2, dsIn2, fsIn2, gsIn2, asIn2;
/***************************************************************************** * Internal Wires and Registers Declarations * *****************************************************************************/
// Internal Wires
inout AUD_ADCLRCK; inout AUD_DACLRCK; inout FPGA_I2C_SDAT; output AUD_XCK;
output AUD_DACDAT; output FPGA_I2C_SCLK;
// Internal Registers
reg [7:0] last_data_received;
// State Machine Registers
/***************************************************************************** * Finite State Machine(s) *
wire
wire
wire
//for audio
input AUD_ADCDAT; inout AUD_BCLK;
[7:0] [4:0]
ps2_key_data; ps2_key_pressed;
ps2_count; // Declare ps2_count as a wire

 *****************************************************************************/
/***************************************************************************** * Sequential Logic * *****************************************************************************/
always @(posedge CLOCK_50) begin if (KEY[0] == 1'b0)
last_data_received <= 8'h00; else if (ps2_key_pressed == 1'b1)
last_data_received <= ps2_key_data; end
/***************************************************************************** * Combinational Logic * *****************************************************************************/
/***************************************************************************** * Internal Modules * *****************************************************************************/
PS2_Controller PS2 ( // Inputs
.CLOCK_50 .reset
// Bidirectionals .PS2_CLK .PS2_DAT
// Outputs .received_data .received_data_en
(CLOCK_50), (~KEY[0]),
(PS2_CLK), (PS2_DAT),
(ps2_key_data), (ps2_key_pressed),
// Pass the ps2_count output to the top module );
/***************************************************************************** * LED Control Logic based on Key Presses * *****************************************************************************/

 always @(posedge ps2_key_pressed) begin
//press Q
if ( ps2_key_data == 8'h15) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b0; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
//press W
else if ( ps2_key_data == 8'h1D) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b0; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
//E
else if ( ps2_key_data == 8'h24) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b0; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
//R
else if ( ps2_key_data == 8'h2D) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b0; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
//T
else if ( ps2_key_data == 8'h2C) begin

 LEDR[0] <= 1'b0; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b0; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
//Y
else if ( ps2_key_data == 8'h35) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b0; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
//U
else if ( ps2_key_data == 8'h3C) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b0; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
//I
else if ( ps2_key_data == 8'h43) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b0; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h44) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b1; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h4D) begin
LEDR[0] <= 1'b1;

 LEDR[1] <= 1'b0; LEDR[2] <= 1'b0; LEDR[3] <= 1'b1; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h1C) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b1; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h1B) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b1; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h23) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b1; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h2B) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b1; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h34) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b1; LEDR[4] <= 1'b0;

 LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h33) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b1; LEDR[4] <= 1'b0; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h3B) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b0; LEDR[4] <= 1'b1; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h42) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b0; LEDR[4] <= 1'b1; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h4B) begin
LEDR[0] <= 1'b0; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b0; LEDR[4] <= 1'b1; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h1A) begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b1;
LEDR[2] <= 1'b0; LEDR[3] <= 1'b0; LEDR[4] <= 1'b1; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h22) begin

 LEDR[0] <= 1'b0; LEDR[1] <= 1'b0;
LEDR[2] <= 1'b1; LEDR[3] <= 1'b0; LEDR[4] <= 1'b1; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h21) begin LEDR[0] <= 1'b1;
LEDR[1] <= 1'b0; LEDR[2] <= 1'b1; LEDR[3] <= 1'b0; LEDR[4] <= 1'b1; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h2A) begin LEDR[0] <= 1'b0;
LEDR[1] <= 1'b1; LEDR[2] <= 1'b1; LEDR[3] <= 1'b0; LEDR[4] <= 1'b1; LEDR[5] <= 1'b0;
end
else if ( ps2_key_data == 8'h32) begin LEDR[0] <= 1'b1;
LEDR[1] <= 1'b1; LEDR[2] <= 1'b1; LEDR[3] <= 1'b0; LEDR[4] <= 1'b1; LEDR[5] <= 1'b0;
end
//when no key is pressed all LEDR is turned on else begin
LEDR[0] <= 1'b1; LEDR[1] <= 1'b1; LEDR[2] <= 1'b1; LEDR[3] <= 1'b1; LEDR[4] <= 1'b1; LEDR[5] <= 1'b1;

 end end
always @(posedge ps2_key_pressed) begin if ( ps2_key_data == 8'h16)
HEX5 <= 7'b1111001;
else if ( ps2_key_data == 8'h1E) HEX5 <= 7'b0100100;
else if ( ps2_key_data == 8'h26) HEX5 <= 7'b0110000;
else
HEX5 <= 7'b1000000;
end
always @(posedge ps2_key_pressed) begin //cIn Q
if ( ps2_key_data == 8'h15) begin cIn <= 1'b1;
end
//csIn W
else if ( ps2_key_data == 8'h1D) begin
csIn <= 1'b1; end
//dIn E
else if ( ps2_key_data == 8'h24) begin
dIn <= 1'b1; end
//dsIn R
else if ( ps2_key_data == 8'h2D) begin
dsIn <= 1'b1; end
//eIn T
else if ( ps2_key_data == 8'h2C) begin
eIn <= 1'b1; end
//fIn Y
else if ( ps2_key_data == 8'h35) begin
fIn <= 1'b1; end
//fsIn U

 else if ( ps2_key_data == 8'h3C) begin fsIn <= 1'b1;
end
//gIn I
else if ( ps2_key_data == 8'h43) begin
gIn <= 1'b1; end
//gsIn O
else if ( ps2_key_data == 8'h44) begin
gsIn <= 1'b1; end
//aIn P
else if ( ps2_key_data == 8'h4D) begin
aIn <= 1'b1; end
//asIn A
else if ( ps2_key_data == 8'h1C) begin
asIn <= 1'b1; end
//bIn S
else if ( ps2_key_data == 8'h1B) begin
bIn <= 1'b1; end
//cIn2 D
else if ( ps2_key_data == 8'h23) begin
cIn2 <= 1'b1; end
//csIn2 F
else if ( ps2_key_data == 8'h2B) begin
csIn2 <= 1'b1; end
//dIn2 G
else if ( ps2_key_data == 8'h34) begin
dIn2 <= 1'b1;
end
//dsIn2 H
else if ( ps2_key_data == 8'h33) begin
dsIn2 <= 1'b1; end
//eIn2 J
else if ( ps2_key_data == 8'h3B) begin
eIn2 <= 1'b1; end

 //fIn2 K
else if ( ps2_key_data == 8'h42) begin
fIn2 <= 1'b1; end
//fsIn2 L
else if ( ps2_key_data == 8'h4B) begin
fsIn2 <= 1'b1; end
//gIn2 Z
else if ( ps2_key_data == 8'h1A) begin
gIn2 <= 1'b1; end
//gsIn2 X
else if ( ps2_key_data == 8'h22) begin
gsIn2 <= 1'b1; end
//aIn2 C
else if ( ps2_key_data == 8'h21) begin
aIn2 <= 1'b1; end
//asIn2 V
else if ( ps2_key_data == 8'h2A) begin
asIn2 <= 1'b1; end
//bIn2 B
else if ( ps2_key_data == 8'h32) begin
bIn2 <= 1'b1; end
//when no key is pressed all LEDR is turned on else begin
//first octave
//white keys
cIn <= 1'b0; dIn <= 1'b0; eIn <= 1'b0; fIn <= 1'b0; gIn <= 1'b0; aIn <= 1'b0; bIn <= 1'b0;
//black keys csIn <= 1'b0; dsIn <= 1'b0;

 fsIn <= 1'b0; gsIn <= 1'b0; asIn <= 1'b0; //second octave //white keys cIn2 <= 1'b0;
dIn2 <= 1'b0; eIn2 <= 1'b0; fIn2 <= 1'b0; gIn2 <= 1'b0; aIn2 <= 1'b0; bIn2 <= 1'b0;
//black keys csIn2 <= 1'b0; dsIn2 <= 1'b0; fsIn2 <= 1'b0; gsIn2 <= 1'b0; asIn2 <= 1'b0;
end end
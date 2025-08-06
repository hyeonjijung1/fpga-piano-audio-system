module erase_draw(
input [7:0] x_coor, // 6-bit key input
input [6:0] y_coor,
input CLOCK_50, // 50 MHz clock input resetn, // Reset signal
input enable, // signal to start drawing
output reg [7:0] x_out, // X coordinate of the dot
// X coordinate of the dot output reg [6:0] y_out,
// Y coordinate of the dot
output reg [2:0] VGA_COLOR, output reg plot
);
end endmodule
// State definitions
reg [1:0] state, next_state;
parameter IDLE = 2'b00, ERASE = 2'b01, DRAW = 2'b10;

 reg [7:0] prev_x; // Previous X coordinate reg [6:0] prev_y; // Previous Y coordinate
reg [7:0] x; //current coordinates reg [6:0] y;
reg eraseDone; reg eraseEnable; reg drawDone;
always @(posedge CLOCK_50) begin if (drawDone || eraseDone)
plot <= 1'b1;
else
plot <= 1'b0;
end
always @(posedge CLOCK_50) begin if (enable) begin
eraseEnable <= enable; end
else if (drawDone) begin eraseEnable <= enable;
end end
// FSM logic
always @(posedge CLOCK_50) begin
if (!resetn) begin state <= IDLE;
end else begin
state <= next_state;
end

 end
always @(*) begin case(state)
IDLE: next_state = eraseEnable ? ERASE : IDLE; ERASE: next_state = eraseDone ? DRAW : ERASE; DRAW: next_state = drawDone ? IDLE : DRAW;
default: next_state = IDLE; endcase
end
// Store the previous dot coordinates before drawing the new one always @(posedge CLOCK_50) begin
if (!resetn) begin prev_x <= 8'd0; prev_y <= 7'd0;
end else if (state == DRAW) begin prev_x <= x_coor;
prev_y <= y_coor;
end

 end
always @(posedge CLOCK_50) begin
case(state) ERASE: begin
if (prev_y == 7'd114) begin VGA_COLOR <= 3'b111;
end
// Erase previous dot by setting color to background (black)
else if (prev_y == 7'd89) begin
end
DRAW: begin
VGA_COLOR <= 3'b000; end
x_out <= prev_x; y_out <= prev_y; eraseDone <= 1'b1;
if (y_coor == 7'd114) begin VGA_COLOR <= 3'b100;
end
else if (y_coor == 7'd89) begin

 end endcase
end
endmodule
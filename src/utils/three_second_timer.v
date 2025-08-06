module counter(enable, clear, clock, Q);

 input enable, clear, clock; output reg [15:0] Q;
always @ (posedge clock) Q <= Q + 1'b1;
endmodule
module three_second(clear, clock, enable); //enables every three seconds
input clear, clock; output enable;
// reg [1:0] Q;
// wire oneSecEnable;
reg [27:0] fastcount; wire enable_sec; reg [3:0] three_sec;
// assign oneSecEnable = (fastcount == 26'd0) ? 1'b1: 1'b0; assign enable = (three_sec == 4'b1001) ? 1'b1: 1'b0;
always @ (posedge clock) begin if (~clear || enable)
fastcount <= 28'd150000000; else
fastcount <= fastcount - 1'b1; end
always @ (posedge clock) begin

 if (~clear) begin three_sec <= 4'b0000;
end else if (enable_sec) begin
end */ endmodule
end end
/*always @ (posedge clock) begin if (enable) begin
if ( three_sec == 4'b1001 ) three_sec <= 4'b0000;
else three_sec <= three_sec + 1'b1;
Q <= 2'd0;
end else if (oneSecEnable) begin
Q <= Q + 1'b1; end
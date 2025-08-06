module hexadecimaldisplay(C, Display); input [3:0] C;
output [6:0] Display; wire [6:0] h;
wire [1:4] x;
assign x = C;
assign h[0] = (x[1] & ~x[3] & ~x[4]) | (x[1] & ~x[2] & ~x[3]) | (x[3] & ~x[4]) | (x[1] & x[2] & x[3]) | ( ~x[2] & ~x[4]) | (~x[1] & x[3]) | (~x[1] & x[2] & x[4]);
assign h[1] = (~x[2]& ~x[4]) | (~x[1] & ~x[2]) | (~x[1] & ~x[3] & ~x[4]) | (~x[1] & x[3] & x[4]) | (x[1] & ~x[3] & x[4]);
assign h[2] = (~x[1] & x[2]) | (~x[3] & x[4]) | (~x[2] & x[3] & x[4]) | (x[1] & ~x[2] & x[3] & ~x[4]) | (x[1] & ~x[2]) | (~x[1] & x[2] & x[3] & ~x[4]) | (~x[1] & ~x[3] & ~x[4]);
assign h[3] = (~x[1]& ~x[2] & ~x[3] & ~x[4]) | (x[2] & ~x[3] & x[4]) | (~x[3] & ~x[4] & x[1]) |(x[4] & x[1] & ~x[2]) | (x[2] & x[3] & ~x[4]) | (~x[1] & ~x[2] & x[3]);

 assign h[4] = (~x[1]& ~x[2] & ~x[3] & ~x[4]) | (~x[3] & ~x[4] & x[1]) | ( x[3] & x[4] & x[1]) | (x[3] & ~x[4]) | (x[1] & x[2]);
assign h[5] = (~x[3] & ~x[4]) | (~x[1] & x[2] & ~x[3]) | (x[1] & x[2] & x[3]) | (x[1] & ~x[2]) | (x[2] & x[3] & ~x[4]);
assign h[6] = (x[1] & ~x[2]) | (x[3] & ~x[4]) | (~x[1] & ~x[2] & x[3]) | (x[1] & x[2] & x[4]) | (~x[1] & x[2] & ~x[3]);
assign Display = ~h;
endmodule
module regn(R, Resetn, E, Clock, Q); input [5:0] R;
input Resetn, E, Clock;
output reg [5:0] Q;
always @(posedge Clock) if (!Resetn)
Q <= 0; else if (E)
Q <= R; endmodule
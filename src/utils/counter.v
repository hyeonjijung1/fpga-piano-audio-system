module counter(enable, clear, clock, Q);

 input enable, clear, clock; output reg [15:0] Q;
always @ (posedge clock) Q <= Q + 1'b1;
endmodule
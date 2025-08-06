//--------------------------------------------------------------------------------
// File: piano_system_tb.v
// Author: Hyeonji Jung
// Created: 2025-07-05
// Description: End-to-end testbench for piano_system.v (audio + VGA + key matrix)
//--------------------------------------------------------------------------------
`timescale 1ns/1ps

module piano_system_tb;
  // 100 MHz system clock
  reg system_clk   = 0;
  // Active-high reset for init
  reg sys_reset    = 1;

  // 16-key matrix inputs
  reg [15:0] key_matrix = 16'd0;

  // DUT outputs
  wire audio_pwm;          // PWM output driving speaker/DAC
  wire h_sync, v_sync;     // VGA sync signals
  wire [11:0] vga_rgb;     // 4-bit per channel RGB

  // Instantiate top-level piano system
  piano_system dut (
    .clk        (system_clk),
    .reset      (sys_reset),
    .keys       (key_matrix),
    .audio_out  (audio_pwm),
    .hsync      (h_sync),
    .vsync      (v_sync),
    .rgb        (vga_rgb)
  );

  // Clock generator: toggle every 5 ns → 100 MHz
  always #5 system_clk = ~system_clk;

  initial begin
    // Hold reset for 50 ns to initialize all modules
    #50 sys_reset = 0;

    // Simulate pressing middle C (key_index = 0) for 1 µs
    #200 key_matrix[0] = 1;
    #1000 key_matrix[0] = 0;

    // Let VGA & audio run for a while
    #20000;

    // Finish simulation
    $finish;
  end
endmodule

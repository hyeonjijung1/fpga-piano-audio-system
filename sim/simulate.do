#--------------------------------------------------------------------------------
# File: simulate.do
# Author: Hyeonji Jung
# Created: 2025-08-05
# Description: Batch-mode ModelSim simulation for piano_system_tb.v
#--------------------------------------------------------------------------------

# Create or reset work library
vlib work
vmap  work work

# Compile RTL and testbench; adjust include path as needed
vlog -2005 +incdir+../hw ../hw/*.v ../sim/piano_system_tb.v

# Run the testbench in command-line mode and exit
vsim -c piano_system_tb -do {
  # Run until $finish
  run -all
  exit
}

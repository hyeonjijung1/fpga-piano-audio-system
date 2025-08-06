#--------------------------------------------------------------------------------
# File: run_quartus.tcl
# Author: Hyeonji Jung
# Created: 2025-07-05
# Description: Automate Quartus II build and report generation for piano_project
#--------------------------------------------------------------------------------

# === User-configurable parameters ===
set proj_name     "piano_project"
set top_entity    "reducedKeys"
set hw_dir        "../hw"
set reports_dir   "../reports"
set device_part   "5CSEMA5U23I7"   ;# DE1-SoC Cyclone V part number

# Open Quartus project
project_open ${proj_name}.qpf

# Assign top-level entity and source files
set_global_assignment -name TOP_LEVEL_ENTITY ${top_entity}
# Add all .v files from hw_dir
file glob -nocomplain ${hw_dir}/*.v | foreach src { set_global_assignment -name VERILOG_FILE $src }

# Select device
set_global_assignment -name DEVICE ${device_part}

# Run full compile
execute_flow -compile

# Ensure reports directory exists
file mkdir ${reports_dir}

# Export timing and utilization reports
report_timing    -delay_type max -max_paths 1 -verbose > ${reports_dir}/timing_max.txt
report_utilization > ${reports_dir}/utilization.txt

# Exit Tcl shell
exit

#!/usr/bin/env bash
#--------------------------------------------------------------------------------
# File: build.sh
# Author: Hyeonji Jung
# Created: 2025-08-05
# Description: Wrapper to run Quartus and ModelSim automation scripts
#--------------------------------------------------------------------------------

set -euo pipefail

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
REPORTS_DIR="${SCRIPT_DIR}/../reports"

echo "=== Cleaning previous reports ==="
rm -rf "${REPORTS_DIR}"
mkdir -p "${REPORTS_DIR}"

echo "=== Quartus build ==="
quartus_sh -t "${SCRIPT_DIR}/run_quartus.tcl"

echo "=== ModelSim simulation ==="
vsim -c -do "${SCRIPT_DIR}/../sim/simulate.do"

echo "=== Build complete! Reports are in ${REPORTS_DIR} ==="

# Verilog Piano on Cyclone V (DE1-SoC)

> A one-click FPGA piano with VGA output, PS/2 keyboard input, and audio I/O. Fully written in Verilog and automated from synthesis to simulation.

---

## Quick Links

- **Demo:** [Demo Video](https://drive.google.com/file/d/1-k1kQWv2bcY4y-GO6ZJZvzP8-Z2Uc33Q/view?resourcekey)
- **Full System Code:** [full_system.v](https://github.com/hyeonjijung1/fpga-piano-audio-system/blob/main/docs/full_system.v)

- ![FPGA Piano Demo](https://raw.githubusercontent.com/hyeonjijung1/fpga-piano-audio-system/main/docs/demo_photo.png)

*Figure: VGA display lighting up on the “J” key.*

---

## 📂 Repo Structure

```plaintext
.
├── src/                  # Verilog source by feature
│   ├── audio/            # audio & tone logic
│   │   └── audio_controller.v
│   ├── gfx/              # graphics primitives & key decoder
│   │   └── reduced_keys.v
│   ├── keyboard/         # PS/2 / button matrix interface
│   │   └── ps2_keyboard.v
│   ├── top/              # top‐level integration
│   │   └── piano_system.v
│   ├── utils/            # utility modules
│   │   ├── counter.v
│   │   ├── erase_draw_fsm.v
│   │   ├── hex_display.v
│   │   └── three_second_timer.v
│   └── vga/              # VGA sync & pixel driver
│       └── vga_controller.v
├── docs/                 # design docs & diagrams
│   └── full_system.v     # example netlist / block‐diagram
├── sim/                  # testbench & ModelSim DO
│   ├── piano_system_tb.v
│   └── simulate.do
├── scripts/              # automation scripts
│   ├── run_quartus.tcl
│   └── build.sh
├── reports/              # (auto) timing & utilization
├── .github/              # CI workflows (ci.yml)
├── .gitignore
└── README.md
``` 
## Key Features

- **Real-Time Audio:** PWM tone generation for all 16 keys  
- **VGA Graphics:** 640×480 pixel display driven entirely in Verilog  
- **Debounced Controls:** Robust PS/2 & button-matrix handling  
- **One-Click Automation:** Full Quartus & ModelSim flows via Tcl + Bash  

---

## System Architecture

### VGA → FSM → Display Pipeline

```mermaid
flowchart LR
  subgraph VGA_Pipeline
    direction LR
    ROM["ROM\nInputs: X[8], Y[7]\nOutputs: color[3]"]
    FSM["FSM\nInputs: color[3]\nOutputs: color, X[8], Y[7], plot"]
    Display["VGA Display\nInputs: color, X[8], Y[7], plot"]
    ROM --> FSM --> Display
  end
---
flowchart TD
  subgraph PS2_Keybd
    direction LR
    PS2["PS/2 Controller\nInputs: clock_50, reset, the_command[7:0], send_command\nOutputs: received_data[7:0], received_data_en, PS2_CLK, PS2_DAT"]
    SW["Switch Register\nOutputs: SW[5:0]"]
    PS2 --> SW
  end

  subgraph Audio_Path
    direction LR
    Audio["Audio Module\nInputs: clock_50, audio_adctrl, reset,\nclear_audio_out_mem, clear_audio_in_mem,\nleft_ch_audio_out, right_ch_audio_out,\nwrite_audio_out, read_audio_in\nOutputs: AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, AUD_XCK, AUD_DACDAT,\neff_ch_audio_in, right_ch_audio_in, audio_out_allowed"]
    Speaker["Speaker"]
    SW --> Audio --> Speaker
  end
```

## Build Automation

- **`scripts/run_quartus.tcl`**  
  Opens the Quartus project, sets the top entity & all `src/**/*.v`, runs a full compile, and emits:  
  - `reports/timing_max.txt`  
  - `reports/utilization.txt`

- **`sim/simulate.do`**  
  Compiles RTL in `src/` plus `sim/piano_system_tb.v`, runs the testbench in batch mode, then exits.

- **`scripts/build.sh`**  
  Cleans old reports, invokes both the Tcl and DO scripts, and collects outputs under `reports/`.

---
## Designed Performance Targets

Based on synthesis and design intent, this project is engineered to:

- Target : **100 MHz clock** (10 ns period) timing closure in a 5-stage pipeline  
- Target :  **< 10 % LUT** utilization of the Cyclone V fabric  
- Target : **< 5 % BRAM** utilization for all audio, VGA, and buffering resources  
---

## Getting Started

```bash
git clone https://github.com/hyeonjijung1/fpga-piano-audio-system.git
cd fpga-piano-audio-system
./scripts/build.sh
```
This will generate:

- reports/timing_max.txt (timing closure slack report)
- reports/utilization.txt (resource usage)

---

## About the Author
**[Hyeonji Jung](https://linkedin.com/in/hyeonjijung-uoft)**, FPGA Design Intern @ Korea University (May–Sep 2025)  
Email: [junghyeonji254@gmail.com](mailto:junghyeonji254@gmail.com)



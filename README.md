# 🎹 Verilog Piano on Cyclone V (DE1-SoC)

> A one‐click FPGA piano: real‐time audio generation, VGA visualization, and 16‐key button I/O—fully automated from synthesis to simulation.

---

## 🚀 Quick Links

- **Demo Video:**  
  https://drive.google.com/file/d/1-k1kQWv2bcY4y-GO6ZJZvzP8-Z2Uc33Q/view  
- **Slides Overview:**  
  https://docs.google.com/presentation/d/1mVGKNP_6rRCzFrcCEjO4WKDWorDyrl0JHLBCvOFSaMc  
- **Live Demo / GitHub Pages:**  
  https://your-pages.url  

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

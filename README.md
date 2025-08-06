[![Build Status](https://github.com/hyeonjijung1/fpga-piano-audio-system/actions/workflows/ci.yml/badge.svg)](https://github.com/hyeonjijung1/fpga-piano-audio-system/actions)
 [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
 [![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](#)
 # 
 Verilog Piano on Cyclone V (DE1-SoC)
 > A one-click FPGA piano: real-time audio, VGA visuals, and 16-key button I/O—fully automated from synthesis to simulation.--
## 
 Quick Links- **Demo Video:** [![Watch](https://img.shields.io/badge/
 %20Demo-YouTube-red.svg)](https://drive.google.com/file/d/1-k1kQWv2bcY4y-GO6ZJZvzP8-Z2Uc33Q/view)- **Slides Overview:** [![Slides](https://img.shields.io/badge/ %20Slides-Google-blue.svg)](https://docs.google.com/presentation/d/1mVGKNP_6rRCzFrcCEjO4WKDWorDyrl0JHLBCvOFSaMc)- **Live Demo/GitHub Pages:** [![Live](https://img.shields.io/badge/ %20Live-Demo-green.svg)](#)--
## 
.--
## 
 Repo Structure
 hw/                   # Verilog RTL
 sim/                  # Testbenches + DO file
 scripts/              # Tcl & Bash automation
 docs/                 # Diagrams & screenshots
 reports/              # (auto) timing & utilization
 .github/              # CI workflows (ci.yml)
 .gitignore
 README.md
 Key Features- **Real-Time Audio**: PWM tone generator per key  - **VGA Graphics**: 640×480 tile display with scroll logic  - **Debounced Controls**: 16-button matrix input  - **One-Click Automation**: Quartus & ModelSim via Tcl + Bash--
## 
```bash
 Getting Started
 git clone https://github.com/hyeonjijung1/fpga-piano-audio-system.git
 cd fpga-piano-audio-system
 ./scripts/build.sh
 ```- **Reports**: `reports/timing_max.txt` & `reports/utilization.txt`  - **Clock**: 100 MHz  
- **Slack**: +0.12 ns  - **LUT Util.**: <10%  - **BRAM Util.**: <5%--
## 
 Results & Metrics
 | Metric               | Value                         |
 |----------------------|-------------------------------|
 | **F<sub>max</sub>**  | 100 MHz (10 ns period)        |
 | **Slack**            | +0.12 ns                      |
 | **LUT Util.**        | ≈ 9 %                         |
 | **BRAM Util.**       | ≈ 4 %                         |
 *(Auto-generated in `reports/` via CI.)*--
## 
 CI / Automation
 All changes trigger GitHub Actions to:
 1. **Compile** in Quartus II  
2. **Simulate** in ModelSim  
3. **Publish** timing/util reports as artifacts  
See `.github/workflows/ci.yml`.--
## 
 About the Author
 **Hyeonji Jung**  – FPGA Design Intern, Embedded AV Systems @ Korea University (May 2025 – Sep 2025)  – [LinkedIn](https://www.linkedin.com/in/hyeonjijung-uoft) • [Email](mailto:youremail@utoronto.ca)--
## 
 License
 Distributed under the MIT License. See [LICENSE](LICENSE) for details.

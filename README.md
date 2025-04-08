# FIFO-design-and-UVM-verification
## 📘 Overview

This project demonstrates the design and functional verification of a **synchronous FIFO (First-In-First-Out)** buffer using **SystemVerilog** for RTL and **UVM (Universal Verification Methodology)** for verification. It showcases industry-standard digital design and verification practices in a clean, modular setup.

---
## 🛠️ FIFO Design Details

- **Type:** Synchronous FIFO
- **Width:** Parameterized (default: 8 bits)
- **Depth:** Parameterized (default: 16 entries)
- **Inputs:**
  - `clk`, `rst_n`
  - `wr_en`, `rd_en`
  - `din`
- **Outputs:**
  - `dout`
  - `full`, `empty`, `almost_full`, `almost_empty`

The FIFO design includes logic for pointer management, full/empty detection, and optional almost-full/empty flags.

---

## 🔍 Verification Architecture (UVM)

The UVM testbench is built using a standard layered approach:

| Component     | Description |
|---------------|-------------|
| **Sequence**     | Generates both directed and constrained-random FIFO operations |
| **Driver**       | Drives transactions to the FIFO interface |
| **Monitor**      | Observes interface signals and sends transactions to scoreboard |
| **Scoreboard**   | Checks DUT output against expected behavior |
| **Coverage**     | Collects functional and code coverage data |

### ✔️ Test Cases Implemented

- Reset and initialization
- Basic write/read operations
- Simultaneous read/write
- Boundary testing: full, empty, overflow, underflow
- Stress test with random transactions
- Back-to-back operations without idle cycles

---

## 📊 Simulation Results

- ✅ All tests passed
- 📈 Functional and code coverage achieved high completion rates
- 🔒 Assertions integrated for protocol and boundary checking

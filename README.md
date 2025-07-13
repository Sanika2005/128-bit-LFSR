# 🔁 128-bit Linear Feedback Shift Register (LFSR) on FPGA using ILA & VIO

## 📘 Description

This project implements a **128-bit Linear Feedback Shift Register (LFSR)** in Verilog, based on a primitive polynomial. The design is built to run on FPGA and includes integration with Xilinx’s **ILA** (Integrated Logic Analyzer) and **VIO** (Virtual Input/Output) IP cores for real-time debugging and control.

It allows:

- Resetting to a known default seed
- Loading a custom seed via VIO
- Enabling/disabling the LFSR shift operation
- Observing all key signals live using ILA

---

## 🔢 Polynomial Used

The feedback polynomial used in this design is:

P(x) = x^128 + x^103 + x^76 + x^51 + x^25 + x + 1

This translates to the feedback bit being calculated as:

feedback = lfsr_out[127] ^ lfsr_out[102] ^ lfsr_out[75] ^
lfsr_out[50] ^ lfsr_out[24] ^ lfsr_out[1] ^ lfsr_out[0];

---

## 🧠 Working Principle

- On every **positive edge** of the clock:
  - If `reset = 1`: The LFSR is loaded with a fixed default seed `0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF`
  - Else if `load_seed = 1`: The LFSR is loaded with a custom 128-bit seed (set via VIO)
  - Else if `enable = 1`: The LFSR shifts left by 1 and inserts the feedback bit at LSB

---

## ⚙️ Modules

### ✅ `lfsr.v`

Implements the 128-bit LFSR logic with parameters:
- `clk` (input): clock signal
- `reset` (input): resets LFSR to default seed
- `load_seed` (input): loads custom seed
- `enable` (input): enables shift operation
- `seed` (input): 128-bit custom seed
- `lfsr_out` (output): 128-bit output of LFSR

### ✅ `top.v`

Connects:
- `lfsr.v` to core logic
- `vio_1` to control: `seed`, `reset`, `enable`, `load_seed`
- `ila_0` to monitor: `seed`, `lfsr_out`, `reset`, `enable`, `load_seed`

---

## 🛠️ Simulation & Testing Steps (Using Vivado)

1. **Program the FPGA**
2. **In Hardware Manager:**
   - Open VIO console
3. **Test Cases:**
   - ✅ Set `reset = 1`, observe known default seed in ILA
   - ✅ Set `load_seed = 1` and provide a custom seed from VIO
   - ✅ Set `enable = 1`, observe shifting in `lfsr_out` every clock cycle

---

## 🔍 Real-Time Debugging Setup

| IP Core | Function |
|--------|----------|
| VIO    | Used to control `seed`, `reset`, `enable`, `load_seed` (inputs) |
| ILA    | Used to monitor `seed`, `lfsr_out`, `reset`, `enable`, `load_seed` |

---

## 📁 File Structure

.
├── top.v # Top-level module with ILA and VIO integration
├── lfsr.v # LFSR logic (128-bit)
├── constraints.xdc # Pin constraints file (template)
├── README.md # Project documentation

---

## 💡 Applications

- Cryptography
- Pseudo-random number generation
- Spread-spectrum communications
- Data whitening and scrambling


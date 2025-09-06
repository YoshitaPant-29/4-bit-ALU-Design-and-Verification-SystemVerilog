# 4-bit-ALU-Design-and-Verification---SystemVerilog
ALU Verification using SystemVerilog (Assertions + Coverage) Designed a 4-bit ALU in Verilog and built a SystemVerilog self-checking testbench with random stimulus, assertions, and functional coverage to verify correctness of arithmetic and logic operations.

# ALU Verification using SystemVerilog (Assertions + Coverage)

## 📌 Project Overview
This project implements and verifies a **4-bit Arithmetic Logic Unit (ALU)**.  
The ALU supports basic arithmetic and logic operations such as **ADD, SUB, AND, OR, XOR, Shift Left, Shift Right, and Pass-through**.  

The focus is on **Verification**:
- ✅ Self-checking testbench  
- ✅ Random stimulus generation  
- ✅ Assertions for correctness  
- ✅ Functional coverage to ensure all operations and edge cases are tested  

---

## 🛠 Features
- **RTL Design**: 4-bit ALU in Verilog
- **Verification**: SystemVerilog testbench with:
  - Constrained-random input generation
  - Assertions to catch mismatches
  - Functional coverage to track tested operations
- **Tools**: Tested on [EDA Playground](https://www.edaplayground.com)

---

## Output
### Verification Results
- ✅ 20 random tests passed (Assertions: no mismatches found)
- 📊 Functional Coverage: 72.5% (all ALU operations partially covered)
- 🎯 Achieved 100% opcode coverage with extended random runs
- 🔍 Waveforms visualized in EPWave (dump.vcd)

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
- **Tools**: Tested on [EDA Playground]

## Output
### Verification Results
- ✅ 20 random tests passed (Assertions: no mismatches found)
- 📊 Functional Coverage: 72.5% (all ALU operations partially covered)
- 🎯 Achieved 100% opcode coverage with extended random runs
- 🔍 Waveforms visualized in EPWave (dump.vcd)
- The verification strategy was executed in 3 phases. Initial random testing achieved 72.5% coverage, increased randomization raised it to 98.75%, and finally hybrid (random + directed) testing closed coverage at 100%. This demonstrates industry-standard coverage-driven verification flow

### Case 1: Initial Random Tests

- Used 20 random tests only.
- Coverage achieved: 72.50%.
Insight: Random alone does not guarantee hitting all bins (some operations/flags not exercised).

### 🔹 Case 2: Increased Randomization

- Increased random test count (e.g., repeat(200) or higher).
- Coverage improved to 98.75%.
Insight: More random tests close gaps, but some edge cases (like a=0, b=0 for certain ops) were still missed.

### 🔹 Case 3: Hybrid (Random + Directed Tests)

- Added a directed loop to force all opcodes and corner cases.
- Achieved 100% functional coverage ✅.
Insight: True verification success comes from combining constrained-random with directed tests.

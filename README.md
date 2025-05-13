# **32-bit RISC Processor Project** 🔧📘  
*Spring 2025 – CEE210 / CEE216 – Fayoum University*

---

## **Contents**  
- [Part 1: Single-Cycle Processor](#part-1-single-cycle-processor)  
  - [Overview](#overview)  
  - [Instruction Set Architecture](#instruction-set-architecture)  
  - [Features](#features)  
  - [Design & Implementation](#design--implementation)  
  - [Simulation & Testing](#simulation--testing)  
- [Part 2: Pipelined Processor](#part-2-pipelined-processor)  
  - [Overview](#overview-1)  
  - [Pipeline Stages](#pipeline-stages)  
  - [Hazards & Solutions](#hazards--solutions)  
  - [Testing & Results](#testing--results)  
- [Usage](#usage)  
- [Download](#download)  
- [Team](#team)  

---

# **Part 1: Single-Cycle Processor**  

## **Overview**  
The single-cycle RISC processor was implemented using **Logisim** and designed to execute every instruction in exactly **one clock cycle**. The ISA is MIPS-like and supports arithmetic, logic, memory, and control operations.

✔️ Instruction Fetch  
✔️ Decode & Execute  
✔️ Memory Access  
✔️ Write-back — all in **1 cycle**

---

## **Instruction Set Architecture**

- **Registers**: 32 registers (R0–R31), where R0 is hardwired to 0.
- **Instruction Width**: 32 bits
- **Formats**:  
  - `R-type`: `Opcode | Rd | RS1 | RS2 | Func`  
  - `I-type`: `Opcode | Rd | RS1 | Imm16`  
  - `SB-type`: `Opcode | RS1 | RS2 | ImmU | ImmL`
- **Memory**: Word-addressable instruction and data memory
- **Supported Instructions**:  
  - Arithmetic: `ADD`, `SUB`, `MUL`  
  - Logic: `AND`, `OR`, `XOR`, `NOR`  
  - Shift: `SLL`, `SRL`, `SRA`, `ROR`  
  - Immediate: `ADDI`, `SLTI`, `ANDI`, `XORI`, `SET`, `SSET`  
  - Branches: `BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`  
  - Memory: `LW`, `SW`  
  - Jump: `JALR`

---

## **Features**

- 🧠 Fully modular datapath: PC, ALU, Register File, Control Unit
- 🧪 Verified using custom programs and instruction traces
- 📏 Clean instruction formats and control signals
- 🧮 Uses Logisim subcircuits for each functional unit

---

## **Design & Implementation**

- **Control Unit**: Generates all control signals based on opcode.
- **ALU**: Arithmetic, logical, shift, set, and branch operations.
- **Instruction Splitter**: Decodes instructions into all fields.
- **Bit Extender**: Sign/zero extends immediates as required.
- **Data Memory**: 1-cycle access, word-aligned, used by `LW/SW`.

---

## **Simulation & Testing**

- Full test suite covering:
  - All arithmetic and logical operations
  - Control flow instructions (branches, jumps)
  - Data movement: `LW`, `SW`, `SET`, `SSET`
- Example Program:
  - Initializes registers
  - Loads memory
  - Sums values using a loop
  - Tests `SLT`, `BEQ`, `JALR`

---

# **Part 2: Pipelined Processor**

## **Overview**

The pipelined processor is a refined version of the single-cycle processor with **5 execution stages**, allowing multiple instructions to overlap execution for **higher throughput**.

Pipeline Stages:
✔️ Instruction Fetch (IF)  
✔️ Instruction Decode (ID)  
✔️ Execute (EX)  
✔️ Memory Access (MEM)  
✔️ Write-Back (WB)

---

## **Pipeline Stages**

- **IF/ID Register**: Stores fetched instruction and PC.
- **ID/EX Register**: Stores decoded fields and control signals.
- **EX/MEM Register**: Carries ALU results and memory controls.
- **MEM/WB Register**: Holds memory/ALU output for write-back.

Each pipeline register holds data and control signals to propagate correctly.

---

## **Hazards & Solutions**

### ✅ **Data Hazards**
- Handled using **forwarding unit** for EX–EX, MEM–EX cases.

### 🚫 **Load-Use Hazard**
- 1-cycle **stall** added if instruction after `LW` depends on result.

### 🔁 **Control Hazards**
- Conditional branches (`BEQ`, `BLT`, etc.) flush incorrect instructions.
- `JALR` handles indirect jump logic with correct PC and link register.

---

## **Testing & Results**

- **Forwarding Logic** tested with dependent instruction chains
- **Pipeline Stalls** verified with `LW` followed by dependent op
- **Branch Handling** validated by tracking PC and control updates
- **No instruction loss** observed in sequential loop execution

> Bonus: Includes design provisions for **2-bit dynamic branch predictor** (optional).

---

# **Usage**

### ✅ Run the Processor

1. Open `.circ` file in **Logisim Evolution**
2. Load program into ROM (machine code)
3. Run clock cycle-by-cycle or auto
4. Observe pipeline stages and register/memory state

### 💻 Sample Assembly

```asm
SET R1, 0x1234
SSET R1, 0x5678
ADDI R2, R1, 5
SW R2, 0(R0)
```

---

# **Download**

- 🎞 [Phase 1 Video](https://drive.google.com/file/d/1zgXdttJMgJP_WHMIrIYan-U5UsAn0INm/view)  
- 📁 [Phase 2 Video & Array Test](https://drive.google.com/drive/folders/1QQcOcezXfJSpcG7dwhKZvbHQ2UYC4hIL?usp=sharing)  
- 📦 [GitHub Repository](https://github.com/0xMotazMohamed/RISC-32bit-Processor)

---

# **Team**

- 👨‍💻 **[Moataz Mohamed Ali](https://www.linkedin.com/in/moataz-m-ali-73045b277/)** 
- 👨‍💻 **[Abdelrahman Zaki Ibrahim](https://www.linkedin.com/in/abdelrahman-zaki-ibrahim/)**
- 👨‍💻 **[Abdullah Mostafa Gomaa](https://www.linkedin.com/in/abdullah-mostafa-8b940934a/)** 

---

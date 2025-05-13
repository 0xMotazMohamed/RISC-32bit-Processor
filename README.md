# **Pipelined 32-bit RISC Processor** 🔧📘

## **Contents**  
- [Overview](#overview)  
- [Instruction Set Architecture](#instruction-set-architecture)  
- [Features](#features)  
- [Design & Implementation](#design--implementation)  
- [Simulation & Testing](#simulation--testing)  
- [Usage](#usage)  
- [Download](#download)  
- [Team](#team)  

---

## **Overview**  

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Logisim_icon_2020.svg/1024px-Logisim_icon_2020.svg.png" alt="Logisim" width="200" height="200">

This repository presents the **Pipelined 32-bit RISC Processor** developed using **Logisim** as part of the Spring 2025 CEE210/CEE216 Computer Engineering course at Fayoum University.

The processor is built from scratch and supports:  
✔️ A complete custom ISA  
✔️ Full single-cycle and pipelined datapaths  
✔️ Hazard detection, data forwarding, and branching control  
✔️ Complete simulation testbenches  

---

## **Instruction Set Architecture**

- 🧠 **32 Registers**: `R0`–`R31`, where `R0` is hardwired to zero.
- 📏 **Instruction Width**: 32-bit, word-aligned.
- 🧮 **Instruction Types**:
  - **R-type**: Arithmetic, logical, comparison.
  - **I-type**: Immediate arithmetic, logic, memory access.
  - **SB-type**: Branch and Store instructions.
- 🧾 **Special Instructions**: `SET`, `SSET`, `JALR`, etc.
- 📦 **Memory**:
  - Instruction Memory: 2²⁰ word-addressable
  - Data Memory: Word-aligned, accessed via `LW`, `SW`

---

## **Features**  

- ✅ **Custom ISA** (MIPS-inspired)
- 🧩 **Single-Cycle Implementation**: All stages executed in one cycle.
- 🚀 **Five-Stage Pipelined Design**:
  - IF → ID → EX → MEM → WB
- 🧠 **Forwarding & Hazard Detection**:
  - Data Hazard resolution
  - Branch Hazard handling
- 🧪 **Unit & Integration Testing**: Instructions verified with memory snapshots
- 🛠 **Assembler & Programs**: Sample codes included

---

## **Design & Implementation**

### 🔩 **Datapath Components**
- **Program Counter**: 20-bit, sequential or branch-based increment.
- **Instruction Splitter**: Decodes into opcode, function, registers, and immediates.
- **Register File**: Dual-read, single-write with 32 registers.
- **Bit Extender**: Supports sign and zero-extension.
- **ALU**: Modular (Arithmetic, Logic, Shift, SET).
- **Data Memory**: 32-bit word-addressable RAM.
- **Control Unit**: Generates signals based on opcode & function fields.
- **Pipeline Registers**: IF/ID, ID/EX, EX/MEM, MEM/WB.

### ⚙️ **Control Signals**
| Signal        | Purpose                                           |
|---------------|---------------------------------------------------|
| `RegWrite`    | Enables register writing                          |
| `MemRead`     | Enable memory read                                |
| `MemWrite`    | Enable memory write                               |
| `ALUSrc`      | Immediate or register source for ALU              |
| `MemtoReg`    | Selects write-back source: ALU, Mem, PC+1         |
| `Branch`/`Jump` | Controls PC update flow                          |
| `Extender_Op` | Sign vs. Zero extension for immediate             |
| `ImmSelect`   | Chooses immediate format                          |

---

## **Simulation & Testing**

- ✔️ **Unit Tests**:
  - Register File
  - ALU (Arithmetic, Logic, Shift, Branch, SET)
  - Control Unit
- ✔️ **Instruction Testing**:
  - All ISA instructions simulated and validated
- ✔️ **Program Testing**:
  - Complete programs executed
  - Example: Array sum using procedure and loop control
- 🛑 **Hazard Handling**:
  - Load-use stall: 1 cycle
  - Control hazard: Flush or predict

---

## **Usage**

### 📥 Loading the Processor

1. Open `PipelinedProcessor.circ` using **Logisim Evolution**
2. Load memory:
   - Instruction memory (`ROM`)
   - Data memory (`RAM`)
3. Set the `CLK` to single-step or continuous run mode

### 🧾 Assembly Code Example

```asm
SET R1, 0x1234       ; Load lower 16-bit
SSET R1, 0x5678      ; Set upper 16-bit → R1 = 0x12345678
ADDI R2, R1, 5       ; R2 = R1 + 5
SW R2, 0(R0)         ; Store R2 to memory[0]
```

Use the assembler script provided in the repository to convert your `.asm` file into `.bin`.

---

## **Download**

Access the project and resources from the following links:

- 🎞 [Phase 1 Demo Video](https://drive.google.com/file/d/1zgXdttJMgJP_WHMIrIYan-U5UsAn0INm/view)  
- 📁 [Phase 2 Resources](https://drive.google.com/drive/folders/1QQcOcezXfJSpcG7dwhKZvbHQ2UYC4hIL?usp=sharing)  
- 📦 [GitHub Repository](https://github.com/0xMotazMohamed/RISC-32bit-Processor)

---

## **Team**  

- 👨‍💻 **[Moataz Mohamed Ali](https://www.linkedin.com/in/moataz-m-ali-73045b277/)** – Component Architecture  
- 👨‍💻 **[Abdelrahman Zaki Ibrahim](https://www.linkedin.com/in/abdelrahman-zaki-ibrahim/)** – Hazard Logic & Testing  
- 👨‍💻 **[Abdullah Mostafa Gomaa](https://www.linkedin.com/in/abdullah-mostafa-8b940934a/)** – Pipeline & Assembly Interface  

---

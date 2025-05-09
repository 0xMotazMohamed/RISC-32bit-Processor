# === Initialize registers ===
SET   R1, 0x1000        ; R1 = 0x00001000
SSET  R1, 0x2000        ; R1 = 0x10002000   (combine SET+SSET)
SET   R2, 5             ; R2 = 0x5
SET   R3, 3             ; R3 = 0x3

# === Arithmetic & Logic (R‑type) ===
ADD   R4,  R2, R3       ; R4 = R2 + R3       =  0x8
SUB   R5,  R4, R3       ; R5 = R4 - R3       =  0x5
XOR   R6,  R4, R5       ; R6 = 8  ^ 5        =  0xd
OR    R7,  R6, R2       ; R7 = 13 | 5        =  0xd
AND   R8,  R7, R5       ; R8 = 13 & 5        =  0x5
NOR   R9,  R2, R3       ; R9 = ~(5 | 3)      =  0xfffffff8
MUL   R10, R2, R3       ; R10= 5 * 3         =  0xf
SEQ   R11, R10, R6      ; R11= (15==13)?0    =  0
SLT   R12, R3, R2       ; R12= (3<5)?1       =  0x1
SLTU  R13, R3, R2       ; R13= (u3<u5)?1     =  0x1

# === Shifts & Rotates (R‑type) ===
SLL   R14, R3, R2       ; R14= 3 << (5&0x1F)    = 0x60
SRL   R15, R14, R2      ; R15= 96 >>u 5         =  0x3
SRA   R16, R14, R2      ; R16= 96 >>s 5         =  0x3
ROR   R17, R14, R2      ; R17= rot_right(96,5)  = 0x3

# === Immediate & Shift‑Imm (I‑type) ===
SLLI  R18, R17, 2       ; R18= R17 << 2         =  0xc
SRLI  R19, R18, 1       ; R19= R18 >>u 1        =  0x6
SRAI  R20, R18, 1       ; R20= R18 >>s 1        =  0x6
RORI  R21, R18, 4       ; R21= rot_right(R18,4) =  0xc0000000
ADDI  R22, R21, 100     ; R22= R21 + 100        =  0xc0000064
SLTI  R23, R22, 200     ; R23= (R22<200)?1:0    =  0x1
SLTIU R24, R22, 200     ; R24= (uR22<u200)?1:0  =  0
SEQI  R25, R23, 1       ; R25= (R23==1)?1:0     =  0x1
XORI  R26, R25, 0xFF    ; R26= R25 ^ 0xFF       =  0xfe
ORI   R27, R26, 0x0F    ; R27= R26 | 0x0F       =  0xff
ANDI  R28, R27, 0xF0    ; R28= R27 & 0xF0       =  0xf0
NORI  R29, R28, 0xAA    ; R29= ~(R28 | 0xAA)    =  0xffffff05
SET   R30, -1           ; R30 = 0xFFFFFFFF      =  0xffffffff
SSET  R31, 0x00FF       ; R31[15:0]             =  0xff

# === Memory operations ===
SW    R4,  0(R1)        ; MEM[R1+0] = R4 =  8
LW    R8,  0(R1)        ; R8 = MEM[R1+0]     =  0x8
SW    R5,  4(R1)        ; MEM[R1+4] = R5 =  5
LW    R9,  4(R1)        ; R9 = MEM[R1+4]     =  0x5

# === Branch tests (SB‑type) ===
BEQ   R8,  R4, +2       ; true → skip next
ADDI  R10, R0, 111      ; (skipped)
ADDI  R10, R0, 222      ; R10 = 0xde

BNE   R9,  R5, +2       ; false → fall‑through
ADDI  R11, R0, 333      ; R11 = 0x14d
ADDI  R11, R0, 444      ; R11 = 0x1bc

BLT   R3,  R2, +2       ; true → skip next
ADDI  R12, R0, 55       ; (skipped) 
ADDI  R12, R0, 66       ; R12 = 0x42

BGE   R3,  R2, +2       ; false → fall-through
ADDI  R13, R0, 77       ; R13 = 0x4d
ADDI  R13, R0, 88       ; R13 = 0x58

BLTU  R3,  R2, +2       ; true → skip next
ADDI  R14, R0, 99       ; (skipped)
ADDI  R14, R0, 100      ; R14 = 0x64

BGEU  R3,  R2, +2       ; false → fall-through
ADDI  R15, R0, 111      ; R15 = 0x6f
ADDI  R15, R0, 222      ; R15 = 0xde

# === Jump & Link Register (JALR) ===
JALR R1, R2, 4                  

ADD R4, R1, R2      ; R4 = R1 + R2 = 15
SUB R5, R3, R1      ; R5 = R3 - R1 = 10
AND R6, R1, R3      ; R6 = 5 & 15 = 5
OR R7, R2, R3       ; R7 = 10 | 15 = 15
XOR R8, R1, R2      ; R8 = 5 ^ 10 = 15
SLT R9, R1, R2      ; R9 = (5 < 10) = 1
SEQ R10, R2, R2     ; R10 = (10 == 10) = 1
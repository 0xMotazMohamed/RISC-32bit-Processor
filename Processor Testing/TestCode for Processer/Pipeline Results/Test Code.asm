Hex : 

0001004D 00010011 00010051 000A008D 00020091 128900CD 45AC00CE 00230711
0500010D 7342010E 00240751 0384004D 1234020D 5678020E 00140945 012508C0
00834100 00000050 00010090 000200D0 00A42100 00841100 00C31180 000030D2
00820880 FFE00712 00040011 01A31280 00245380 004453C0 00057684 002501CF
4545024D 4545028D 00095095 FFFF0DCB 00000012 01431140 00000050 00050890
000608D0 01631100 00040011 0000380F


Analysis Code : 


# -------- Memory Initialization --------
SET   R1, 0x0001          ; R1      = 0x00000001
SW    R1, 0(R0)           ; Mem[0]  = 0x00000001
SW    R1, 1(R0)           ; Mem[1]  = 0x00000001

SET   R2, 0x000A          ; R2      = 0x0000000A
SW    R2, 2(R0)           ; Mem[2]  = 0x0000000A

SET   R3, 0x1289          ; R3      = 0x00001289
SSET  R3, 0x45AC          ; R3      = 0x128945AC
SW    R3, 60(R0)          ; Mem[60] = 0x128945AC

SET   R4, 0x0500          ; R4      = 0x00000500
SSET  R4, 0x7342          ; R4      = 0x05007342
SW    R4, 61(R0)          ; Mem[61] = 0x05007342

# -------- Initialize Values --------
SET   R1, 0x0384          ; R1  = 0x00000384 (lower 16 bits)
SET   R8, 0x1234          ; R8  = 0x00001234
SSET  R8, 0x5678          ; R8  = 0x12345678 (upper half set)

# -------- Arithmetic & Logic --------
ADDI  R5, R1, 20          ; R5  = R1 + 20 = 0x398
XOR   R3, R1, R5          ; R3  = R1 ^ R5 = 0x1c
ADD   R4, R8, R3          ; R4  = R8 + R3 = 0x12345694

# -------- Load Memory --------
LW    R1, 0(R0)           ; R1  = Mem[0] = 0x00000001
LW    R2, 1(R0)           ; R2  = Mem[1] = 0x00000001
LW    R3, 2(R0)           ; R3  = Mem[2] = 0x0000000A
SUB   R4, R4, R4          ; R4  = 0

# -------- Loop: Sum from R2 to R3 --------
Loop1:
ADD   R4, R2, R4          ; R4 += R2
SLT   R6, R2, R3          ; R6  = (R2 < R3) ? 1 : 0
BEQ   R6, R0, done        ; if R6 == 0 → done
ADD   R2, R1, R2          ; R2 += R1
BEQ   R0, R0, Loop1       ; unconditional jump to Loop1

# -------- Done --------
done:
SW    R4, 0(R0)           ; Mem[0] = R4 = 0x37

# -------- Multiply and Shifts --------
MUL   R10, R2, R3         ; R10 = R2 * R3             = 0x64
SRL   R14, R10, R4        ; R14 = R10 >> R4 (logical) = 0
SRA   R15, R10, R4        ; R15 = R10 >> R4 (arith)   = 0
RORI  R26, R14, 5         ; R26 = ROR(R14, 5)         = 0

# -------- Function Call --------
JALR  R7, R0, func        ; Jump to func, save PC+1 in R7

# -------- Comparison and Branching --------
SET   R9, 0x4545          ; R9  = 0x00004545
SET   R10, 0x4545         ; R10 = 0x00004545
BGE   R10, R9, L1         ; Branch if R10 >= R9 (taken)
ANDI  R23, R1, 0xFFFF     ; R23 = R1 & 0x0000FFFF (skiped)

L1:
BEQ   R0, R0, L1          ; Infinite loop (halt)

# -------- Function Definition --------
func:
OR    R5, R2, R3          ; R5  = R2 | R3     = 0xa
LW    R1, 0(R0)           ; R1  = Mem[0]      = 0x37
LW    R2, 5(R1)           ; R2  = Mem[R1 + 5] = 0x128945AC
LW    R3, 6(R1)           ; R3  = Mem[R1 + 6] = 0x05007342
AND   R4, R2, R3          ; R4  = R2 & R3     = 0x4100
SW    R4, 0(R0)           ; Mem[0] = R4       = 
JALR  R0, R7, 0           ; Return to caller (JR R7)
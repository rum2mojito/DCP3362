// A073708 石育瑋
// *****global variables*****
`define ZeroWord 32'h00000000

// OP code
`define R_FORMAT 6'b000000
`define ADDI 6'b001000
`define SLTI 6'b001010
`define BEQ 6'b000100

// ALU OP
`define ALU_OP_R 3'b010
`define ALU_OP_ADDI 3'b100
`define ALU_OP_SLTI 3'b101
`define ALU_OP_BEQ 3'b001

// shamt
`define NOT_SHIFT 5'b00000

// ALU FUNCT
`define ALU_FUNCT_ADD 6'b100000
`define ALU_FUNCT_SUB 6'b100010
`define ALU_FUNCT_AND 6'b100100
`define ALU_FUNCT_OR 6'b100101
`define ALU_FUNCT_SLT 6'b101010

// ALU CTRL
`define AND_CTRL 4'b0000
`define OR_CTRL 4'b0001
`define ADD_CTRL 4'b0010
`define SUB_CTRL 4'b0110
`define NOR_CTRL 4'b1100
`define SLT_CTRL 4'b0111

// ALU code
`define AND_ALU 2'b00
`define OR_ALU 2'b01
`define ADD_ALU 2'b10
`define SLT_ALU 2'b11
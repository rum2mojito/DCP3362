// A073708 YUWEI, SHIH
//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`include "Constant.v"

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	Jump_o,
	MemToReg_o,
	MemRead_o,
	MemWrite_o,
	BranchType_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output  [1:0]       RegDst_o;
output         Branch_o;
output         Jump_o;
output [1:0]   MemToReg_o;
output         MemRead_o;
output         MemWrite_o;
output    [1:0]     BranchType_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg     [1:0]       RegDst_o;
reg            Branch_o;
reg            Jump_o;
reg    [1:0]   MemToReg_o;
reg            MemRead_o;
reg            MemWrite_o;
reg     [1:0]       BranchType_o;

//Parameter


//Main function
always@(*) begin
	if(instr_op_i == `R_FORMAT) begin
		ALU_op_o <= `ALU_OP_R;
		ALUSrc_o <= 1'b0;
		RegWrite_o <= 1'b1;
		RegDst_o <= 2'b01;
		Branch_o <= 1'b0;
		Jump_o <= 1'b1;
		MemToReg_o <= 2'b00;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		BranchType_o <= 2'bxx;
	end else if(instr_op_i == `ADDI) begin
		ALU_op_o <= `ALU_OP_ADDI;
		ALUSrc_o <= 1'b1;
		RegWrite_o <= 1'b1;
		RegDst_o <= 2'b00;
		Branch_o <= 1'b0;
		Jump_o <= 1'b1;
		MemToReg_o <= 2'b00;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		BranchType_o <= 2'bxx;
	end else if(instr_op_i == `SLTI) begin
		ALU_op_o <= `ALU_OP_SLTI;
		ALUSrc_o <= 1'b1;
		RegWrite_o <= 1'b1;
		RegDst_o <= 2'b00;
		Branch_o <= 1'b0;
		Jump_o <= 1'b1;
		MemToReg_o <= 2'b00;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		BranchType_o <= 1'bx;
	end else if(instr_op_i == `BEQ) begin
		ALU_op_o <= `ALU_OP_BEQ;
		ALUSrc_o <= 1'b0;
		RegWrite_o <= 1'b0;
		RegDst_o <= 2'b00;
		Branch_o <= 1'b1;
		Jump_o <= 1'b1;
		MemToReg_o <= 2'bxx;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		BranchType_o <= 2'b00;
	end else if(instr_op_i == `LW) begin
		ALU_op_o <= `ALU_OP_LW_SW;
		ALUSrc_o <= 1'b1;
		RegWrite_o <= 1'b1;
		RegDst_o <= 2'b00;
		Branch_o <= 1'b0;
		Jump_o <= 1'b1;
		MemToReg_o <= 2'b01;
		MemRead_o <= 1'b1;
		MemWrite_o <= 1'b0;
		BranchType_o <= 2'bxx;
	end else if(instr_op_i == `SW) begin
		ALU_op_o <= `ALU_OP_LW_SW;
		ALUSrc_o <= 1'b1;
		RegWrite_o <= 1'b0;
		RegDst_o <= 2'bxx;
		Branch_o <= 1'b0;
		Jump_o <= 1'b1;
		MemToReg_o <= 2'bxx;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b1;
		BranchType_o <= 2'bxx;
	end else if(instr_op_i == `JUMP) begin
		ALU_op_o <= 3'bxxx;
		ALUSrc_o <= 1'bx;
		RegWrite_o <= 1'bx;
		RegDst_o <= 2'bxx;
		Branch_o <= 1'bx;
		Jump_o <= 1'b0;
		MemToReg_o <= 2'bxx;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		BranchType_o <= 2'bxx;
	end else if(instr_op_i == `JAL) begin
		ALU_op_o <= 3'bxxx;
		ALUSrc_o <= 1'bx;
		RegWrite_o <= 1'b1;
		RegDst_o <= 2'b10;
		Branch_o <= 1'bx;
		Jump_o <= 1'b0;
		MemToReg_o <= 2'b11;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		BranchType_o <= 2'bxx;
	end else begin
		ALU_op_o <= 3'bxxx;
		ALUSrc_o <= 1'bx;
		RegWrite_o <= 1'bx;
		RegDst_o <= 2'bxx;
		Branch_o <= 1'bx;
		Jump_o <= 1'bx;
		MemToReg_o <= 2'bxx;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		BranchType_o <= 2'bxx;
	end
end

endmodule





                    
                    
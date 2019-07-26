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
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter


//Main function
always@(*) begin
	if(instr_op_i == `R_FORMAT) begin
		ALU_op_o <= `ALU_OP_R;
		ALUSrc_o <= 1'b0;
		RegWrite_o <= 1'b1;
		RegDst_o <= 1'b1;
		Branch_o <= 1'b0;
	end else if(instr_op_i == `ADDI) begin
		ALU_op_o <= `ALU_OP_ADDI;
		ALUSrc_o <= 1'b1;
		RegWrite_o <= 1'b1;
		RegDst_o <= 1'b0;
		Branch_o <= 1'b0;
	end else if(instr_op_i == `SLTI) begin
		ALU_op_o <= `ALU_OP_SLTI;
		ALUSrc_o <= 1'b1;
		RegWrite_o <= 1'b1;
		RegDst_o <= 1'b0;
		Branch_o <= 1'b0;
	end else if(instr_op_i == `BEQ) begin
		ALU_op_o <= `ALU_OP_BEQ;
		ALUSrc_o <= 1'b0;
		RegWrite_o <= 1'b0;
		RegDst_o <= 1'b0;
		Branch_o <= 1'b1;
	end else begin
		ALU_op_o <= 3'bxxx;
		ALUSrc_o <= 1'bx;
		RegWrite_o <= 1'bx;
		RegDst_o <= 1'bx;
		Branch_o <= 1'bx;
	end
end

endmodule





                    
                    
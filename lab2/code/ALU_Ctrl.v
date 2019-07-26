// A073708 YUWEI, SHIH
//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`include "Constant.v"

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always@(*) begin
    if(ALUOp_i == `ALU_OP_R) begin
        if(funct_i == `ALU_FUNCT_ADD) begin
            ALUCtrl_o <= `ADD_CTRL;
        end else if(funct_i == `ALU_FUNCT_SUB) begin
            ALUCtrl_o <= `SUB_CTRL;
        end else if(funct_i == `ALU_FUNCT_AND) begin
            ALUCtrl_o <= `AND_CTRL;
        end else if(funct_i == `ALU_FUNCT_OR) begin
            ALUCtrl_o <= `OR_CTRL;
        end else if(funct_i == `ALU_FUNCT_SLT) begin
            ALUCtrl_o <= `SLT_CTRL;
        end
    end else if(ALUOp_i == `ALU_OP_ADDI) begin
        ALUCtrl_o <= `ADD_CTRL;
    end else if(ALUOp_i == `ALU_OP_SLTI) begin
        ALUCtrl_o <= `SLT_CTRL;
    end else if(ALUOp_i == `ALU_OP_BEQ) begin
        ALUCtrl_o <= `SUB_CTRL;
    end
end
endmodule     





                    
                    
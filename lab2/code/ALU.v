//Subject:     CO project 2 - ALU
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

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
assign zero_o = result_o == 0? 1:0;

//Main function
always@(src1_i or src2_i or ctrl_i) begin
	case(ctrl_i)
		`AND_CTRL: result_o <= src1_i & src2_i;
		`OR_CTRL: result_o <= src1_i | src2_i;
		`ADD_CTRL: result_o <= src1_i + src2_i;
		`SUB_CTRL: result_o <= src1_i - src2_i;
		`SLT_CTRL: result_o <= src1_i < src2_i? 1:0;
		default: result_o <= 0;
	endcase
end
endmodule





                    
                    
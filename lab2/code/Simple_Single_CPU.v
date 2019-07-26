// A073708 YUWEI, SHIH
//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire[31:0] pc_in_i;
wire[31:0] pc_out_o;
wire[31:0] pc_adder_o;
wire[31:0] instr_o;
wire[31:0] rs_data;
wire[31:0] rt_data;

wire[4:0] writeReg;

// op code
wire[5:0] op;

// funct
wire[5:0] funct;

// rs, rt, rd
wire[4:0] rs;
wire[4:0] rt;
wire[4:0] rd;
wire[15:0] immediate;

wire regDst_o;
wire branch;
wire aluSrc;
wire regWrite;
wire[2:0] aluOp;

wire[3:0] aluCtrl;

wire[31:0] signExtend_o;

wire[31:0] aluSrc2;

wire[31:0] aluResult;
wire aluZero;

wire[31:0] branch_o;
wire[31:0] branch_adder_o;

wire pc_select;

assign op = instr_o[31:26];
assign rs = instr_o[25:21];
assign rt = instr_o[20:16];
assign rd = instr_o[15:11];
assign immediate = instr_o[15:0];
assign funct = instr_o[5:0];
assign pc_select = branch & aluZero;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in_i) ,   
	    .pc_out_o(pc_out_o) 
	    );
	
Adder Adder1(
        .src1_i(pc_out_o),     
	    .src2_i(32'd4),     
	    .sum_o(pc_adder_o)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out_o),  
	    .instr_o(instr_o)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(rt),
        .data1_i(rd),
        .select_i(regDst_o),
        .data_o(writeReg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(rs) ,  
        .RTaddr_i(rt) ,  
        .RDaddr_i(writeReg) ,  
        .RDdata_i(aluResult)  , 
        .RegWrite_i(regWrite),
        .RSdata_o(rs_data) ,  
        .RTdata_o(rt_data)   
        );
	
Decoder Decoder(
        .instr_op_i(op), 
	    .RegWrite_o(regWrite), 
	    .ALU_op_o(aluOp),   
	    .ALUSrc_o(aluSrc),   
	    .RegDst_o(regDst_o),   
		.Branch_o(branch)   
	    );

ALU_Ctrl AC(
        .funct_i(funct),   
        .ALUOp_i(aluOp),   
        .ALUCtrl_o(aluCtrl) 
        );
	
Sign_Extend SE(
        .data_i(immediate),
        .data_o(signExtend_o)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(rt_data),
        .data1_i(signExtend_o),
        .select_i(aluSrc),
        .data_o(aluSrc2)
        );	
		
ALU ALU(
        .src1_i(rs_data),
	    .src2_i(aluSrc2),
	    .ctrl_i(aluCtrl),
	    .result_o(aluResult),
		.zero_o(aluZero)
	    );
		
Adder Adder2(
        .src1_i(pc_adder_o),     
	    .src2_i(branch_o),     
	    .sum_o(branch_adder_o)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(signExtend_o),
        .data_o(branch_o)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_adder_o),
        .data1_i(branch_adder_o),
        .select_i(pc_select),
        .data_o(pc_in_i)
        );	

endmodule
		  



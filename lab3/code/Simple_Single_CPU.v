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

wire[1:0] regDst_o;
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

wire Jump_o;
wire [1:0] MemToReg_o;
wire MemRead_o;
wire MemWrite_o;
wire[1:0] BranchType_o;

wire[31:0] MemData_o;
wire JumpReg_o;
wire[31:0] JumpRes;

assign op = instr_o[31:26];
assign rs = instr_o[25:21];
assign rt = instr_o[20:16];
assign rd = instr_o[15:11];
assign immediate = instr_o[15:0];
assign funct = instr_o[5:0];

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in_i) ,   
	    .pc_out_o(pc_out_o) 
	    );
	
Adder PC_Adder(
        .src1_i(pc_out_o),     
	    .src2_i(32'd4),     
	    .sum_o(pc_adder_o)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out_o),  
	    .instr_o(instr_o)    
	    );

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(rt),
        .data1_i(rd),
        .data2_i(32'hffffffff),
        .select_i(regDst_o),
        .data_o(writeReg)
        );	

wire [31:0] RegWrite_data;	
Reg_File Registers(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(rs) ,  
        .RTaddr_i(rt) ,  
        .RDaddr_i(writeReg) ,  
        .RDdata_i(RegWrite_data)  , 
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
        .Branch_o(branch),
        .Jump_o(Jump_o),
	.MemToReg_o(MemToReg_o),
	.MemRead_o(MemRead_o),
	.MemWrite_o(MemWrite_o),
	.BranchType_o(BranchType_o)  
        );

ALU_Ctrl AC(
        .funct_i(funct),   
        .ALUOp_i(aluOp),   
        .ALUCtrl_o(aluCtrl),
        .JumpReg_o(JumpReg_o) 
        );

MUX_2to1 #(.size(32)) Mux_Jump_Reg(
        .data0_i(JumpRes),
        .data1_i(rs_data),
        .select_i(JumpReg_o),
        .data_o(pc_in_i)
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

wire bgt;
wire beqg;
wire bne;
wire branch_res;
wire branch_select;
assign branch_select = branch & branch_res;
assign bgt = ~(aluZero & aluResult[31]);
assign beqg = ~aluResult[31];
assign ben = ~aluZero;
MUX_4to1 #(.size(1)) Mux_BranchSrc(
        .data0_i(aluZero),
        .data1_i(bgt),
        .data2_i(beqg),
        .data3_i(bne),
        .select_i(BranchType_o),
        .data_o(branch_res)
        );



Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(aluResult),
	.data_i(rt_data),
	.MemRead_i(MemRead_o),
	.MemWrite_i(MemWrite_o),
	.data_o(MemData_o)
	);

MUX_4to1 #(.size(32)) Mux_MemToRegSrc(
        .data0_i(aluResult),
        .data1_i(MemData_o),
        .data2_i(signExtend_o),
        .data3_i(pc_adder_o),
        .select_i(MemToReg_o),
        .data_o(RegWrite_data)
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

wire[31:0] Mux_PC_Source1_o;
wire[31:0] Jump_PC;
assign Jump_PC = { pc_out_o[31:28], instr_o[25:0], 2'b00};
MUX_2to1 #(.size(32)) Mux_PC_Source1(
        .data0_i(pc_adder_o),
        .data1_i(branch_adder_o),
        .select_i(branch_select),
        .data_o(Mux_PC_Source1_o)
        );

MUX_2to1 #(.size(32)) Mux_PC_Source2(
        .data0_i(Jump_PC),
        .data1_i(Mux_PC_Source1_o),
        .select_i(Jump_o),
        .data_o(JumpRes)
        );	

endmodule
		  
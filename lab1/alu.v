`timescale 1ns/1ps
`include "constant.v"

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2013
// Design Name:
// Module Name:    alu
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu(
           clk,           // system clock              (input)
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

    input           clk;
    input           rst_n;
    input  [32-1:0] src1;
    input  [32-1:0] src2;
    input   [4-1:0] ALU_control;
    //input   [3-1:0] bonus_control; 

    output [32-1:0] result;
    output          zero;
    output          cout;
    output          overflow;

    reg    [32-1:0] result;
    reg             zero;
    reg             cout;
    reg             overflow;

    // local variables
    wire[31:0]      carry_wire;
    wire[31:0]      result_wire;
    genvar i;

    // construct ALU from alu_top
    alu_top  alu_0(
        .src1(src1[0]),
        .src2(src2[0]),
        .less(!carry_wire[31]),
        .A_invert(ALU_control[3]),
        .B_invert(ALU_control[2]),
        .cin(1'b0),
        .operation(ALU_control[1:0]),
        .result(result_wire[0]),
        .cout(carry_wire[0])
    );
    for(i=1; i<32; i=i+1) begin: generate_alu_top
        alu_top  alu_k(
            .src1 (src1[i]),
            .src2 (src2[i]),
            .less (1'b0),
            .A_invert (ALU_control[3]),
            .B_invert (ALU_control[2]),
            .cin (carry_wire[i-1]),
            .operation (ALU_control[1:0]),
            .result (result_wire[i]),
            .cout (carry_wire[i])
        );
    end


    always@( posedge clk or negedge rst_n ) 
    begin
        if(rst_n) begin 
            // output
            if(ALU_control == `SUB_FUNCT) begin
                result <= result_wire + 32'h00000002;
            end else if(ALU_control == `SLT_FUNCT) begin
                if(result_wire < 32'hFFFFFFFE) begin
                    result <= 32'h00000001;
                end else begin
                    result <= 32'h00000000;
                end
            end else begin
                result <= result_wire;
            end
            
            cout <= carry_wire[31];

            if((carry_wire[31] == 1'b1) && (ALU_control == `ADD_FUNCT)) begin
                assign overflow = 1'b1;
            end else begin
                assign overflow = 1'b0;
            end

            if(result == `ZeroWord) begin
                assign zero = 1'b1;
            end else begin
                assign zero = 1'b0;
            end
        end
        else begin
            result <= `ZeroWord;
            zero <= 1'b0;
            cout <= 1'b0;
            overflow <= 1'b0;
        end
    end

endmodule
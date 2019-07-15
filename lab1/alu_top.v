// A073708 石育瑋
`timescale 1ns/1ps
`include "constant.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2013
// Design Name: 
// Module Name:    alu_top 
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

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
               );

    input         src1;
    input         src2;
    input         less;
    input         A_invert;
    input         B_invert;
    input         cin;
    input [2-1:0] operation;

    output        result;
    output        cout;

    reg           result;
    reg           cout;
    // local variables
    reg          src1_;
    reg          src2_;

    always@( src1 or src2 or operation or cin )
    begin
        // initial
        result <= 1'b0;
        cout <= 1'b0;
        // handle invert
        if(A_invert == 1'b1) begin
            src1_ <= !src1;
        end else begin
            src1_ <= src1;
        end

        if(B_invert == 1'b1) begin
            src2_ <= !src2;
        end else begin
            src2_ <= src2;
        end

        if(operation == `AND_ALU) begin
                assign result = src1_ & src2_;
                assign cout = 1'b0;
        end else if(operation == `OR_ALU) begin
                assign result = src1_ | src2_;
                assign cout = 1'b0;
        end else if(operation == `ADD_ALU) begin
                assign cout = (src1_&src2_) + (src2_&cin) + (cin&src1_);
                assign result = src1_ ^ src2_ ^ cin;
        end else if(operation == `SLT_ALU) begin
                assign cout = (src1_&src2_) + (src2_&cin) + (cin&src1_);
                assign result = src1_ ^ src2_ ^ cin;
        end
    end

endmodule

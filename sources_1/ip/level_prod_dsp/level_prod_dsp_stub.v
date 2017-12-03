// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Sat Dec  2 13:08:47 2017
// Host        : MARTIN-DESKTOP running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               d:/Documents/ENEL_453/DistanceSensor/DistanceSensor.srcs/sources_1/ip/level_prod_dsp/level_prod_dsp_stub.v
// Design      : level_prod_dsp
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_13,Vivado 2017.3" *)
module level_prod_dsp(CLK, A, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[7:0],P[18:0]" */;
  input CLK;
  input [7:0]A;
  output [18:0]P;
endmodule

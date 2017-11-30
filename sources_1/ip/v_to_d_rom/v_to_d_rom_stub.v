// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Thu Nov 30 10:52:12 2017
// Host        : MARTIN-LAPTOP running 64-bit Linux Mint 18.3 Sylvia
// Command     : write_verilog -force -mode synth_stub -rename_top v_to_d_rom -prefix
//               v_to_d_rom_ v_to_d_rom_stub.v
// Design      : v_to_d_rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_6,Vivado 2017.2" *)
module v_to_d_rom(clka, rsta, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,ena,addra[11:0],douta[11:0]" */;
  input clka;
  input rsta;
  input ena;
  input [11:0]addra;
  output [11:0]douta;
endmodule

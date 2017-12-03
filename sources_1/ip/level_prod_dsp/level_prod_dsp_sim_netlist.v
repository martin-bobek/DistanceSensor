// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Sat Dec  2 13:08:47 2017
// Host        : MARTIN-DESKTOP running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               d:/Documents/ENEL_453/DistanceSensor/DistanceSensor.srcs/sources_1/ip/level_prod_dsp/level_prod_dsp_sim_netlist.v
// Design      : level_prod_dsp
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "level_prod_dsp,mult_gen_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_13,Vivado 2017.3" *) 
(* NotValidForBitStream *)
module level_prod_dsp
   (CLK,
    A,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [7:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [18:0]P;

  wire [7:0]A;
  wire CLK;
  wire [18:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "8" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "110000110100" *) 
  (* C_B_WIDTH = "12" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "18" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  level_prod_dsp_mult_gen_v12_0_13 U0
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "8" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "110000110100" *) (* C_B_WIDTH = "12" *) (* C_CCM_IMP = "2" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "3" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "2" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "18" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_13" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module level_prod_dsp_mult_gen_v12_0_13
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [7:0]A;
  input [11:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [18:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [7:0]A;
  wire CLK;
  wire [18:2]\^P ;
  wire [1:0]NLW_i_mult_P_UNCONNECTED;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign P[18:2] = \^P [18:2];
  assign P[1] = \<const0> ;
  assign P[0] = \<const0> ;
  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "8" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "110000110100" *) 
  (* C_B_WIDTH = "12" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "18" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  level_prod_dsp_mult_gen_v12_0_13_viv i_mult
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b0),
        .CLK(CLK),
        .P({\^P ,NLW_i_mult_P_UNCONNECTED[1:0]}),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
dWWkLS4MAxTabZJf/z6PdYqCAGBEFl60TKb71Rh2J+7fWDO/9CrkzmRY6MvLyDNa6XcNwmyjo+vH
IT27waHJUw==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
PStuquU0P15n6Yubm4HMz3YAXAHDJepiOAryzYKQSHrg15urbj1rVu7aY4DMfqLAeOhhBf2TxCH+
9b87ufCRohY5ifOwzlMpKd1I3Si+/3GUzw9K8cI1mIMThIsp8ehAXs7z6PmPe8fpb58yK53dOUFC
FlXVFlQ6H75gMzv2rk4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kwri0+QxipG5A83IfKXbnNqYBPHFYGaIsFL2KUvt2+LL7U18MJTQM+vo3V0pETK3opNpZ2mjFhXX
ZzMyYH6qWunSiWYrhs76sXNQ6knBLUhyk1u3tR5DMBXeoO/LVNQv6j3UGT0axEDoKmA+owk75POw
nrWnrkyYKkBEjVQZp/KPABPhhmASMkggWTXY3g6g0xQjGCQ+VxdTkVKoA6XMhNWaRzxDsRy9OUbU
oxP2nChnJTZkuYS+wwzHiaJ1lvMrtfYzNGg/Kwwtey0hN3IfMuVmf2ekPAKJQbUdvdbdMnS6FRz2
0u1JY8tUdctyWIwH3hvfVDk66bxGiWjLknoPjQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ESY/ZH+AOdR3bJqVthBiqNmS1Jk9vG9eNoc6T4mvQxABeWInTaMFH5NkdbdUlHov8eF7SmZE70WB
4IRayOKfvPxA8JUbj4JtuPw5Z4chCBY7T1gFg85KCLWBceRIQFqhSQS7Yp5ruOHM1R3lABf0DrmT
pMIKsz09QJbnVuBRr6EcSYXweqOMVf23gE+j/5QrN3W3+YU4uOqVekWMf+NXuLpJit85XZmiXOP8
MLPN6QA6ojsaqurh6u0qqqdHu0ueB2zuQJUF9OY7BElgqWCuKnmNopoG6VpfRlow3aoOnx0BItXF
4WZA0b0UvdATxN0d9vul2AZzEkxuVibl5QhmEw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QU2aH6P/xI2F+KTH+343BxpGAPnWdbPeRjqVBInBEYpd+kSziCSub3j2t6XzCbhEMu7Bz1gAUEpo
Rz9cEAi8Mhig12ELCTQBLt97IIIBB3EMMaYdXYFuALnAdGET5Ls2k6BA+/reYpsZPGJ6N0G+rIP2
xOT6QhtjQ7J0/d4KKdSBMFWxpl9bBh77/oLyB7lgZZXOH5qEh/fQj1XmVhY+VKLQAAgJU6AdPvaS
aTUfNcvM2zkAICgPbm1M6JoBZcHBu9ktB06412Ip0F1kmmDtlQsv6MxYdIireAvAN5pJySI0QCVM
9z9D3cJYBl/AoBjSk6RhPa6oMfZXShIgwATRFQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
QVcKNT3uT/N+TRIZq6fZRukT5w/zN0mLW+8srEKbzCGBtUWWAfY/ZXcAsiFOAUT8P74Eem/5yLlJ
NCqhFDs56cEcv3DUmVRq19feSFq5jL+Msg5JbEWK1Q4def4qnJmLvbdTedENrnhiab7fS5umsdXK
mhSuM8LyfzEDuEodUPk=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
nndcpEnL0nNbk8F4xWqpm+K5naMnFaJozpsJN51Ns0zsRSSUESxbqyxF13pa+9yK3A37adCOywfl
yNwUoQmpZcxHTWaDgNBWp0wt0aOJr+62A/yO4qrxnVqJGbzacN1x09Ssxtj21Mjkl7vJ7j+P/GzX
4iEjHQzZU24x5XwW/no4kbj+s28zKN71Rf1EZCiEdnAoPS9dCC6orFOYwwSg68oXF/eLVXo4zFJF
NV6pcjlZlONhbZsycUyqLAAH8qqHB6dlnSHMbkHqjlIByg78JrwEUEOe5dYxw8YELwI6Y5pZwv63
0s6oFSRksaznFGTyhsiGLv4RmK42MPI2MyrLoA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PDAz6XB9XNKnpVsHZU5Mv4JasHEP9QU4onDrboWo/0gcULILzoEWHLhJ3iJUpeCacNfy0vvaXkZW
YJ23owUGkHAz5gn2I6zXU/stMxhAmh6/DunMvxLADmecYYnmHwuxo53BUb5dxUascZs7CAszsYde
RYLCJvp8H4VcbdOVCHZeZIV6DOAsYoYAc5cGxavyMbGLRvDCHsFqlPkbJJ1hHup6KJeMj/dcxM3W
xWr3V+hBd8GvxM/NLXUWD7/U3jAtERU8rczUxigc1hXB6TsHWIDFeYh8VbtgXbZ7ED9cqzm+YhL5
AS9H6sqibct7NzFClTC5dTlV7RTVBIIUFE2Bhg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
1SypPRkTFFJKWVnfq1UYdbxA9/fuR84YVITAX9ibLf1eXgXXKvyROTWEG2qADUv4cqjSQHLLS95a
CuUWBne8lqVoStp8jtBzzkiD0+WOLOOCDKlwQQqx0pMCOFZZIzGW2DEzgz8/EawwVjAQGiXgncsz
THN+NP6F0QzS+P5SVQV/zUGmOXXkkZ9B4sYahz2JKXf+is1G4sxYok0F9PtcofVsFBjQgo9l4KUU
16tlHzUqsja50p1B7p/Yg5BbMrs0k//G8otaoT7QN1X2iTTqN6HkhZR7K2QFGdiMQWIsJOZVKT+1
bPI0k97iN9pVN0O+sx8Ln7w2lqMCDPmCu7GeMA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7616)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif

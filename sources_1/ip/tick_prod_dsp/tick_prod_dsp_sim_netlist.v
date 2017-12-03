// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Sat Dec  2 13:10:37 2017
// Host        : MARTIN-DESKTOP running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               d:/Documents/ENEL_453/DistanceSensor/DistanceSensor.srcs/sources_1/ip/tick_prod_dsp/tick_prod_dsp_sim_netlist.v
// Design      : tick_prod_dsp
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "tick_prod_dsp,mult_gen_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_13,Vivado 2017.3" *) 
(* NotValidForBitStream *)
module tick_prod_dsp
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [6:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [11:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [18:0]P;

  wire [6:0]A;
  wire [11:0]B;
  wire CLK;
  wire [18:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "7" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "12" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "18" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  tick_prod_dsp_mult_gen_v12_0_13 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "7" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "12" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "3" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "18" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_13" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module tick_prod_dsp_mult_gen_v12_0_13
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [6:0]A;
  input [11:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [18:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [6:0]A;
  wire [11:0]B;
  wire CLK;
  wire [18:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

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
  (* C_A_WIDTH = "7" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "12" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "18" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  tick_prod_dsp_mult_gen_v12_0_13_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(CLK),
        .P(P),
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
N/lz016lYIZt8b/fivk2M8ZlvmyLxzvVYWCNoZmfGgPD90FMT8NdtyZYapBUncRjwYBj2MO/drgW
rHXjBzLGl7VaTUyOGuCV6b6zeGjyVWuJUnlIwACmH7y49FjFL7/Ny4YzkbKjnONxxElzth9DWVBU
U2bpUIVWUp5L43VAuhdgx0JJVdWeV4CIm6VtJEoDEzXpZIbsLSYZH0ZxL+ed1RBUeJOjV+Y0sP3Q
6/R7nJzGXnpRm0byNXM7VaE/lHzItsM7ejNpm685F0CeiCbJMb4pK9jUfhTiPQmblPok8tvbyhJp
AGNbQjtgGjE6b+McjiuNsj2szBz+KECRGqe5sw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LBeFdLRGkmxTX9D5lA5sRArM0boAp/dhmJ0wI2O0v8geWtZ1gdiFeFOsHawSyiCnMsR25ZnOVJsN
oQ6owM1HvERUQALndShStEkLHtIcVEvJ2asGu/SYr81GrPy1Koal8KfjOTib8AebxyFzFqeSv3lO
toTIqWvfGAotzTeqg9XYPaPxR28IblcJ1lazskRV9g00ne0gszzw4tfZ/HIZjeQ3rVwKph5cwuKh
XU6aEtoFRfRwm1xWiqiTMoEO4A7ymzxHFgNaaCb0pYJDTNDjq+wBw75S1WFT+SQ9wUNgZma0TDoM
+8kBHpxxN7lZCPOuZLz14c1HYLMNuZfd6OtUmg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7248)
`pragma protect data_block
EgBe9HfLhun+IPbupOJCvnWXP0BwKN7tbKHlS0f/HioGghtDhcuNj8V6ysbQRxzk21Xuo4F3Bnyy
F21nqoi0UhzDYKt9S00xzc0xHH6pCRvQ4RP1OQa/OxtRQ3SlZsvR5k2M9Mcwt8GPuuGWWtuAsiO5
Uf6ayCkgcIltsxPtQz6BPIysw3Huhd6itA1SofpiHBLfw+SsViblrV/Qpyfy7800viHY8VVKaMhi
cto8CPgWh1EQ0cmuvmw5islmDtpcBoRATCTtExKIMgdfVphoW0UFqwK0cuecUqa18hc2SRx/1HAn
1ByaQao6pWLhWr91fI2cZ2QA/eGp7wHepoGFm66KptWkupRhyv5S/VIV3aGF/Vr2Rq9OVjramrsa
iwVUh7ubOiw76A4gywVrDHyk759xcmiA6ZPLGKnRsDArghajR/1TxldOGDAF37r5fd/Wo40ZD0r7
MHeo0UIHVsW6ZT9RxF9LLZ/nZ+0scbUGdyKOEmIpUr34A0SmNjyjOkzGWc+Gw4E+AlRJe9mAnjlU
+tMRVw50j5cwmtSWIyqzrRTGc0rPf7upYSeXnMi5do1pMRpoIx75TQ3BP5QwnUgwKiQwqRPYhkx9
9zKycK6j10gRTM064Nq/kWfD7ALQeS+FyZiihxsOcFYWRa84JItECNtQDdQbmNXppvv/7ubrANBh
TjeD3tKCDdhfRWxxkrMaLtnTMi3mxmFbzuBRbPCLNtKLr8Y/whwQC+k4ypSmKUB7/xFKKqFSx3Pp
kQeY7vczSsykNGsRq0KerZvREebYzu2vhoB4+VhzbrsRmJXuZLkNnG96glsRtOMvv+zW7mmtMVbJ
6FHnQaunaNLvH1cOj4Io1IWz5ClsVdLa6hCfbHpeyS+xL/CWaqYkmSu1eO3Qn5b73234kcnRdV6V
z3Sn2IT1mm9wO+BlCD0Aa+aRyhSFDap9yA2gPZCaTxE0CRq6GR6SkETM5GRYzMufVV6iTajR5sZt
GZnDK+pV0qbxv+3FMGCWvcsQUpxYgWloYdiVDe1FJSjTSQG6+JGw4OTHiA+ko6hrur/xR7hqnEWM
pqabJvUwA9gUX0YFqpnFiMZb4/qfQP+QSwPKRZN1To/owwy5poyTzoNI8yZWqyn7+GYk8CIqXd8a
mQtRm/tD0KRyWBHyXvPzciO3FXPFiWg5ExyqyXBohU8iSOY3bP32Fwtxvv9O5X0cCW7Vjl+ZvDKI
c4mPeigeZDR4BOVyKzOkzyom5qYlFbO9WhsGhIXtC9/Vpu++dNDTIEZtM4cWkMW9ooiYvoOqIMDf
fr2RLcVEqsuFEeKZSzvJk6p/fmoSvj+o8Biui8PgZCI5M4wRRXkQqR2xCzM62OLHD8DU749kZ4S/
FBtBLok7VciQ/ZaZIWOUAgDwx062T/8DlifYJQV1/pTjbhNNJuKh5HS5v4fIyUlKMIcgfLs0I3pp
xRvq4k7nF/tnDBzidKIM3AeYNcyFeamRe84hI8f73E9rLL19DVJUZEGA9CgTXPnXPNolyJrTEcHh
Voc2Y1grLmIyPXQZTOsyMXFfVv7hwrfwjgdHCtKd4pZjyz9yIIlar1/UhJo0f06vnVypbQOTg+hx
Et80G6lHRTV6N29JioiZ3/8hUcidJ3Muf1eAHECF9lXMSlpoXqdgOAWd7PWtItCl4R1D0yZyXVbv
a4STJu7hcrIaofluJ0PdJJ0cL9XydHXkOAQTdnC/DNIA15qjUdVkGUXK6L13bL9sTsuwFtsEitOh
6hxN+aK+EgSQNwLbjygPXRUwOAxSewFe3DG7Q4Bqd6vkfG4XES94i0J52UPdKYvL8gW2NfJ9WrhJ
vBKgNnBXO56JEyFy1W9jotB+X8Ea9NO4Wf0O6byOWoelc/+6UQXPrJMuII4rVeF7ZyPCOHyapolt
N51ZrgszWztgiTRe0xu5CFOnCcV2Fgo4SIjfgdC6nsdilzx4wRFP5G2nJjeyrUnN/moOaz2T3s+E
ysRUGPpsQHoeSvNjq8b1KhYuMim8qSV/Uad5FXUTRLYIyDFtV5EDRudUz24x9US4cm3t8JFu5cNA
v9Ouss08Xf16imvfoVyrzyB/BT4TVa9F9B2WsKEh2pbHHAHUIq171zVwx4HqdqRyeoijcwrQRi3Z
pHffzBnKu0U4tqNN3cN9GCHnYCoQxgNqKxxuWbdJOfvxgM51mPc/NARk2q4tbCUvImDLMD5togmv
It6U7JKJEe6rYwmvNuYIfo+5CSWu4w8N6IhNVGbRGNO+XbNr4lfFaJYzVjGF35vvIlu8cS6Ii8il
whcV6HFQO27l7gCDOoFnC6rT7mSo1q8P4fJ3BC1jpZUwTiELHiLOLuh2MnPjtDqG4DJbk6IStzau
BZMk9TxmCdDWAnQO+h1+8oMN2R48T7bsHZqzeQEN1osuh2GiuOoHUy9uu2+O3Xiqfcox7Yri4q0o
7+Gl6OhUFSa34jXbcSSX3DRibG7HYEYatWbdHKyvH/vvqh25leDdzzHrudxlWrtqeeVdI4sTGLtX
uu5gS/QzwpE2w1EOaQHXPEr8N8sx0Uh6jHexSIU1kaPigjqmNok7iG0EiLtxQJg6YjbA9Il8tFql
1FXgKudQYvzypOO+2KBCLHBJ6+T+8ksi4t6O8k/HT12ITT/xvjEyW/jgN5+LtjeaItHubUzNKORp
fZ2n0fYfS8Lk1YR/PBAFagu8uEVeHOrn6uoqNjghpYvozc0J3FQAJVLixlVjsHfJ8a0MRId95jdH
r2Za0zidSlXgIx/FmC/5wzbPokW3I2jnNQagaG2Q7m5QkNZ/pfAczW1rJ2BURysI1eGNCq9JgeVG
x0zZitxnDIK4+YDMZQV3oiEm0FcxgGhN2taMbfZ7UaibDiepBwDSsy48FO/ZRlciMXB3EIQHc5ES
ZUBJ67jEkVbSZY7rqlYXISrERxiyv/yV7fZawCXE9JH7oILRqyMZpfQ6Q34vNnTBcB7svZCv3loO
/2qVSrq2mdTqkbPFaGoI2foRL7IJOan/GLg+L0pm/v1tEalYsFenZRe4KcLE7ZNeQdDkAo0LOOLr
JTNU1lLxYDFtZmwBtd0vCyZV0nh8xXf9gY0tqbxmfK+/qSJHzw0ajXKkRk4NESJ7z/0Osp/xWb11
phg0RMmK5juXJ4nr6W42rgdDVneBk9IkO5sU/TdESDV6kdeSsqIrnTPJWcaLvgFBXDc7ZRF3e431
eVzrVK4b3OUwaZ2GnDr4SxYBrUvp8LDGb4OspuJDj4Sl0RyGDF89K9q3U+F5oUB+ROXGNwTuTzOD
f0NTNFMa/5jsFDALq50ACXUdRXstmT2WMHD3rSuApkTkuCJc38vIFhT/b0jvPMEoG3aOrpuhSI9B
BU0RfZxpsSPYNFMhrU/6B8b3m5ABis1H+9sQhkXpJrMb9LtkKlJdPGV4Cy/t7JJWjxZq21LztNGL
Nudy0axSQWipv14US24IxMtrEZCIqk/GnArgIWnHm7BPx/Simm0LA4r9g1RBtJ8EoOhbtU7+uTMl
sgkBCXcZ4oKIRalPDtKWgoYXDcOSFhHhC0rBghVsIY57GADz3x1HqW/PNooVY0snDwiSRYJLvD4Y
bJaamG7KhG5AJgOdJPvHbkQTKqGSWPHYLWZ1eF/LNgB+UJXa0B+63m8ko8RfDGrkT9JJqkyUdcyg
z9L1L0MRVxJ938tdkd2T+18kINvpiOADbwx7oMkxok+LLRDH5VYuHN0uS2tD33H9IGHw+sLJkBwI
M4+MW7vvD6TdWLLFuAbKYWr8ZedTWkMFmXQi25yZVKCNNe2NkhBcjb/kGhE755TUcPzDZNZoG2FB
bDiE13UL4uSg86OnJvxfJAlFd/tAA2QtxNdSd+stMK0Aq6VJLV6THIxw8m+6698rRfqXj4Wz72Dm
OsJVC1u6V6kw6Bf0yZ6ZnzOYU5ZbU0l3fJcr+sJX4ijbtKYe7yBbEbtEBG2k/pGts8rpNqJZFC+n
NnfS8RDEJx6uaUAQEXXXj+QBT1nbXuuo1S3FzgAou/JB5pkB09UBecw0CvdcdJs0udznVUZfmAt/
zWU6WhdP1vN8qKbWor8ca1IpywhMfH7hXRi521EQmbgxvpZFc9mw0/PYDDcoZmpguVaJqFrrlfAO
v8pKXlQEpLH4i8hhYpJGfKEtXFr3S0NYrwIiDenxQL/3bt7SFnwwa4Em155axB2DE5gDau91Vrqu
nBr1ByhqLASw2lxv8bHLtnqNyi2H0hswoZmwH9JwnOlXmRiIUV1ctupF8ZSVvuGD9O5tJaXT2O57
NhYCPqBryna3SHaWU3h9CdG2Ez60ETnm0fqhD4HLx2fD0JVrf6sgGD54nGmOoDuPc1ol56AAFUb/
WhWbgPslM2ztwaeQHl5plWbf/lPCW3zN3WHsOar2g5JfMEBXAKWrqX1Wp/JvmArAZd3tRwcFihsV
vlDzP2CJhkPTbdoXNc6YFAAzk2VnZfXpwOHiDVd8GPgwCHCyQV48H8GZTxIkcOCw3rp/JWb1snTR
oKM5h7SKljOa02EN73GfdQmEQyC4t8a6zn701gkkMDgnrtckoMSr4zjv7PoG6q2flesBgjhbHa0P
aRwljtx6JjexSdDPN/g7mW+bPkjwp2V59SHw5qFnmD5TXVVKUAmww4w6QB4Y3gihs83wodCaWkLN
er0+sO68jhgzkdxAUSCQVJsSHhaG4wfdEkIz/MVD1nz4WSVayawa+ickX33Jim1UBGd01pYrdMMD
pm9FsqI/a25WwsJQt1Y99LYqCtt43oqOeGbqdW+EsSBKYH/6CW7UG+6WOVXvfYF5JzXYdiGhLzDh
pj+p7XMQy2+kdquGZcOIqHeX7eXNxN321WSa0KxwHf/30fXWofQbGXGYforGDtm8REoWgMw3k9AE
B2+vmkIP3kY5D1U6VJ4qXwkchR1xZAhSD8vNgqLpPbkxT4yJR4+LjIrphEaDDJCYw4soDnBKY2yw
UfJ6mIyjE6sRLH630yKGjKICxGorXPJCZ+hH9uc8nudJugDqX/J1qME8hTV0ZGKQZOWVOHGD7dBr
xNbJ2ZJuh+cInPNOR1ppHGSl6vDP73vnjCZBxaFEdYUyR9u0VOXBt/Mo2zdUMYe6r1D1in41item
Di0zg4vc3UI5i9Bbo+kCy8xZ6X8DImA1GY8NzhoraYqpuzmN5K0NW5CzyfLJe2Lcm1a71C8vv5YI
52HsDu15xd+tZlzD4peA3cCTd8N/v7RiKAePfMbIw/aSj17+OlasN61MbBfq4UHvF4/LcHwLgn17
IvLJ394VLJ4K7eBeivkNgpk76gXxtudaPI3HqMayv6YvsszFavZxlnS8bGu+28qFM4M4qfBPi9pe
2yoPWKluogdMfHEirNTmFKsWeZp57wAOhufOmoB1AzhjPHzBGWh/DKBCCzeoUdJv7exWf87PlSxP
43rTusMJf4PxcR+AdASOtGos97OHpZeqXF6EDU0TUwyYSSbk6IOVHuuUdI/WBNF0CC+RRXGLro3v
afG1fP3HOMb3330uE3NRrZVBTu5r2RPjLb3Zx3F/u/FiSDXabReeImfdKF0uPEYPsUd79fohKZrL
3mrvll4ZimH+/btTvpEhW0He1Qs9rbJxud+PKHTpuE6H7xlrysbYYbd/6NrgxSAUVWzFeDF4PxfZ
Qx16ujD2rvkgaWfHXFpDySjU6xQ8NZG+A9Pn59qvJgp7AO29yRUQWq8pcMskSDn6E3OCzy27SJXX
DFagPJelueh4H/NxEZAXR3WOEAyOmAdy4gpkm/Do5GZfj06mN0ZEwD3eaLBYnEIh9nfQ5VipL7sK
3kHCTIjF/PtBVvN/u3KGTVD5YdQhN8upbUZXFxGW21VPje+9tkdC2H28loIAiKLirWp+SEyH4aps
x/g+nZ+3vQPj9jloIx1145d9d8P8B5yXfdOMgT3PuGZqhHFi7aiQQK/+jDpCyDpbBvSWixmnKlM+
lj5TjqUHRRES7+Siga8skgAqivc7u34c+4nDbN1JSa785NjMeuA7ic+1+aMhO/HNgMBOq9wYjySq
bANlvDZZlSeW1+zeXCxhm1RdDEzlKyFBiu+pxELPVchB37R3eEHfeZ238RtKg1nVGFaNh+hujv+a
t1Wle4KYYwopc02quGTX7VVM9lmYq/Z598KmKN9UVnq5CwRwtVWYKo6qL8Wsl6oBaI+PfmWOTy1X
2Ey8zaHA64EV+UA0aNgYpU2br9oR7zNEDHsmLb98zxqLXjMeLX5DtxXXZPBrAyxn/XMesQjh9Ve8
b9azeRU9wyXQ91Qrp8GbjjDh5ln/J8aS8YSr4lepL5rnbcSeh2c5KFx6Qxq4icxoJKqiM+QvMprf
fqJj+AU23wNvqcMijY33PiCPTA6Z4eRwQQerOaGJQ197XIWhoE/CCyzSS1ReKGwnmInB0sJdEj7Y
m7wKSzHcJXgrNGm2NnXLuF3egWemjJCrYvcG1kKiz0DpGw62ncjaB1l/JxwllwXsydVy+diB7Qnf
XEffmpfzqQhktJ5k7J45e6d81uhYb99c3OM/Lfbmkjn4lXBe28J3FLthansu5Qe1abW7MPB5cN+A
eiWpAL2pPAU+RfuvuYoLss5zVVrj5rnjT1f0V+Pm7yP7Er5xiZtkVpXBKjUkUwAeudsOormgRxuC
5ZjvNMtNZQbPCKZGOPMFfYEy/GApUwteKtc1ByDdzAX5Iw1xV0ufROdf3S3NDTCIegaJf9H6ie23
5DJmQXr6m1jeEzE1py/fdHKDiYyNXIEeBs+fnME10r2PHyK95WrVqEUhJbjxZD9VUiV7XRRLphHa
c4Y2uMiRnd+vKLEOVCIV8MyFkdreQ4GECoInwqu59nWVB6lWNBy547CsjG/B69gkEjQqUY9mXhIW
33eeYfeK+RMQeyR9TdlOJxtkBHv/7A+2BenteQTBjqJWyGcz3EzI/0Du/VDWHVgrm4xglwnjpp3F
MbJbmpNKvTfYv1WPo3gYBPDQY31oFd6ZDk7irOIcX5upj9Y0oFxH6uZwMJ6UFRvQFTrg0VPnzopp
up6egLzWRLrPFfjblmycTWuj9XkvMZ6UuQSo/Mmi0U5v+aEz8AWQ0dJmxz91oZV4/VFtBoOioQB7
42wdMz15lTJzsPoPNPO4B7+EfzZTB7qApmiEDSlwUSH6bNIHL4LEnJhuseLimWtCb/K9aEDNce4M
HJaQZAgL6jl2QOyB1lqG9ynvZzr+E0a6ErOlFWIKvQtN72B4TaqylY9CTzNkauXDPAOFoY4zS4k/
KI57e0h0B6LmhU26plt7dBfW2IYqRGCRt+UukENDMRgblPcKMvBycbxdhvH81TlCt4wa+dUZ1XhR
i/eOu5LGntdv3B2sAyWF5XgZfIKhl6jY36NSrTGBM5+eUaigjr7iRYEbo7ZYHM53CXn+8fo/VAik
Vc0QkPsToBOH59kNGuZutcmbebr+C9Ysq/xMNp5k1sFZWag2mWc2ppMGEsnyOJvzea4sUo8lSUjx
3HNERp6eXrjLa4aq9tB6k89ecMpwHzM/LudqKfuTmk2232B874C4o9Oo1F5brNTGcixspUOigU5q
xDEc0l/xiL3WznW73XsB4p7Vy5TQSEUXjzoDG/Dvy1/wKSdp+UnPBWXH/is1Wx17GDEiC0jSry4N
VMOjNqZ898B4iIgj6EQ8qSY4Mw3x2uesWxM4E9JXQM0j+Lw0baf0f/+3uVYyNd5fxXuH6prNqaJp
G+aJxOlUirgVjlDoc80S7f+ndiUDXMYYck6WYFJmR8yABy0Sa20CuhqbLumwfDy84Xgq4e12M9An
Zh1RyH3XCH5ysbk91EJFm/uzNV/dlxKHU28XFoPl/OUfFJ01fodnYVFjfh5jcA1M1wwsz4KbkAs4
SwcthOf980t8fgJ4Z1A2hVs0OvgQXs1YREcsLOHJBB0VBl/7/XFlLNNR5hLjO+fcFuEa7ia2he77
YvPSpmvs16yaHuttNSk4YY2tomIxLD2HUhAFIKHgu5ieXxOW7HLeGAUMIAwmUgbnz1r4GlmUZfYf
uN8qD4+bsStQJXTITk3l1honssh+OK18J2+/YLqZ7NeG+Kj2QDZBcvNmfMX6zF0ZmZZhLqTMBbjU
a0cC4etgLp3QhiZKKFWcfqQBEirDM9L4Xw6QidJrA5cKtn15Snb4UXKy4guw6sH+sAHmnt87ugq7
cs3VzozuB9qqzm1mdVbJTvFPqFIRAE6MmTvU07J+MjT6iFtH2j0uPD/yjj5LW09k8gEWrjhPiVUA
cA0Kd8ICIjJJNZqK93ldkMuLmjJtG73ZCU+tcbHUcRWLgCj6EXNu6DVm8Crr26+ebTL42KEsGcdG
gAsjWa/aCG6IEmPKiUWCsALXkvD33x4i2AfgIBIV5eZGzIa8ohF7Gsdfb0mvKDFzWZQHW0ptFbcQ
a3BK7B6gxri6AgbfyTcWwBqvZ3cSTJGzc1e4TL0TXw55Pj2ETQqqISV/f+QQQvJx2Gih/G83eapu
Fl5e1sVcB5lLRYvJekrqDpT7m1TNKtBEOlJLCOwYEsVudav0nT8X8AmLG5iFxvduJA3KTCMbN7wy
cc06xUJ/dpKUNLYmcl6I/+gHYUWPpEzhLiyCiNL1ZeILZgslo3/evxOmgk9eoXfn067cwx4YU4sa
2PD+I+BDzNc+K6nYrIrCc7EBBmu1TYVfg0cBGpjw/8+a8z/MPicH/evLObo8/K5xh0QHZpSfpuRq
yxZ3vHcgACRbA6M7uOiS1v7siRt0NEVOONWKJpKVdItL0h8E/fzzTDBzNlNf9i8iGLCAUqfLXsAb
/8I+/9kCho4ochaZHqUdb9Tegc9azj31TB1Ec60NcfHJVKXv84CcOn42sBMwGND/cqlDUvQwtuFi
9h7IX3cQkUgEhgLCEZq8nJXcue41Zxu+S2moZYJ72gnVvXtpot2nx1OdIgyWrK7flm3vWChYZRGf
/3v22RI+OKRpwTGmcgnNPSdMDL3V9cWGtxzsBfPU7ID6PcMmie82QLGt34iPShmignTeoCBsb8ji
Vdj6kZk3VMSHN9Jrdo2ruvrW3xXp05MJ0dD5wZ5lrt5qdzx47AU4w9u0shRZtyZat5s8mWr+paME
TaxGL+8YSGSu8H9F2hLqK09x6efp+FxLaFJWSQpAlbE/1TVcEoWYKZ3vnNWaF4eiRKtq4JPDCUCU
4/GdlswNQUYUIgHP0bfSnLV/RynU5eHJ+SYAeeKt1y6mC5plEr0LQGIOlSePgMEOI5KtHH37WH2X
w1MlzQAVG9VKqoJRhqZ3CqpPwe4nDIFDoo45G6d5C+SEJ59HiYCKI6sKdg5/aofJckS/D5LjfNuD
X0UgdjGrL5i+6SLTRbWAevjJCY5n5BRAWWjJJJdLjkiaffuSpfNxRod9zcpzo5xsb0SJrXl7argX
uQWJIdtq4soA0kzxcHKmP33s1RsdBGYIMtpeL10aIoQkZYoRcgSJChDoCvLe+7Djcqhh8PAlubC8
i9cq9Hh0iLA1aWjv1ZueLmHChEvgVEjwempedNbt+yuMZP9WDA9+5SaQ7JLRJgffjVcFnhc3ByrH
6oVb0c9dUD/+I3YShJHf1Oc6TMs/nHDI5bCeussBLAW/I+mup3uKu2r++YDSaCT3JJJ8Y2cmx+1g
g4ntozXREyAcepxCehDQNEh0z7uPlLghKcibhWB05IUu8zTC2cgh4MfmmRG9RQTKxuZbp6cUYFR4
N6pHq9ooUvu4
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

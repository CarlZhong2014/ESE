**TXor***
.protect
.lib 'E:\Program\ESE\Hspice\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

.subckt XORC inA inB out vdd vss 
M1 PAB inB vdd vdd p18ll w=1.2u l=0.18u
M2 X inA PAB vdd p18ll w=1.2u l=0.18u
M3 X inA gnd gnd n18ll w=0.18u l=0.18u
M4 X inB gnd gnd n18ll  w=0.18u l=0.18u

M5 PO inA vdd vdd p18ll w=1.92u l=0.18u
M6 PO inB vdd vdd p18ll w=1.92u l=0.18u
M7 out X PO vdd p18ll w=1.56u l=0.18u

M8 out X gnd gnd n18ll w=0.18u l=0.18u
M9 out inA NO gnd n18ll w=0.36u l=0.18u
M10 NO inB gnd gnd n18ll w=0.36u l=0.18u
.ends

X1 A B out vdd vss XORC
C1 out vss 0.2pf

*设置vdd

VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

*设置vss
VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

*设置输入
vin0 A 0 PWL 170ns 0v, 171ns 1.8v, 330ns 1.8v, 331ns 0v, 490ns 0v, 491ns 1.8v

vinb0 B 0 PWL 50ns 0v, 51ns 1.8v, 90ns 1.8v, 91ns 0v, 130ns 0v, 131ns 1.8v, 
+170ns 1.8v, 171ns 0v, 210ns 0v, 211ns 1.8v, 250ns 1.8v, 251ns 0v, 290ns 0v, 
+291ns 1.8v,330ns 1.8v, 331ns 0v, 370ns 0v, 371ns 1.8v, 410ns 1.8v, 411ns 0v, 
+450ns 0v, 451ns 1.8v, 490ns 1.8v, 491ns 0v, 530ns 0v, 531ns 1.8v, 570ns 1.8v, 
+571ns 0v, 610ns 0v, 611ns 1.8v

.tran 1ns 650ns
.PROBE v(out) v(in)
.end

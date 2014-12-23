**AB***
.protect
.lib 'C:\lab\VLSI\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

.subckt AB inA inB out vdd vss
M0 out inA vdd vdd p18ll w=1.5u l=0.18u
M1 out inB vdd vdd p18ll w=1.5u l=0.18u
M2 out inA AB vss n18ll w=0.75u l=0.18u
M3 AB inB vss vss n18ll w=0.75u l=0.18u
.ends

x1 inA inB out vdd vss AB
C1 out vss 0.3pf

VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

vin1 inA 0 PWL 30ns 0v , 31ns 1.8v
vin2 inB 0 PWL 10ns 0v ,11ns 1.8v, 40ns 1.8v, 41ns 0v

.tran 1ns 80ns
.ic Q 0v
.PROBE v(out) v(in)

.end
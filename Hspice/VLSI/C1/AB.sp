**AB***
.protect
.lib 'C:\lab\VLSI\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

.subckt Trg gp gn in out vdd vss
M0 out gp in vdd p18ll w=1.5u l=0.18u
M1 out gn in vss n18ll w=0.18u l=0.18u
.ends


.subckt invter in out vdd vss 
M0 out in vss vss n18ll L=0.18u W=0.5u 
M1 out in vdd vdd p18ll L=0.18u W=1.5u 
.ends

.subckt AND A B out vdd vss 
x1 A Aq vdd vss invter
x2 Aq A B outq vdd vss Trg
x3 outq out vdd vss invter
.ends

x1 A B out vdd vss AND
C1 out vss 0.3pf

VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

vin1 A 0 PWL 30ns 0v , 31ns 1.8v
vin2 B 0 PWL 10ns 0v ,11ns 1.8v, 40ns 1.8v, 41ns 0v

.tran 1ns 80ns
.ic Q 0v
.PROBE v(out) v(in)

.end
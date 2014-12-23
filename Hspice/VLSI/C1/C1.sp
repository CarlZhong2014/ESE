.protect
.lib 'C:\lab\VLSI\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25


.subckt trg gn gp in out vdd vss
M0 out gp in vdd p18ll w=0.18u l=0.18u
M1 out gn in vdd n18ll w=0.18u l=0.18u
.end

.subckt invter in out vdd vss 
M1 out in vdd vdd p18ll L=0.18u W=1.5u 
M0 out in vss vss n18ll L=0.18u W=0.5u 
.ends

.subckt AB inA inB out vdd vss
M0 out inA vdd vdd p18ll w=1.5u l=0.18u
M1 out inB vdd vdd p18ll w=1.5u l=0.18u
M2 out inA AB vss n18ll w=0.75u l=0.18u
M3 AB inB vss vss n18ll w=0.75u l=0.18u
.ends

.subckt invlin in out vdd vss 
M0 outq in vss vss n18ll w=0.265u l=0.18u
M1 outq in vdd vdd p18ll w=0.620u l=0.18u
M2 out outq vss vss n18ll w=0.50u l=0.18u 
M3 out outq vdd vdd p18ll w=1.20u l=0.18u 
.ends

.subckt C0  A B out vdd vss
x1 B Bq vdd vss invter
x2 B Bq A out vdd vss trg
x3 A B NAB vdd vss AB
M0 out NAB vdd vdd p18ll w=0.18u l=0.18u
M1 out NAB vss vss n18ll w=0.18u l=0.18u
.ends

*加负载
x1 A B out vdd vss C0
C1 out vss 0.3pf

*设置vdd
VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

*设置vss
VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

*设置输入
vin1 A 0 PWL 10ns 0v, 11ns 1.8v,50ns 1.8v,51ns 0v
vin2 B 0 PWL 10ns 0v ,40ns 0v, 41ns 1.8v, 60ns 1.8v, 61ns 0v


*瞬态仿真
.tran 1ns 80ns
.ic Q 0v
.PROBE v(out) v(in)

.end


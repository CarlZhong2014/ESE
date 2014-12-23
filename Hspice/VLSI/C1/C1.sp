**C1***
.protect
.lib 'E:\Program\ESE\Hspice\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25


.subckt trg gn gp in out vdd vss
M0 out gp in vdd p18ll w=0.18u l=0.18u
M1 out gn in vdd n18ll w=0.18u l=0.18u
.ends

.subckt invter in out vdd vss 
M1 out in vdd vdd p18ll L=0.18u W=1.5u 
M0 out in vss vss n18ll L=0.18u W=0.5u 
.ends

.subckt AB inA inB out vdd vss
M0 out inA vdd vdd p18ll w=2.0u l=0.25u
M1 out inB vdd vdd p18ll w=2.0u l=0.25u
M2 out inA AB vss n18ll w=1.0u l=0.25u
M3 AB inB vss vss n18ll w=1.0u l=0.25u
X1 outq out vdd vss invter
.ends

.subckt NOR inA inB out vdd vss
M0 AOB inA vdd vdd p18ll w=2.0u l=0.25u
M1 out inB AOB vdd p18ll w=2.0u l=0.25u
M2 out inA vss vss n18ll w=0.25u l=0.25u
M3 out inB vss vss n18ll w=0.25u l=0.25u
.ends

.subckt C0  A B out vdd vss
x1 Aq A vdd vss invter
x2 Bq B vdd vss invter
x3 Bq B A out vdd vss trg
x4 A B G vdd vss AB
x5 A B P vdd vss NOR
M0 out G vss vss n18ll w=0.265u l=0.18u
M1 out P vdd vdd p18ll w=0.620u l=0.18u
.ends

*加负载
x1 A B out vdd vss C0
C1 out vss 0.2pf

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


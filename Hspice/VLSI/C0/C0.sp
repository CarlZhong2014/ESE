**C0***
.protect
.lib 'E:\Program\ESE\Hspice\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25


.subckt trg gn gp in out vdd vss
M0 out gp in vdd p18ll w=0.18u l=0.18u
M1 out gn in vss n18ll w=0.18u l=0.18u
.ends

.subckt invter in out vdd vss 
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt AB inA inB out vdd vss
M0 out inA vdd vdd p18ll w=0.76u l=0.18u
M1 out inB vdd vdd p18ll w=0.76u l=0.18u
M2 out inA AB vss n18ll w=0.36u l=0.18u
M3 AB inB vss vss n18ll w=0.36u l=0.18u
X1 outq out vdd vss invter
.ends

.subckt NOR inA inB out vdd vss
M0 AOB inA vdd vdd p18ll w=0.72u l=0.18u
M1 out inB AOB vdd p18ll w=0.72u l=0.18u
M2 out inA vss vss n18ll w=0.18u l=0.18u
M3 out inB vss vss n18ll w=0.18u l=0.18u
.ends

*XORC
.subckt XORC inA inB out vdd vss 
x1 inA AQ vdd vss invter
*定义共栅的p/nmos传输管
M0 out inB inA vdd p18ll w=0.18u l=0.18u
M1 out inB AQ vss n18ll w=0.18u l=0.18u
*以下是传输门
M2 out inA inB vdd p18ll w=0.18u l=0.18u
M3 out AQ inB vss n18ll w=0.18u l=0.18u
.ends

.subckt C0 C A B out vdd vss
x1 A B AXB vdd vss XORC
x2 AXB AXBQ vdd vss invter
x3 AXB AXBQ C out vdd vss trg
x4 A B G vdd vss AB
x5 A B D vdd vss NOR
M0 out G vdd vdd p18ll w=1.50u l=0.18u
M1 out D vss vss n18ll w=0.25u l=0.18u
.ends

*加负载
x1 C A B out vdd vss C0
C1 out vss 0.2pf

*设置vdd
VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

*设置vss
VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

*设置输入
vin1 A 0 PWL 10ns 0v, 11ns 1.8v,40ns 1.8v, 41ns 0v
vin2 B 0 PWL 10ns 0v ,20ns 0v, 21ns 1.8v, 40ns 1.8v, 41ns 0v
vin3 C 0

*瞬态仿真
.tran 1ns 100ns
.ic Q 0v
.PROBE v(out) v(in)

.end


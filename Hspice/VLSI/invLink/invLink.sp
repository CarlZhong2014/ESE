**invLink**
.protect
.lib 'C:\lab\VLSI\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

*invter Link
.subckt invlin in out vdd vss 
M0 outq in vss vss n18ll w=0.265u l=0.18u
M1 outq in vdd vdd p18ll w=0.620u l=0.18u
M2 out outq vss vss n18ll w=0.50u l=0.18u 
M3 out outq vdd vdd p18ll w=1.20u l=0.18u 
.ends


*加负载
x1 in out vdd vss invlin
C1 out vss 0.3pf

*设置vdd
VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

*设置vss
VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

*设置输入
vin2 in 0 PWL 10ns 0v ,40ns 0v, 41ns 1.8v, 60ns 1.8v, 61ns 0v


*瞬态仿真
.tran 1ns 80ns
.ic Q 0v
.PROBE v(out) v(in)

.end


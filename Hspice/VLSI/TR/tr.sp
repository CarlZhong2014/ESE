**SUM2***
.protect
.lib 'E:\Program\ESE\Hspice\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

.subckt invter in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt trg A B out vdd vss
x1 A AQ vdd vss invter
M0 out AQ B vdd p18ll w=1.5u l=0.18u
M1 out A B vss n18ll w=0.18u l=0.18u
.ends

*加负载
x1 A B out vdd vss trg
C1 out vss 0.2pf

*设置vdd
VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

*设置vss
VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

*设置输入
vin1 A 0 PWL 10ns 0v, 11ns 1.8v
vin2 B 0 PWL 10ns 0v ,40ns 0v, 41ns 1.8v, 60ns 1.8v, 61ns 0v


*瞬态仿真
.tran 1ns 80ns
.ic Q 0v
.PROBE v(out) v(in)

.end
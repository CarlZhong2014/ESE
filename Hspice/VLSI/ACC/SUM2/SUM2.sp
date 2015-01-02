**SUM2***
.protect
.lib 'E:\Program\ESE\Hspice\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

*定义一个反相器
.subckt invter in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt invterate in out vdd vss
M0 out in vdd vdd p18ll w=1.8u l=0.18u
M1 out in vss vss n18ll w=0.6u l=0.18u
.ends


*XOR
.subckt TX A B out vdd vss 
x1 A AQ vdd vss invter
*定义共栅的p/nmos传输管
M0 out B A vdd p18ll w=2.4u l=0.18u
M1 out B AQ vss n18ll w=0.18u l=0.18u
*以下是传输门
M2 out A B vdd p18ll w=1.4u l=0.18u
M3 out AQ B vss n18ll w=0.18u l=0.18u
.ends

.subckt SUM C A B SAB  out vdd vss
x1 A B SAB vdd vss TX
x3 C SAB outq1 vdd vss TX
x2 outq1 outq2 vdd vss invterate
x4 outq2 out vdd vss invterate
.ends

*加负载
x1 C A B SAB  out vdd vss SUM
C1 out vss 0.2pf
C3 SAB vss 0.2pf
*设置vdd
VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

*设置vss
VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

*设置输入
vin1 A 0 PWL 10ns 0v, 11ns 1.8v,30ns 1.8v,31ns 0v
vin2 B 0 PWL 10ns 0v ,40ns 0v, 41ns 1.8v, 60ns 1.8v, 61ns 0v
vin3 C 0 PWL 10ns 0v ,20ns 0v, 21ns 1.8v, 50ns 1.8v, 51ns 0v

*瞬态仿真
.tran 1ns 80ns
.ic Q 0v
.PROBE v(out) v(in)

.end

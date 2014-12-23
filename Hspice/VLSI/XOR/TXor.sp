**TXor***
.protect
.lib 'C:\lab\VLSI\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

*定义一个反相器
.subckt Inv in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

*定义共栅的p/nmos传输管
.subckt Trpn st in1 in2 out vdd vss
M0 out st in1 vdd p18ll w=2.4u l=0.18u
M1 out st in2 vss n18ll w=0.18u l=0.18u
.ends

*定义传输门
.subckt Tr st st2 in out vdd vss
M0 out st in vdd p18ll w=1.4u l=0.18u
M1 out st2 in vss n18ll w=0.18u l=0.18u
.ends

*设计电路
.subckt TX A B out vdd vss 
x1 A Aq vdd vss Inv
x2 B A Aq out vdd vss Trpn
x3 A Aq B out vdd vss Tr
.ends

*加负载
x1 A B out vdd vss TX
C1 out vss 0.3pf

*设置vdd
VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

*设置vss
VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

*设置输入
vin1 A 0 PWL 10ns 0v, 11ns 1.8v,30ns 1.8v,31ns 0v
vin2 B 0 PWL 10ns 0v ,40ns 0v, 41ns 1.8v, 60ns 1.8v, 61ns 0v


*瞬态仿真
.tran 1ns 80ns
.ic Q 0v
.PROBE v(out) v(in)

.end


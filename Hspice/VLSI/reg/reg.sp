REG 

.protect
.lib './TD-LO18-SP-2003v4R/l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

.subckt inv1 in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt inv2 in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt inv3 in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt inv4 in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt NL clk D Qm vdd vss 
x1 D Dq vdd vss inv1
x2 clk clkq vdd vss inv2
M1 D1 clk Dq vdd p18ll w=0.18u l=0.18u
M2 D1 clkq  Dq vss n18ll w=0.18u l=0.18u
x3 D1 Qm vdd vss inv3
x4 Qm Qmq vdd vss inv4
M3 D1 clkq  Qmq vdd p18ll w=0.18u l=0.18u
M4 D1 clk Qmq vss n18ll w=0.18u l=0.18u
.ends

.subckt inv5 in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt inv6 in out vdd vss
M0 out in vdd vdd p18ll w=2.40u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt inv7 in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

.subckt PL clk Qm Q vdd vss 
x1 Qm Qmq vdd vss inv5
x2 clk clkq vdd vss inv2
M1 Qm1 clkq Qmq vdd p18ll w=0.18u l=0.18u
M2 Qm1 clk  Qmq vss n18ll w=0.18u l=0.18u
x3 Qm1 Q vdd vss inv6
x4 Q Qq vdd vss inv7
M3 Qm1 clk  Qq vdd p18ll w=0.18u l=0.18u
M4 Qm1 clkq Qq vss n18ll w=0.18u l=0.18u
.ends



x1 clk D Qm vdd vss NL
x2 clk Qm Q vdd vss PL
C1 Q vss 0.3pf


VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

vin1 clk 0 PWL 20ns 0v, 21ns 1.8v,40ns 1.8v,41ns 0v,60ns 0v,61ns 1.8v,80ns 1.8v,81ns 0v
vin2 D  0 PWL 19.76ns 0v, 20.76ns 1.8v, 60ns 1.8v, 61ns 0v

.tran 1ns 100ns
.ic Q 0v
.PROBE v(Q) v(in)

.end

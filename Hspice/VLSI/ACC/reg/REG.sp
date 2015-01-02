REG 

.protect
.lib 'E:\Program\ESE\Hspice\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

.subckt inv in out vdd vss
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends


.subckt inv2 in out vdd vss
M0 out in vdd vdd p18ll w=1.50u l=0.18u
M1 out in vss vss n18ll w=0.50u l=0.18u
.ends


.subckt PL clk D Q vdd vss 
x1 D Dq vdd vss inv
x2 clk clkq vdd vss inv
M1 D1 clkq Dq vdd p18ll w=0.18u l=0.18u
M2 D1 clk  Dq vss n18ll w=0.18u l=0.18u
x3 D1 QD vdd vss inv
x4 QD QL vdd vss inv
M3 D1 clk  QL vdd p18ll w=0.18u l=0.18u
M4 D1 clkq QL vss n18ll w=0.18u l=0.18u

x5 QD QDq vdd vss inv
x6 clk clkq vdd vss inv
M5 QD1 clkq QDq vdd p18ll w=0.18u l=0.18u
M6 QD1 clk  Dq vss n18ll w=0.18u l=0.18u
x7 QD1 Q vdd vss inv2
x8 Q QDL vdd vss inv
M7 QD1 clk  QDL vdd p18ll w=0.18u l=0.18u
M8 QD1 clkq QDL vss n18ll w=0.18u l=0.18u

.ends



x1 clk D Q vdd vss PL
C1 Q vss 0.2pf


VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

vinclk clk 0 PWL 20ns 0v, 21ns 1.8v,40ns 1.8v,41ns 0v,60ns 0v,61ns 1.8v,80ns 1.8v,
+81ns 0v, 100ns 0v,101ns 1.8v, 120ns 1.8v,121ns 0v, 140ns 0v,141ns 1.8v, 160ns 
+1.8v,161ns 0v,180ns 0v,181ns 1.8v, 200ns 1.8v,201ns 0v, 220ns 0v,221ns 1.8v, 
+240ns 1.8v,241ns 0v, 260ns 0v,261ns 1.8v,280ns 1.8v, 281ns 0v,300ns 0v, 301ns 
+1.8v,320ns 1.8v, 321ns 0v,340ns 0v, 341ns 1.8v,360ns 1.8v,361ns 0v, 380ns 0v,
+381ns 1.8v, 400ns 1.8v,401ns 0v, 420ns 0v,421ns 1.8v, 440ns 1.8v, 441ns 0v,
+460ns 0v, 461ns 1.8v,480ns 1.8v, 481ns 0v,500ns 0v, 501ns 1.8v,520ns 1.8v, 
+521ns 0v,540ns 0v,541ns 1.8v, 560ns 1.8v,561ns 0v, 580ns 0v,581ns 1.8v, 600ns 
+1.8v,601ns 0v, 620ns 0v,621ns 1.8v,640ns 1.8v, 641ns 0v

vin0 D 0 PWL 170ns 0v, 171ns 1.8v, 330ns 1.8v, 331ns 0v, 490ns 0v, 491ns 1.8v


.tran 1ns 650ns
.ic Q 0v
.PROBE v(Q) v(in)

.end

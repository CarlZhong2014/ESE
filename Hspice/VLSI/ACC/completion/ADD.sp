***C1***
***作者:钟坚锐，徐茜***
***曼切斯特累加器***
***2015.01.01***
.protect
.lib 'E:\Program\ESE\Hspice\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

*传输门
.subckt trg gn gp in out vdd vss
M0 out gp in vdd p18ll w=1.4u l=0.18u
M1 out gn in vss n18ll w=0.18u l=0.18u
.ends

*反相器1
.subckt invter in out vdd vss 
M0 out in vdd vdd p18ll w=0.18u l=0.18u
M1 out in vss vss n18ll w=0.18u l=0.18u
.ends

*反相器2
.subckt inv2 in out vdd vss
M0 out in vdd vdd p18ll w=1.8u l=0.18u
M1 out in vss vss n18ll w=0.6u l=0.18u
.ends

*寄存器
.subckt REG clk D Q vdd vss
x1 D Dq vdd vss invter
x2 clk clkq vdd vss invter
M1 D1 clkq Dq vdd p18ll w=0.18u l=0.18u
M2 D1 clk  Dq vss n18ll w=0.18u l=0.18u
x3 D1 QD vdd vss invter
x4 QD QL vdd vss invter
M3 D1 clk  QL vdd p18ll w=0.18u l=0.18u
M4 D1 clkq QL vss n18ll w=0.18u l=0.18u
x5 QD QDq vdd vss invter
x6 clk clkq vdd vss invter
M5 QD1 clkq QDq vdd p18ll w=0.18u l=0.18u
M6 QD1 clk  Dq vss n18ll w=0.18u l=0.18u
x7 QD1 Q vdd vss inv2
x8 Q QDL vdd vss invter
M7 QD1 clk  QDL vdd p18ll w=0.18u l=0.18u
M8 QD1 clkq QDL vss n18ll w=0.18u l=0.18u
.ends

*反相器链
.subckt invl in out vdd vss 
M0 io in vdd vdd p18ll w=1.0u l=0.18u
M1 io in vss vss n18ll w=0.25u l=0.18u
M2 out io vdd vdd p18ll w=1.50u l=0.25u
M3 out io vss vss n18ll w=2.0u l=0.25u
.ends

*与非门
.subckt NAB inA inB out vdd vss
M0 out inA vdd vdd p18ll w=0.76u l=0.18u
M1 out inB vdd vdd p18ll w=0.76u l=0.18u
M2 out inA AB vss n18ll w=0.36u l=0.18u
M3 AB inB vss vss n18ll w=0.36u l=0.18u
.ends

*或非门
.subckt NOR inA inB out vdd vss
M0 AOB inA vdd vdd p18ll w=0.72u l=0.18u
M1 out inB AOB vdd p18ll w=0.72u l=0.18u
M2 out inA vss vss n18ll w=0.18u l=0.18u
M3 out inB vss vss n18ll w=0.18u l=0.18u
.ends

*异或门
.subckt XORC inA inB out vdd vss 
M1 PAB inB vdd vdd p18ll w=1.2u l=0.18u
M2 X inA PAB vdd p18ll w=1.2u l=0.18u
M3 X inA gnd gnd n18ll w=0.18u l=0.18u
M4 X inB gnd gnd n18ll  w=0.18u l=0.18u

M5 PO inA vdd vdd p18ll w=1.74u l=0.18u
M6 PO inB vdd vdd p18ll w=1.74u l=0.18u
M7 out X PO vdd p18ll w=1.56u l=0.18u

M8 out X gnd gnd n18ll w=0.18u l=0.18u
M9 out inA NO gnd n18ll w=0.36u l=0.18u
M10 NO inB gnd gnd n18ll w=0.36u l=0.18u
.ends

*曼切斯特进位
.subckt CC C A B out vdd vss
x1 A B AXB vdd vss XORC
x2 AXB AXBQ vdd vss invter
x3 AXB AXBQ C out vdd vss trg
x4 A B G vdd vss NAB
x5 A B D vdd vss NOR
M0 out G vdd vdd p18ll w=2.00u l=0.18u
M1 out D vss vss n18ll w=0.25u l=0.18u
.ends

*求和
.subckt SUM C A B out vdd vss
x1 A B SAB vdd vss XORC
x3 C SAB outq1 vdd vss XORC
x2 outq1 outq2 vdd vss inv2
x4 outq2 out vdd vss inv2
.ends

*电路
.subckt C CLK C0 A0 A1 B0 B1 AA0  BB0  AA1  BB1  CL C2 Co S1 S2 vdd vss
x1 CLK A0 AA0 vdd vss REG
x2 CLK A1 AA1 vdd vss REG
x3 CLK B0 BB0 vdd vss REG
x4 CLK B1 BB1 vdd vss REG
x5 C0 AA0 BB0 C1 vdd vss CC
x6 C1 CL vdd vss invl
x7 CL AA1 BB1 C2 vdd vss CC
x8 CLK C2 Co vdd vss REG
x9 CL AA1 BB1 S2D vdd vss SUM
x10 CLK S2D S2 vdd vss REG
x11 AA0 BB0 S1D vdd vss XORC
x12 CLK S1D S1 vdd vss REG
.ends


*加负载
x1 CLK vss A0 A1 B0 B1 AA0  BB0  AA1  BB1 CL C2 Co S1 S2 vdd vss C
C1 S1 vss 0.2pf
C2 S2 vss 0.2pf
C3 Co vss 0.2pf



*设置vdd
VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

*设置vss
VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

*设置输入
vin1 A1 0 PWL 330ns 0v, 331ns 1.8v
vin0 A0 0 PWL 170ns 0v, 171ns 1.8v, 330ns 1.8v, 331ns 0v, 490ns 0v, 491ns 1.8v

vinb1 B1 0 PWL 90ns 0v, 91ns 1.8v, 170ns 1.8v, 171ns 0v, 250ns 0v, 251ns 1.8v, 
+330ns 1.8v, 331ns 0v, 410ns 0v, 411ns 1.8v, 490ns 1.8v, 491ns 0v, 570ns 0v, 
+571ns 1.8v

vinb0 B0 0 PWL 50ns 0v, 51ns 1.8v, 90ns 1.8v, 91ns 0v, 130ns 0v, 131ns 1.8v, 
+170ns 1.8v, 171ns 0v, 210ns 0v, 211ns 1.8v, 250ns 1.8v, 251ns 0v, 290ns 0v, 
+291ns 1.8v,330ns 1.8v, 331ns 0v, 370ns 0v, 371ns 1.8v, 410ns 1.8v, 411ns 0v, 
+450ns 0v, 451ns 1.8v, 490ns 1.8v, 491ns 0v, 530ns 0v, 531ns 1.8v, 570ns 1.8v, 
+571ns 0v, 610ns 0v, 611ns 1.8v

vinclk CLK 0 PWL 0ns 0v, 20ns 0v, 21ns 1.8v,40ns 1.8v,41ns 0v,60ns 0v,61ns 1.8v,80ns 1.8v,
+81ns 0v, 100ns 0v,101ns 1.8v, 120ns 1.8v,121ns 0v, 140ns 0v,141ns 1.8v, 160ns 
+1.8v,161ns 0v,180ns 0v,181ns 1.8v, 200ns 1.8v,201ns 0v, 220ns 0v,221ns 1.8v, 
+240ns 1.8v,241ns 0v, 260ns 0v,261ns 1.8v,280ns 1.8v, 281ns 0v,300ns 0v, 301ns 
+1.8v,320ns 1.8v, 321ns 0v,340ns 0v, 341ns 1.8v,360ns 1.8v,361ns 0v, 380ns 0v,
+381ns 1.8v, 400ns 1.8v,401ns 0v, 420ns 0v,421ns 1.8v, 440ns 1.8v, 441ns 0v,
+460ns 0v, 461ns 1.8v,480ns 1.8v, 481ns 0v,500ns 0v, 501ns 1.8v,520ns 1.8v, 
+521ns 0v,540ns 0v,541ns 1.8v, 560ns 1.8v,561ns 0v, 580ns 0v,581ns 1.8v, 600ns 
+1.8v,601ns 0v, 620ns 0v,621ns 1.8v,640ns 1.8v, 641ns 0v


*瞬态仿真
.tran 1ns 650ns
*初始化寄存器
.ic AA0 0v
.ic AA1 0v
.ic BB0 0v
.ic BB1 0v
.ic CO 0v
.ic S1 0v
.ic S2 0v
.PROBE v(out) v(in)

.end


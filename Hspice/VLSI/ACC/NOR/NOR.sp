**NOR***
.protect
.lib 'E:\Program\ESE\Hspice\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

.subckt NOR inA inB out vdd vss
M0 AOB inA vdd vdd p18ll w=2.0u l=0.25u
M1 out inB AOB vdd p18ll w=2.0u l=0.25u
M2 out inA vss vss n18ll w=0.25u l=0.25u
M3 out inB vss vss n18ll w=0.25u l=0.25u
.ends

x1 inA inB out vdd vss NOR
C1 out vss 0.2pf

VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

vin1 inA 0 PWL 30ns 0v , 31ns 1.8v, 50ns 1.8v, 51ns 0v
vin2 inB 0 PWL 10ns 0v ,11ns 1.8v, 40ns 1.8v, 41ns 0v

.tran 1ns 80ns
.ic Q 0v
.PROBE v(out) v(in)

.end
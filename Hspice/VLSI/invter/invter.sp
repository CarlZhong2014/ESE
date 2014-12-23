INVTER
.protect
.lib 'C:\lab\VLSI\TD-LO18-SP-2003v4R\l018ll_io50_v1p3.lib' TT
.unprotect
.temp 25

.subckt invter in out vdd vss 
M0 out in vss vss n18ll w=0.25u l=0.25u
M1 out in vdd vdd p18ll w=0.75u l=0.25u
.ends

x1 in out vdd vss invter
C1 out vss 0.5pf

VDD vdd 0 dc 'vddvalue_vdd'
.param vddvalue_vdd=1.8v

VSS vss 0 dc 'vddvalue_vss'
.param vddvalue_vss=0v

vin1 in 0 PWL 10ns 0v, 11ns 1.8v, 30ns 1.8v, 31ns 0v, 50ns 0v

.dc vin1 0,1.8,.1
.tran 1ns 60ns

.PROBE v(out) v(in)

.end

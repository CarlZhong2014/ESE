* Digital PLL circuit
* Reference: "CMOS: Circuit Design, Layout, and Simulation" 
*
* Version of the netlist with global VDD

*-----------------------------------------------------------
*-- Circuit Under-Test
*-----------------------------------------------------------

xm Mic_O MUSIC
Xzhendang   Vout ZHENDANG
Xfuwei      pout FUWEI
*XMSC        Muisc MSC
*-----------------------------------------------------------
*-- Subcircuit Definitions
*-----------------------------------------------------------
.subckt ZHENDANG Vout
M1 net9 net6 0 0 NMOS  L=1 W=40
M2 net6 net23 0 0 NMOS L=1 W=40
M3 net9 net6 vdd vdd PMOS L=1 W=80
M4 net6 net23 vdd vdd PMOS L=1 W=80
M5 Vout net11 0 0 NMOS L=1 W=20
M6 net11 net9 0 0 NMOS L=1 W=20
M7 net11 net9 vdd vdd PMOS L=1 W=20
M8 Vout net11 vdd vdd PMOS L=1 W=20
C0 net9 net10 5.59p
R1 net23 net10 10k
R2 net6  net10 20k

.ends	ZHENDANG
*------------------------------------------------------------
*--this is reset circuit
*------------------------------------------------------------
.subckt FUWEI pout
M1 net2 net1 vdd1 vdd1 PMOS L=1 W=20
CO  net1 0 10p
R1  vdd1 net1 100K
C1  net1 0 10p
M2 net2 net1 0 0 NMOS L=1 W=20
M3 pout net2 vdd1 vdd1 PMOS L=1 W=20
M4 pout net2 0   0   NMOS L=1 W=20

.ends  FUWEI

.subckt MUSIC Mic_O
x1 CLK ZHENDANG
x2 RST_N FUWEI
y3 MSC CLK RST_N Mic_O
.ends MUSIC 

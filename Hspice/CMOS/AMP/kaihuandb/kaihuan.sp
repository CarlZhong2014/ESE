**AMP**
*
******************************Model

.MODEL MN NMOS (LEVEL=1  
+VTO =0.7  GAMMA =0.45    PHI =0.9            
+PSUB =9E14   LD =8E-8  UO  =350  LAMBDA =0.1       
+TOX =9E-9    PB =0.9    CJ  =0.56E-3     CJSW  =0.35E-11

+MJ  =0.45    MJSW =0.2  CGDO =4E-10     JS =1E-8)


.MODEL MP PMOS (LEVEL=1  
+VTO =-0.8  GAMMA =0.4    PHI =0.8            
+NSUB =5E14   LD =0.09E-6  UO  =100  LAMBDA =0.2       
+TOX =9E-9    PB =0.9    CJ  =0.94E-3     CJSW  =0.32E-11

+MJ  =0.5    MJSW =0.3  CGDO =0.3E-9     JS =0.5E-8)

********************************Model End

************Circuit
MN1 net070 Vn net065 gnd MN W=120u L=1u M=1

MN2 net20 Vp net065 gnd MN W=120u L=1u M=1

MP3 net070 net070 vdd vdd MP W=41u L=10u M=1

MP4 net20 net070 vdd vdd MP W=41u L=10u M=1

MN5 net065 net24 gnd gnd MN W=4u L=1u M=1

MP6 Vout net20 vdd vdd MP W=35u L=1u M=1

MN7 Vout net24 gnd gnd MN W=20u L=1u M=1

MN8 net24 net24 gnd gnd MN W=8u L=1u M=1

i0 vdd net24 120u

Cc Vout net20 2p

Cl Vout gnd 5p 
************Circuit End

R1 Vout Vn 1g 								**Vout和Vn之间加1G欧姆电阻

C2 Vn gnd 1 								**Vn和gnd之间加1F电容

v1 vdd gnd dc 5 							** vdd为5V直流电压源

V2 Vp gnd 1.2 ac=1 							** Vp接1.2V交流电压源

.ac dec 10 0.01 10000meg					**ac 交流分析 对频率进行扫描  DEC十进制变量，变量按10个为一组的数量级进行扫描
.print ac vdb(Vout,Vp) vp(Vout,Vp)

.end

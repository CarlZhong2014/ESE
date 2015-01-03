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

MP3 net070 net070 vdd vdd MP W=47u L=10u M=1

MP4 net20 net070 vdd vdd MP W=47u L=10u M=1

MN5 net065 net24 gnd gnd MN W=4u L=1u M=1

MP6 Vout net20 vdd vdd MP W=50u L=1u M=1

MN7 Vout net24 gnd gnd MN W=25u L=1u M=1

MN8 net24 net24 gnd gnd MN W=8u L=1u M=1

i0 vdd net24 120u

Cc Vout net20 2p

Cl Vout gnd 5p 
************Circuit End

V1 vdd gnd dc 5 			**Vdd接5V直流电压源
R1 Vn Va 100k				**在Vn和Va之间加100k欧姆电阻
R2 Vn Vout 4500k			**在Vn和Vout之间加入4500k欧姆电阻
V2 Va gnd sin 1.2 80m 1k 0  **Va接幅度为80mV，频率为1kHz，直流偏置为1.2V的正弦交流电。

V3 Vp gnd 1.2 				**Vp接1.2V直流电压源
.tran 1u 10m				**瞬态分析，仿真10mS，1uS为步长。
.print i(*)					**格式：.print antype var  (antype = DC, AC , TRAN) (var是变量列表)
.alter
V2 Va gnd sin 1.2 30m 1k 0


.end

//
//顶层模块
//
///////////////////////////////////////////

module MSC(CLK50M,RST_N,Mic_O);  //For FPGA
input CLK50M, RST_N;     //For FPAG
output Mic_O;


wire[12:0] WTone;
wire[6:0] Waddr;
wire[3:0] WIndex;
wire W100hClk,CLK;   
wire Wenir;
wire IR_N;

PLL pl(CLK50M,CLK);     //该模块为锁相环模块，使用IP生产。
CLK100H C100Hz(CLK,RST_N,W100hClk,Wenir);      //实例化4HzCLK分频器；
IR irn(Wenir,RST_N,CLK,IR_N);
NODE MN(W100hClk,IR_N,Waddr,WIndex);		  //实例化地址产生器；
ROM Trom(Waddr,WIndex);			     
ToneDecode TD(WIndex,WTone);		  //实例化音符译码器
DCD BCD(CLK,IR_N,WTone,Mic_O);    //实例化数控电路和二分频电路
endmodule
 
音乐演奏芯片的ASIC设计
该芯片设计共分为5个主模块：时钟分频模块，内部复位模块，节拍发生器，音符译码器，数控分频器。

时钟分频模块包括以下内容
1. 通过锁相环将50Mhz时钟分频为4Mhz的时钟。（锁相环代码是通过IP生成的，不同芯片所生产的IP可能不同）
2. 通过计数器将4Mhz时钟分频得到8Hz时钟。对应代码为CLK8H.v

内部复位模块

节拍发生器
1. 音乐ROM （存放音乐简谱）；对应代码 ROM.v
2. 音符产生电路，该电路以8Hz时钟为基准，每个上升沿从ROM中获取一次音符，若音符为非停顿符，则在2个时钟周期后从ROM中读取新的数据。若音符为停顿符，则在下个时钟上升沿时，从ROM中读取下一个音符。对应代码为 NODE.v

音符译码器
将每个从节拍发生器中获得的音符进行译码得到以4MHz为基准的分频系数的初始值。 对应代码为ToneDecode.v

数控分频器
数控分频包含两部分
1. 数控部分：通过计数器计数，当计数到8191时将输出信号置为高电平，其余情况都为低电平。
2. 二分频部分：将数控部分的输出信号经过二分频，作为最终输出。

其他部分
MSC.v ---- 源代码文件为整个设计的顶层文件。
MSCt.v ---- testbench
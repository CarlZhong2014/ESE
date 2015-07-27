module memory(
Ird_cs    ,  //读取选择信号
Iwr_cs    ,  //写入选择信号
Ird_addr  ,  //读取地址
Iwr_addr  ,  //写入地址
Iwr_data  ,  //写入数据
Ord_data     //输出数据
);

// memory 配置
parameter  UNIT_SIZE  = 2;   //RAM单元大小
parameter  ADDR_SIZE  = 8;   //RAM地址长度
parameter  DATA_WIDTH = 2;   //数据位宽

//端口声明
input Ird_cs    ;
input Iwr_cs    ;
input [ADDR_SIZE-1:0]  Ird_addr;
input [ADDR_SIZE-1:0]  Iwr_addr;
input [DATA_WIDTH-1:0] Iwr_data;
output[DATA_WIDTH-1:0] Ord_data;

//类型声明
reg [DATA_WIDTH-1:0] Ord_data    ;
reg [UNIT_SIZE-1:0] mem[ADDR_SIZE-1:0]; //8*2的RAM矩阵
// 写入
always@(Ird_addr or Ird_cs or Iwr_addr or Iwr_cs or Iwr_data)
begin
    if(Iwr_cs)
        mem[Iwr_addr] <= Iwr_data;
    else if (Ird_cs)
	Ord_data <= mem[Ird_addr];
    else
	Ord_data <= 2'bzz;            //当读取选择信号无效时为z
end
	
endmodule

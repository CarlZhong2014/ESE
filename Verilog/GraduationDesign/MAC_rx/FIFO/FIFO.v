module FIFO(
module MAC(
clk       ,
rst       ,
IEN_rd    ,
IEN_wr    ,
I_data    ,
O_data    ,
OFIFO_full  ,
OFIFO_empty
);

//FIFO 配置参数
parameter    UNIT_SIZE  = 2;
parameter    ADDR_SIZE  = 8;
parameter    DATA_WIDTH = 2;
//端口声明
input    clk       ;
input    rst       ;
//input    ICS_rd    ;
//input    ICS_wr    ;
input    IEN_rd    ;
input    IEN_wr    ;
input [DATA_WIDTH-1:0] I_data;
output[DATA_WIDTH-1:0] O_data;
output   OFIFO_full ;
output   OFIFO_empty;

//类型声明
reg [ADDR_SIZE-1:0]   wr_pointer;
reg [ADDR_SIZE-1:0]   rd_pointer;
reg [DATA_WIDTH-1:0]  O_data    ;
reg [ADDR_SIZE-1:0]   status_cnt;

wire [DATA_WIDTH-1:0] data_ram  ;

// 代码
assign OFIFO_full=(status_cnt == ADDR_SIZE-1);
assign OFIFO_empty=(status_cnt==8'H00)?1:0;

always@(posedge clk or posedge rst)
begin:WRITE_POINTER
    if(rst)
        wr_pointer = 1'b0;
    else if (IEN_wr)
            wr_pointer = wr_pointer + 1'b1;
    else
	    wr_pointer = wr_pointer;
end

always@(posedge clk or posedge rst)
begin:READ_POINTER
    if(rst)
        rd_pointer = 1'b0;
    else if (IEN_rd)
            rd_pointer = rd_pointer + 1'b1;
    else 
	    rd_pointer = rd_pointer;
end

always@(posedge clk or posedge rst)
begin:READ_DATA
    if(rst)
        O_data <= 2'b00;
    else if (IEN_rd)
            O_data <= data_ram;
    else
	    O_data <= data_ram;
end

always@(posedge clk or posedge rst)
begin:STATUS_COUNTER
    if(rst)
        status_cnt <= 0;
    else if ((IEN_rd)&&(!IEN_wr)&&(status_cnt!=0))
	status_cnt <= status_cnt - 1'b1;
    else if ((IEN_wr)&&(status_cnt!=ADDR_SIZE))
	status_cnt <= status_cnt + 1'b1;
    else
	status_cnt <= status_cnt;
end

memory FIFOmen(
.Ird_cs   (IEN_rd)     ,
.Iwr_cs   (IEN_wr)     ,
.Ird_addr (rd_pointer) ,
.Iwr_addr (wr_pointer) ,
.Iwr_data (I_data)     ,
.Ord_data (data_ram)
);

endmodule

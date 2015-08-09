module MAC(
//module rx_DACheck(
clk     ,
rst     ,
I_en_ck ,    //目的地址检查使能端
I_en_mix,    //混杂模式使能端
I_da_hf ,    //4bit目的地址
O_da_ok ,    //目的地址正确
O_da_err,    //目的地址错误
);

//配置声明
parameter    DATA_WITCH  = 4 ;     
parameter    COUNT_WITCH = 12 ;
parameter    DSTADDR_SIZE= 48;
parameter    MAC_ADDR = 48'H00_0C_29_4A_35_50;    //NIC的MAC地址
parameter    BCT_ADDR = 48'H00_00_00_00_00_00;    //广播地址
//端口声明
input clk      ;
input rst      ;
input I_en_ck  ;
input I_en_mix ;
input[DATA_WITCH-1:0]   I_da_hf;
output O_da_ok ;
output O_da_err;

//类型声明
reg O_da_ok    ;
reg O_da_err   ;
reg [DSTADDR_SIZE+1:0]  DA_buf ;    //缓存目的地址,共50bit。

//代码

always@(posedge clk or negedge rst)    //缓存目的地址
begin
    if(~rst)
        DA_buf <=0;
    else if (I_en_ck)
         begin
             DA_buf <= {DA_buf[DSTADDR_SIZE-1:0],I_da_hf};
         end
    else
         begin
             DA_buf <= 0;
         end

end

always@(posedge clk or negedge rst)    //判断目的地址是否正确
begin
    if(~rst)
    begin
        O_da_ok <=0;
        O_da_err<=0;
    end
    else if(I_en_ck)
        begin
            O_da_ok <=0;
            O_da_err<=0;
        end
    else if (I_en_mix)        //判断是否为混杂模式
        begin
            O_da_ok <=1;
            O_da_err<=0;
        end
    else 
        begin
            O_da_ok <= (((DA_buf[DSTADDR_SIZE-1:0] == MAC_ADDR) || (DA_buf[DSTADDR_SIZE-1:0] == BCT_ADDR)));
            O_da_err<= (((DA_buf[DSTADDR_SIZE-1:0] != MAC_ADDR) && (DA_buf[DSTADDR_SIZE-1:0] != BCT_ADDR)));
        end
end

endmodule

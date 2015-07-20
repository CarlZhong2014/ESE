//module MAC_rx_ctrl(
module TMP(
Clk     ,
Reset   ,
//RMii interface
ICrs_dv ,
IRx_er  ,
IRx_d   ,
//MAC_rx_addr_check interface
Oadd_en        ,
Iaddr_chk_err  ,
//MAC_rx_CRC_check interface
ICRC_chk_err   ,
OCRC_en        ,
OCRC_init      ,
//MAC_rx_FIFO  ,

);


//端口定义
input CLK,RESET;
input CRS_DV;
input CRS_DV;        //接收使能信号。
input[3:0] HFBYTE;   //接收到的前半个字节数据。
input[11:0] NBTCNT;  //计数器输出，用于判断帧是否过长或过短。
input DAerr;         //目的地址错误信号。
input CRCY;          //CRC校验正确信号。
input RDone;         //向上层递交帧结束信号。
input IFGEND;        //帧间隙
//端口定义结束

//状态码定义
parameter SRevIdle=4'b0000, SRevPre=4'b0001, SRevSFD=4'b0010, SRevDA=4'b0011;
parameter SRevSA=4'b0100, SRevLD=4'b0101, SRevHD=4'b0110, SRevCRC=4'b0111;
parameter SRevSplist=4'1001,SRevDrop=4'b1111;
//状态码定义结束

//类型声明
reg[3:0] CurStat,NextStat;
//类型声明结束

//状态机初始化
always@(posedge CLK or negedge RESET)
begin
    if (~RESET)
        CurStat <= SRevDrop;
    else
        CurStat <= NextStat;
end
//初始化结束

always@(RESET or CurStat)
begin
    case (CurStat)
	 //当CRS_DV有效且收到的半个字节数据为非0x5时，转入前导码态。否则继续等待。
        SRevIdle:
            begin
                if((CRS_DV)&&(HFBYTE!=4'H5))
                    NextStat<=SRevPre;
                else
                    NextStat<=SRevIdle;
            end
		  SRevPre:
            begin
                if(~CRS_DV)
                    NextStat<=SRevDrop;
                else
                    if(HFBYTE==4'H5)
                        NextStat<=SRevSFD;
                    else
                        NextStat<=SRevPre;
            end
		  SRevSFD:
                if(~CRS_DV)
                    NextStat<=SRevDrop;
                else
                    if(HFBYTE==4'HD)
                        NextStat<=SRevDA;
                    else
                        NextStat<=SRevSFD;
            end
		  SRevDA:
                if((~CRS_DV)||(DAerr))
                    NextStat<=SRevDrop;
                else
                    if((CRS_DV)&&(~DAerr)&&(NBTCNT==12'd12))
                        NextStat<=SRevSA;
                    else
                        NextStat<=SRevDA;
            end
		  SRevSA:
                if(~CRS_DV)
                    NextStat<=SRevDrop;
                else
                    if((CRS_DV)&&(NBTCNT==12'd24))
                        NextStat<=SRevLD;
                    else
                        NextStat<=SRevSA;
            end
		  SRevLD:
            begin
                if( (~CRS_DV)||( (~CRS_DV)&&(NBTCNT<12'd128)))
                    NextStat<=SRevDrop;
                else
                    NextStat<=SRevHD;
            end
		  SRevHD:
            begin
                if( (NBTCNT>12'd3036)||( (~CRS_DV)&&(NBTCNT<12'd128)))
                    NextStat<=SRevDrop;
                else if (CRS_DV)
                    NextStat<=SRevLD;
					 else
                    NextStat<=SRevCRC;
            end
		  SRevCRC:
            begin
                if((CRCY)
                    NextStat<=SRevSplist;
                else
                    NextStat<=SRevDrop;
            end
        SRevSplist:
            begin
                if(RDone)
                    NextStat<=SRevIdle;
                else
                    NextStat<=SRevSplist;
            end
        SRevDrop:
            begin
                if((IFGEND)
                    NextStat<=SRevIdle;
                else
                    NextStat<=SRevDrop;
            end
		  default:
            begin
                NextStat<=SRevDrop;
            end
    endcase
end

endmodule

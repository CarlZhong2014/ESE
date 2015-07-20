//
//音符产生模块
//
//描述：
//		4HzCLK的每个上升沿时产生一个地址给ROM来读取音符。
////////////////////////////////////////////////

module NODE(CLK4H,RST_N,OADDR,Index);
input CLK4H,RST_N;
input[3:0] Index;
output[6:0] OADDR;
reg[6:0] OADDR;
reg[7:0] CO;

parameter MAX=7'd63; //最大的地址
parameter COM=8'H18; //有效音符的播放周期
always@(posedge CLK4H or negedge RST_N)
begin
    if (~RST_N) //初始化
	 begin
	     OADDR<=7'b000001;
		  CO<=8'H00;
	 end
    else 
	     if(OADDR == MAX ) //判断是否达到ROM的最大地址
		  begin
		      OADDR<=7'b000001;
				CO<=8'H00;
		  end
		  else if (Index == 4'b0000 ) //音符0表示休止，在本设计中，休止符只播放一个时钟周期。
		      begin
					if (CO == 8'H0B)
					begin
					    OADDR<=OADDR + 1'b1;
					    CO<=8'H00;
					end
					else
					    CO<=CO + 1'b1;
				end
				else if (CO == COM) //音符为非0时，在本设计中，播放两个时钟周期。（该值可修改COM得到）
		      begin
					OADDR<=OADDR + 1'b1;
					CO<=8'H00;
				end
				else
			      CO<=CO + 1'b1;
			
end
endmodule

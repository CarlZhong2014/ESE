//
//内部复位产生模块
//
//通过计数ENIR使能信号高电平的次数来控制重置信号保持的时间。
//
//////////////////////////////////////////////////////////
module IR(ENIR,RST_N,CLK,IR_N);   //端口定义
input RST_N,CLK,ENIR;
output IR_N;
reg IR_N;
reg[1:0] I_CO;
always@(posedge CLK or negedge RST_N)      //以4MHz时钟作为计数基准时钟
begin
    if (~RST_N)
	 begin
	     IR_N<=1'b0;
		 I_CO<=2'b00;
	 end
    else 
	 if (ENIR == 1'b1)
	     if (I_CO == 2'b11)
	         begin I_CO<= I_CO; IR_N<=1'b1;end
	     else 
	    	   I_CO<=I_CO + 1'b1;
	else
		IR_N <= IR_N;
end
endmodule

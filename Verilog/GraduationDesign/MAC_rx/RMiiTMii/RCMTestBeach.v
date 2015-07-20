`timescale 1ns / 1ns
module RCMTestBeach;
reg CLK,RT;
reg CLK2;
reg[1:0] RD;
wire[3:0] DO;
reg[3:0] DO2;

integer i,d;

TMP RCM(CLK,RT,RD,DO);
initial  						//设置时钟周期
begin:clock_gen
		CLK = 1;
		forever 
		begin
			#10 CLK = ~CLK;
		end
end

initial  						//设置时钟周期
begin:clock_gen2
		CLK2 = 1;
		forever 
		begin
			#20 CLK2 = ~CLK2;
		end
end

initial
begin
	RT=0;
	#40 begin RT=1;RD=00; end
	for (d=0;d<14;d=d+1)
	begin
		#(d * 10) RD=00;
		for(i=0;i<14;i=i+1)
		begin
			#20 RD=01;
		end
		#20 RD=01;
		#20 RD=01;
		#20 RD=11;
		#20 RD=01;
	end

	#50 $finish;
end

initial  		
begin
		forever 
		begin
			#40 DO2 = DO;
		end
end
endmodule

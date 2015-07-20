`timescale 1ns / 1ns
module MSCt();
reg C4m,Re;
wire spk;
MSC ti(C4m,Re,spk);
initial  						//设置时钟周期
	begin:clock_gen
		C4m = 1;
		forever 
		begin
			#125 C4m = ~C4m;
		end
	end

initial
begin
     Re=1;
	 #300 Re<=0;
	 #250 Re<=1;
	 #(343597380 * 20)
	 #(343597380 * 20)
	 #(343597380 * 20)
	 #(343597380 * 20)
	 #(343597380 * 20)
	 #(343597380 * 20)
	 #(343597380 * 20)
	 #(343597380 * 20)
	 #(343597380 * 20)
	 #343597380 
	 #100 $finish;
end
endmodule

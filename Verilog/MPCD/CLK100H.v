///////////////////////////////////////////////////////////////
//时钟分频模块												 //
//															 //
//描述：													 //
//	将4MHz的时钟分频一个100Hz的时钟，						 //
//  并产生复位使能端，作为内部复位信号产生的控制端。	     //
//														     //
///////////////////////////////////////////////////////////////
module CLK100H(CLK,RST_N,O100HCLK,ENIR);
input CLK;				//4MHz CLK
input RST_N;			//重置信号
output O100HCLK;
output ENIR;
reg ENIR;				//内部复位使能信号
reg[18:0] MOD;			
reg O100HCLK;
parameter MOD_CO=16'H4E20;    //100Hz


always@(posedge CLK or negedge RST_N)
begin
    if(~RST_N)
	 begin
	     MOD<=0;
		  O100HCLK<=1'b1;
		  ENIR<=1'b0;
	 end
	 else
	 begin
	     if(MOD == MOD_CO)
		  begin
			MOD<=0;
			O100HCLK<=~O100HCLK;
			ENIR<=1'b1;
		  end
		  else
		  begin
		     MOD<=MOD + 1'b1;
			  ENIR<=1'b0;
		  end
	 end
		      
end

endmodule
 
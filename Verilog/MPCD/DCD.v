//
//数控分频模块
//
//描述
//    
///////////////////////////////////////////////
module DCD(Clk4M,RST_N,ITone,OSpk);
input Clk4M, RST_N;
input [12:0] ITone;
output OSpk;
reg OSpk;
reg TSpk;
reg [12:0] TCo;
parameter PLC=13'd8191;
	
always@(posedge Clk4M or negedge RST_N)
begin
	if (~RST_N)
		TCo <= ITone;
	else if (TCo == PLC)
	         TCo <= ITone;
	     else
				TCo <= TCo + 1;

end

always@(TCo)
begin
    if (TCo == PLC)
        TSpk <= 1'b1;
	 else
	     TSpk <= 1'b0;
end

//对TSpk进行二分频。
always@(posedge TSpk or negedge RST_N)
begin
    if (~RST_N)
	     OSpk <= 1;
	 else if (ITone ==PLC)
	     OSpk <= 1;
		  else 
			OSpk <= ~OSpk;
  
end
endmodule


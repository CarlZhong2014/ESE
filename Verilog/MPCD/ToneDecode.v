//
//音符译码模块
//
//描述：
//     得到每个音符的分频系数初始值。（以4MHz为基准）
//
/////////////////////////////////////////////
module ToneDecode(Index,OTone);
input [3:0] Index;
output [12:0]OTone;
reg [12:0]OTone;

always@(Index)
begin
	case(Index)
	    4'b0000:OTone=13'd8191;
		4'b0001:OTone=13'd548;
		4'b0010:OTone=13'd1382;
		4'b0011:OTone=13'd2125;
		4'b0100:OTone=13'd2465;
		4'b0101:OTone=13'd3090;
		4'b0110:OTone=13'd3647;
		4'b0111:OTone=13'd4142;
		4'b1000:OTone=13'd4370;
		4'b1001:OTone=13'd4787;
		4'b1010:OTone=13'd5158;
		4'b1011:OTone=13'd5328;
		4'b1100:OTone=13'd5641;
		4'b1101:OTone=13'd5919;
		4'b1110:OTone=13'd6167;
		4'b1111:OTone=13'd6281;
	endcase
end
endmodule

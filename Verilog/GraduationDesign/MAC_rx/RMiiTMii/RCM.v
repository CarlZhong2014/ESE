module RCM(CLK,RESET,REV_D,OUT);
input CLK,RESET;
input[1:0] REV_D;
output[3:0] OUT;

reg[3:0] OUT;
reg Tco;
always@(posedge CLK or negedge RESET)
begin
	if(~RESET)
	begin
		OUT<=4'b0000;
		Tco<=1'b0;
	end
	else
	begin
		if (Tco==1'b1)
		begin
			OUT[3:2]<=REV_D;
			Tco<=1'b0;
		end
		else
		begin
			Tco<=1'b1;
			OUT[1:0]<=REV_D;
		end
	end
end

endmodule

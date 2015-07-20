module ROM(ADDR,OIndex);
input[6:0] ADDR;
output[3:0] OIndex;
reg[3:0] OIndex;
always@(ADDR)
 begin
   case(ADDR)
				
				7'd1:OIndex<=4'b1000;  //1
				7'd2:OIndex<=4'b0000;  //停顿
				7'd3:OIndex<=4'b1001;  //2
				7'd4:OIndex<=4'b0000;  //停顿
				7'd5:OIndex<=4'b1010;  //3
				7'd6:OIndex<=4'b0000;  //停顿
				7'd7:OIndex<=4'b1000;  //1
				7'd8:OIndex<=4'b0000;  //停顿
				7'd9:OIndex<=4'b1100;  //5 
				7'd10:OIndex<=4'b1100; 
				7'd11:OIndex<=4'b1100; 
				7'd12:OIndex<=4'b1100; 			
				7'd13:OIndex<=4'b0000;  
				
				7'd14:OIndex<=4'b1101;  //6
				7'd15:OIndex<=4'b0000;  
				7'd16:OIndex<=4'b1101;  //6
				7'd17:OIndex<=4'b0000;  
				7'd18:OIndex<=4'b1111;  //1+
				7'd19:OIndex<=4'b0000;  
				7'd20:OIndex<=4'b1101;  //6
				7'd21:OIndex<=4'b0000; 
				7'd22:OIndex<=4'b1100;  //5
				7'd23:OIndex<=4'b1100;  
				7'd24:OIndex<=4'b1100;  
				7'd25:OIndex<=4'b1100;  
				7'd26:OIndex<=4'b0000;  				
	

				7'd27:OIndex<=4'b1101;  //6
				7'd28:OIndex<=4'b0000; 
				7'd29:OIndex<=4'b1101;  //6
				7'd30:OIndex<=4'b0000; 
				7'd31:OIndex<=4'b1111;  //1+
				7'd32:OIndex<=4'b0000; 
				7'd33:OIndex<=4'b1111;  //1+
				7'd34:OIndex<=4'b0000; 
			
				7'd35:OIndex<=4'b1100;  //5
				7'd36:OIndex<=4'b0000;  
				7'd37:OIndex<=4'b1101;  //6
				7'd38:OIndex<=4'b0000; 
				7'd39:OIndex<=4'b1010;  //3
				7'd40:OIndex<=4'b0000;  
				7'd41:OIndex<=4'b1010;  //3
				7'd42:OIndex<=4'b0000;  
		
				7'd43:OIndex<=4'b1101;  //6
				7'd44:OIndex<=4'b0000;  
				7'd45:OIndex<=4'b1100;  //5
				7'd46:OIndex<=4'b0000;  
				7'd47:OIndex<=4'b1010;  //3
				7'd48:OIndex<=4'b0000; 
				7'd49:OIndex<=4'b1100;  //5
				7'd50:OIndex<=4'b0000;  
				
				7'd51:OIndex<=4'b1010;  //3
				7'd52:OIndex<=4'b0000; 
				7'd53:OIndex<=4'b1000;  //1
				7'd54:OIndex<=4'b0000;  
				7'd55:OIndex<=4'b1001;  //2
				7'd56:OIndex<=4'b0000; 
				7'd57:OIndex<=4'b1010;  //3
				7'd58:OIndex<=4'b0000; 
				
				7'd59:OIndex<=4'b1000;  //1
				7'd60:OIndex<=4'b1000;  
				7'd61:OIndex<=4'b1000;   
				7'd62:OIndex<=4'b1000; 
				7'd63:OIndex<=4'b0000; 

    endcase
  end
endmodule
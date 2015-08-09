`timescale 1ns / 1ns
module rx_DACheck_TB;
reg clk     ;
reg rst     ;
reg I_en_ck ;
reg I_en_mix;
reg[3:0]  I_da_hf ;
reg[11:0] I_rd_cnt;
wire O_da_ok ;
wire O_da_err;

parameter CLOCK_PERIOD=50;
MAC rx_DAC_TB(
//rx_DACheck rx_DAC_TB(
.clk(clk)     ,
.rst(rst)     ,
.I_en_ck(I_en_ck)  ,    
.I_en_mix(I_en_mix),    
.I_da_hf(I_da_hf)  ,     
.O_da_ok(O_da_ok)  ,    
.O_da_err(O_da_err)    
);

//设置时钟周期
initial 
begin:clock_gen
	clk = 1;
    forever begin
    #(CLOCK_PERIOD/2) clk = ~clk;
    end
end

initial
begin:reset
    rst=1;
    #(CLOCK_PERIOD/2) rst=0;
    #(CLOCK_PERIOD/2) rst=1;
    
end

initial
begin
	 #(CLOCK_PERIOD*50) $finish;   
end

always@(posedge clk or negedge rst)
begin
    if(~rst)
        I_rd_cnt<=0;
    else if(I_en_ck)
	I_rd_cnt<=I_rd_cnt+1'b1;
    else
	I_rd_cnt<=0;
end

always@(posedge clk or negedge rst)
begin
    if(~rst)
        I_en_ck<=0;
    else if(I_rd_cnt==11)
	I_en_ck<=0;
    else
	I_en_ck<=1;
end

always@(posedge clk or negedge rst)
begin
    if(~rst)
        I_da_hf<=4'H0;
    else 
	case (I_rd_cnt)
       0:I_da_hf=4'H0 ;
	    1:I_da_hf=4'H0 ;
	    2:I_da_hf=4'H0 ;
	    3:I_da_hf=4'HC ;
	    4:I_da_hf=4'H2 ;
	    5:I_da_hf=4'H9 ;
	    6:I_da_hf=4'H4 ;
	    7:I_da_hf=4'HA ;
	    8:I_da_hf=4'H3 ;
	    9:I_da_hf=4'H5 ;
	    10:I_da_hf=4'H5;
	    11:I_da_hf=4'H0;
	    default:I_da_hf=4'Hz;
	endcase
end
endmodule

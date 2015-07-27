`timescale 1ns / 1ns
module FIFO_TB;
reg clk    ;
reg rst    ;
reg en_rd  ;
reg en_wr  ;
reg[1:0] w_data ;

wire full  ;
wire empty ;
wire[1:0] r_data;
parameter CLOCK_PERIOD=50;
integer done;
FIFO FIFO_TBM(
.clk(clk)        ,
.rst(rst)        ,
.IEN_rd(en_rd)   ,
.IEN_wr(en_wr)   ,
.I_data(w_data)  ,
.O_data(r_data)  ,
.OFIFO_full(full),
.OFIFO_empty(empty)
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
begin:RESET
    rst=0;
    #(CLOCK_PERIOD/2) rst=1;
    #CLOCK_PERIOD rst=0;
	 done=1;
    while(done)
    begin
	if (!full)
	begin
	    en_wr=1;
	    #CLOCK_PERIOD w_data<={$random}%4;
	end
	else
	    begin en_wr=0; done=0; end
    end
    done=1;
    #(CLOCK_PERIOD*4)
    while(done)
    begin
	if(!empty)
        #CLOCK_PERIOD en_rd=1;
        else
	    begin en_rd=0; done=0; end
    end
end

initial
begin
    #3000 $finish;
end

endmodule

`timescale 1ns / 1ns
module uart_testbench();
reg Clk, Ret_n;
reg rs_tx;  					//发送数据
wire rs_rx;						//接收数据
parameter  CLOCK_PERIOD = 20;	//最小时钟周期50MHz
parameter  SXRX_SCALE = 104167; //设置波特率
parameter  max = 512;			//设置最大的激励数
reg [7:0]sd_tmp,rd_tmp;		//等待发送的数据和接收的数据 
integer num,msum,umsum;			//计数和设定随机激励个数变量。
reg ren;						//接收使能端
integer mfs,umfs,mlog;

my_uart_top uart (				//实例化
				.clk(Clk),.rst_n(Ret_n),
				.rs232_rx(rs_tx),.rs232_tx(rs_rx)
				);
				
initial  						//设置时钟周期
	begin:clock_gen
		Clk = 1;
		forever begin
			#(CLOCK_PERIOD/2) Clk = ~Clk;
		end
	end
	
initial 						//初始化
	begin:init
		Ret_n = 0;
		#(CLOCK_PERIOD*1) Ret_n = 1;
		rs_tx = 1;
		ren = 1'b0;
		num=8'd0;
		umsum = 0;
		msum = 0 ;
		mfs=$fopen("C:\Users\CarlZhong\Desktop\verification\mfs.txt");
		umfs=$fopen("C:\Users\CarlZhong\Desktop\verification\umfs.txt");
		mlog=$fopen("C:\Users\CarlZhong\Desktop\verification\mlog.txt");
	end

initial							//验证主体
	begin:verification
		
		while (num <=5)
		begin
			#(SXRX_SCALE*15) ramsim(sd_tmp);	//长延迟是为了避免在接受数据时，发送新的数据，从而扰乱结果。
			#SXRX_SCALE std();
			num = num+1'b1;
		end
		#(SXRX_SCALE * 50 * 6 )traversal();
	end
task traversal;
begin
	sd_tmp=8'd0;
		
	while (num<256)
		begin
			std();
			num = num+1'b1;
			#(SXRX_SCALE*16)  sd_tmp = sd_tmp + 1'b1;
		end
end
endtask
task ramsim;					//产生随机激励
	output[7:0] data;
	reg[1:0] high_data, mid_data, low_data;
begin
    begin
	    high_data = {$random} % 3;	//百位
		if(high_data==2)
			mid_data = {$random} % 6;//十位
	    else
            mid_data = {$random} % 10;//十位	  
		if(high_data==2&mid_data==5)
            low_data = {$random} % 6;//个位
		else 
            low_data = {$random} % 10;//个位		 
		data = {high_data,mid_data, low_data};
	    end
end
endtask

task std;				//发送数据
begin
	#SXRX_SCALE rs_tx = 0;
	#SXRX_SCALE rs_tx = sd_tmp[0];
	#SXRX_SCALE rs_tx = sd_tmp[1];
	#SXRX_SCALE rs_tx = sd_tmp[2];
	#SXRX_SCALE rs_tx = sd_tmp[3];
	#SXRX_SCALE rs_tx = sd_tmp[4];
	#SXRX_SCALE rs_tx = sd_tmp[5];
	#SXRX_SCALE rs_tx = sd_tmp[6];
	#SXRX_SCALE rs_tx = sd_tmp[7];
	#SXRX_SCALE rs_tx = 1;
end
endtask


always@(posedge Clk)	//接收数据
begin

	if((rs_rx==0)&&(ren == 0))	//当接收使能端为0且收到数据起始位时，将使能端置为1
		ren=1;
	else if (ren)
		begin
			#(SXRX_SCALE * 1.5 ) rd_tmp[0] = rs_rx;
			#SXRX_SCALE rd_tmp[1] = rs_rx;
			#SXRX_SCALE rd_tmp[2] = rs_rx;
			#SXRX_SCALE rd_tmp[3] = rs_rx;
			#SXRX_SCALE rd_tmp[4] = rs_rx;
			#SXRX_SCALE rd_tmp[5] = rs_rx;
			#SXRX_SCALE rd_tmp[6] = rs_rx;
			#SXRX_SCALE rd_tmp[7] = rs_rx;
			#SXRX_SCALE begin 
						ren = 0; 	//接收数据完成后，关闭接收。
						check();	//比对收发数据
						rd_tmp = 8'd0; //比对后将接收队列清空
						end 
		end
	else
		ren = 0;
end

task check;  //匹配数据
begin
	if (rd_tmp==sd_tmp)
	begin
		$fdisplay(mfs,"  (%d) tx = %b and rx = %b is match",num, sd_tmp, rd_tmp);
		msum = msum + 1;
	end
	else
	begin
		$fdisplay(umfs,"error : (%d) tx = %b and rx = %b isn't match!!!",num, sd_tmp, rd_tmp);
		umsum = umsum + 1; 
	end
end
endtask

initial
	begin
		$fmonitor(mlog,$time,,,"tx=%b rx=%b", sd_tmp, rd_tmp);
		
		# (max * 50 * SXRX_SCALE) begin 	
				$fdisplay(mlog,"Test successfully \n Report : \n unmatch sum = %d  \n match sum = %d ", umsum, msum);
				end
			
		#SXRX_SCALE begin 
					$fclose(mfs);
					$fclose(umfs);
					$fclose(mlog);
					$finish; end

	end

endmodule
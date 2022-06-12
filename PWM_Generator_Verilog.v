`timescale 1ns/10ps
module PWM_Generator_Verilog(
    input           clk,
	 input			  speed_ctrl,
    output          led_out
);

	parameter   DELAY1 = 1;
	parameter   DELAY2 = 5;
	parameter   DELAY3 = 20;
	parameter   DELAY4 = 20;


	wire           delay_1, delay_2, delay_3, delay_4;
	reg            pwm;
	reg     [4:0]	cnt1;
	reg     [6:0]  cnt2;
	reg     [8:0]  cnt3;
	reg     [8:0]  cnt4;
	reg            display_state;
	
	
	divfreq D1(.CLK(clk), .speed_ctrl(speed_ctrl), .CLK_time(clk_div));


	//延時1
	always @(posedge clk_div)begin
		 if(cnt1 == DELAY1 - 1'b1)
			  cnt1 <= 4'b0;
		 else 
			  cnt1 <= cnt1 + 1'b1;
	end

	assign delay_1 = (cnt1 == DELAY1 - 1'b1)? 1'b1:1'b0;

	// print state
	assign print_delay_1 = delay_1;


	//延時2
	always @(posedge clk_div)begin
		 if(delay_1 == 1'b1)begin
			  if(cnt2 == DELAY2 - 1'b1)    
					cnt2 <= 6'b0;
			  else 
					cnt2 <= cnt2 + 1'b1;
		 end
		 else 
			  cnt2 <= cnt2;
	end
	assign delay_2 = ((delay_1 == 1'b1) && (cnt2 == DELAY2 - 1'b1))? 1'b1:1'b0;

	// print state
	assign print_delay_2 = delay_2;

		
	//延時3
	always @(posedge clk_div)begin
		 if(delay_2)
		 begin
				if(cnt3 == DELAY3 - 1'b1)
					cnt3 <= 8'b0;
			  else 
					cnt3 <= cnt3 + 1'b1;
		  end
		 else 
			  cnt3 <= cnt3;    
	end

	assign delay_3 = ((delay_2 == 1'b1) && (cnt3 == DELAY3 - 1'b1))? 1'b1:1'b0;

	// print state
	assign print_delay_3 = delay_3;
	
	
	//延時4
	always @(posedge clk_div)begin
		 if(delay_3)
		 begin
				if(cnt4 == DELAY4 - 1'b1)
					cnt4 <= 8'b0;
			  else 
					cnt4 <= cnt4 + 1'b1;
		  end
		 else 
			  cnt4 <= cnt4;    
	end

	assign delay_4 = ((delay_3 == 1'b1) && (cnt4 == DELAY4 - 1'b1))? 1'b1:1'b0;

	// print state
	assign print_delay_4 = delay_4;
	
	

	//state change
	always @(posedge clk_div)begin
		 if(delay_4)	//切換一次led燈顯示狀態
			  display_state <= ~display_state;
		 else 
			  display_state <= display_state;
	end

	//pwm信號的產生
	always @(posedge clk_div)begin
		 case(display_state)
				1'b0: pwm <= (cnt3 < cnt4)? 1'b1:1'b0;
				1'b1: pwm <= (cnt3 < cnt4)? 1'b0:1'b1;
				default: pwm <= pwm;
		 endcase
	end

	assign led_out = pwm;

endmodule 

module divfreq(input CLK, input speed_ctrl, output reg CLK_time);
	
	reg	[25:0]	Count;
	reg 	[14:0]		sp;
	
	always@ (posedge CLK or negedge speed_ctrl) begin
		if (!speed_ctrl) sp = 15'd5000;
		else sp = 15'd2500;
	end
		
	always @(posedge CLK) begin
		if(Count > sp) begin
			// 5000
			// 25000000 1HZ
			Count <= 25'b0;
			CLK_time <= ~CLK_time;
		end
		else
			Count <= Count + 1'b1;
	end
endmodule
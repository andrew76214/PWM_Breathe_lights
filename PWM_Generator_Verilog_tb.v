module PWM_Generator_Verilog_tb();
	reg			clk, speed_ctrl;
	reg [8:0]	temp;
	wire			led_out;
	
	always #50	clk = ~clk;
	
	initial begin
		#51	speed_ctrl = 0;	
		#102	temp = 0;
		#250;
	end
	
	PWM_Generator_Verilog PP(.clk(clk), .speed_ctrl(speed_ctrl), .led_out(led_out));
	
	always@ (posedge clk) begin
		temp <= #1 temp + 1;
		if (temp[8]) begin
			speed_ctrl = 1;
		end
	end
	
endmodule
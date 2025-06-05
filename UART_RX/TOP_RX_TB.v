module top_rx_tb;

reg 		clk;
reg 		reset;
reg		p_sel;
reg 		rx;
wire 		baud_tick;
wire 		p_error;
wire [7:0] 	d_out;
wire 		stop_error;


always #1 clk = ~clk;


top_rx uut_rx( 
		.clk	 	(clk		),
		.reset		(reset	   	),
                .rx	        (rx	   	),
                .baud_tick      (baud_tick 	),
		.p_sel		(p_sel		),
                .p_error        (p_error   	),
                .d_out	        (d_out  	),
                .stop_error     (stop_error	)
	);



initial begin
	clk	= 0;
	reset 	= 0;

 #20;

 	reset 	= 1;

 p_sel = 1;
 send_bit(0);//start
 send_bit(1);//0
 send_bit(0);
 send_bit(1);
 send_bit(0);
 send_bit(1);
 send_bit(0);
 send_bit(1);
 send_bit(0);//7
 send_bit(1);//parity

 #1000;


 p_sel = 0;
 send_bit(0);//start
 send_bit(1);//0
 send_bit(0);
 send_bit(1);
 send_bit(0);
 send_bit(1);
 send_bit(0);
 send_bit(1);
 send_bit(0);//7
 send_bit(1);//parity

 #100000;
 $finish;
end

task send_bit(input reg value);
 begin
	 @(posedge baud_tick);
		rx = value;
 end
endtask

initial begin
	$monitor("rx = %0b baud_tick = %0b", rx, baud_tick);
	$dumpfile("dump.vcd");
	$dumpvars;
end

endmodule

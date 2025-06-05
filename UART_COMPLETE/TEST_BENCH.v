module test_uart;


reg 		reset;
reg		clk;
reg		send;
reg		p_sel;
reg  [7:0]	d_in;
wire 		tx;
wire		rx;
wire [7:0]	d_out;
wire 		p_error; 
wire            stop_error;

always #1 clk = ~clk;


top_module uut_tb(	.reset		(reset		),
                        .clk  		(clk		),
                        .send 		(send		),
                        .p_sel		(p_sel		),
                        .d_in 		(d_in		),
                        .tx   		(tx     	),
                        .rx   		(rx     	),
                        .d_out 		(d_out		),
			.p_error	(p_error	),
			.stop_error	(stop_error	)
		);

initial begin 
	clk = 0;
	reset = 0;
	#30;
	reset =1;
	d_in = 8'hFF;
	p_sel = 1;
	send = 1;
end

//always @(posedge test) begin
//	d_in = $random;
//end


initial begin
	$monitor("%t tx = %0b d_out = %0h", $time, tx, d_out);
$dumpfile("test.vcd");
$dumpvars;
#1000000;
$finish;
end



endmodule

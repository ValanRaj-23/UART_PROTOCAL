module top_tb;

reg 		clk;
reg 		reset;
reg		start;
reg	[7:0]	data;
reg 		p_sel;
wire		tx_out;
wire		baud_wire;

always #1 clk = ~clk;


uart_tx_top uut(	.clk  		(clk),  
			.reset		(reset),
                	.start  	(start),
			.p_sel		(p_sel),
                	.data   	(data), 
                	.tx_out 	(tx_out),
			.baud_wire	(baud_wire)
		);

initial begin
	clk = 0;
	reset = 0;
	start = 0;
	p_sel = 1;
	data = 8'hAA;
       	#20;
	reset = 1;
	start = 1; 		
end

initial begin
	$dumpfile("dump.vcd");
	$dumpvars;
	#1000000;
	$finish;
end

always@(posedge baud_wire)
	$display("%t baud_wire = %0b tx_out = %0b ",$time, baud_wire, tx_out);


endmodule


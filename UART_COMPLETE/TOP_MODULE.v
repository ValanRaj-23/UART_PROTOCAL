	module top_module (
	input 		reset,
	input		clk,
	input		send,
	input		p_sel,
	input  [7:0]	d_in,
	output 		tx,
	output		rx,
	output [7:0]	d_out,
	output		p_error,
	output		stop_error
	);



	wire baud_tick;
	wire out;

		baud_tick_generator uut_bd_gen(	.clk(clk),
						.reset(reset),
						.baud_tick(baud_tick)
							    );
	
		uart_tx uut_tx(			.reset(reset),
		         			.clk(clk),
		         			.send(send),
		         			.d_in_tx(d_in),
		         			.bclk_tx(baud_tick),
		         			.p_sel(p_sel),
		         			.tx(tx)
		                         );

		uart_rx utt_rx(			.clk(clk),
				  		.reset(reset),
				  		.rx(rx),
				  		.bclk_rx(baud_tick),
				  		.p_error(p_error),
						.stop_error(stop_error),
				  		.d_out_rx(d_out)
				                );


		assign test = baud_tick;
		assign rx = tx;
	endmodule

 module top_rx(

 	input 			clk		, 
	input			reset		,
 	input 			rx		,
	input			p_sel		,
 	output 			baud_tick	, 
 	output  		p_error		,
 	output 		[7:0] 	d_out		,
 	output  		stop_error 	
);


uart_rx uut_rx(		
			.clk	 	(clk		), 
                        .baud_tick      (baud_tick 	),
                        .rx	        (rx	   	),
			.p_sel		(p_sel	        ),
                        .p_error        (p_error   	),	  
                        .d_out_rx       (d_out	   	),
			.stop_error     (stop_error	)
		);

baud_tick_generator uut_baud(

			.clk	 	(clk	   ), 
                        .reset	        (reset	   ),
                        .baud_tick      (baud_tick )
		);
		
endmodule


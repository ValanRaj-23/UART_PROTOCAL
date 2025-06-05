module uart_rx(
 	input 			clk		, 
 	input 			baud_tick	, 
 	input 			rx		,
	input 			p_sel		,
 	output reg 		p_error		,
 	output reg	[7:0] 	d_out_rx	,
 	output reg 		stop_error 
);
 	reg [2:0] present = 0;
 	reg [2:0] next; 
 	reg [3:0] count = 0;
	
 	reg parity_bit	= 0; 
	
	parameter [1:0]	IDLE 	= 2'b00,
			RECEIVE	= 2'b01,
			PARITY	= 2'b10,
			STOP	= 2'b11;
	
		always@(*) begin
			present=next;
		end

	
 		always @(posedge clk) begin
 		case (present)

 			IDLE:
		      	begin 
 				if (baud_tick && rx == 0) begin
 					next 	<= RECEIVE; 
 					count 	<= 0;
				end
 			end

			RECEIVE:
			begin
 				if (baud_tick) begin
 					d_out_rx 		<= {rx, d_out_rx[7:1]}; //Serial in - LSB first 
 					if (count == 7) begin
 						next 		<= PARITY; 
 					end
					else begin
 						count 		<= count + 1;
 					end
				end
 			end

 			PARITY:
		       	begin 
 				if (baud_tick) begin
 					parity_bit = p_sel ? ^d_out_rx : !(^d_out_rx);	
 					if (parity_bit != rx) begin
 						p_error 	<= 1;
 						d_out_rx	<= 1;
 						next 		<= IDLE;
 					end 
					else begin
 						p_error 	<= 0;
 						next 		<= STOP;
					end
				end
 			end

 			STOP:
		       	begin 
 				if (baud_tick) begin
 					if (rx == 1) begin
 						stop_error <= 0; 
 					end 
					else begin
 						stop_error 	<= 1; 
 						d_out_rx	<= 0;
 					end
 					next <= IDLE; 
				end
 			end
 		endcase
	end
endmodule



 

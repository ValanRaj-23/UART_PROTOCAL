module uart_tx(
 input		clk,
 input	      	reset,
 input        	send,
 input  [7:0] 	d_in_tx,
 input        	bclk_tx,
 input	 	p_sel,
 output reg   	tx
);

 parameter [2:0] IDLE   = 3'b000,
                  START  = 3'b001,
                  ADDR   = 3'b010,
                  PARITY = 3'b011,
                  STOP   = 3'b100;

 reg [3:0] count = 0;
 reg [2:0] state = IDLE;
 reg [2:0] ns;
  
always @(*) begin
 state = ns;
end

always @(posedge clk)
	if(!reset)
		ns <= IDLE;
	else begin
 	case (state)
  		IDLE: 
		begin
   		tx <= 1;
  			if (send != 1) 
				ns <= IDLE;
	  		 else 
	  	  		ns <= START;
	  	end
	
	  	START: 
		begin
  	 	if (bclk_tx) begin
	  	  		ns   <= ADDR;
	  	  		tx <= 0;
	  	 	end 
			else begin
	  	 		ns   <= START;
	  	 	 	tx <= 1;
	  	 	end
	  	end
	
	  	ADDR:
	       	begin
	  		 if (bclk_tx) 
			 begin
	  		  	tx <= d_in_tx[count];
	  		  	if (count == 4'd7) begin
	  		   		ns    <= PARITY;
	  		   		count <= 0;
	  		  	end 
				else begin
	  		   		ns    <= ADDR;
	  		   		count <= count + 1;
	  		  	end
	  		 end else
			begin
	  		  	ns <= ADDR;
			end
	  	end
	
	  	PARITY: 
		begin
	  	 	if (bclk_tx) begin
				if(p_sel)
	  	  			tx 	<= ^d_in_tx; // parity bit (XOR of all bits)
	  	  		else
					tx	<= ~(^d_in_tx);	
				ns   	<= STOP;
	  	 	end else begin
	  	  		ns 	<= PARITY;
	  	 	end 
	  	end
	
	  	STOP: 	
		begin
	  	 	
	  	 	if (bclk_tx)
			begin
				tx <= 1;
	  	  		ns <= IDLE;
			end
	  	 	else
			begin
	  	  		ns <= STOP;
	  		end
		end
	
  default: ns <= IDLE;
 endcase
end
endmodule




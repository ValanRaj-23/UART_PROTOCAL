
module baud_tick_generator
    #(              // 9600 baud
        parameter   N = 16,     
                    M = 5208    
    )
    (
        input 	clk,       	
        input 	reset,          
        output 	baud_tick       
    );
    
    // Counter Register
    reg [N-1:0] counter;        
    wire [N-1:0] next;          
   



    always @(posedge clk, posedge reset)
        if(!reset)
            counter <= 0;
        else
            counter <= next;
            
    
    

    assign next = (counter == (M-1)) ? 0 : counter + 1;
    
    
    assign baud_tick = (counter == (M-1)) ? 1'b1 : 1'b0;
       
endmodule

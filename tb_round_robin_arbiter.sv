
`timescale 1ps/1fs

module tb_round_robin_arbiter ();

                    reg         clk              ;
                    reg         reset            ;
                    reg   [3:0] incoming_requests; // 4Bit requests
                    reg         enable           ; // Activation bit
                    wire  [3:0] grant_vector     ; // Result
                    wire  [1:0] index            ; // Determines the "State"

 
 round_robin_arbiter rra2 
 
                    (
                     .clk              (clk)              ,
                     .reset            (reset)            ,
                     .incoming_requests(incoming_requests),
                     .enable           (enable)           ,
                     .grant_vector     (grant_vector)     ,
                     .index            (index)
                    );

    initial begin // Clock Generation
    clk = 1                 ;
    forever #100 clk = ~clk ;
    end


    initial begin // Reset - Enable and Requests
    reset  = 1;
    enable = 0;
    #200
    reset  = 0;
    enable = 1;

    incoming_requests =  4'b0001   ;
    #200                          // grant_vector = 0001 , index = 00
    incoming_requests =  4'b0010   ;
    #200                          // grant_vector = 0010 , index = 01
    incoming_requests =  4'b0011   ;
    #200                          // grant_vector = 0010 , index should be 01 (same)
    incoming_requests =  4'b0111   ;
    #200                          // grant_vector = 0010 , index should be 01 (same)
    incoming_requests =  4'b0100   ;
    #200                          // grant_vector = 0100 , index = 10
    incoming_requests =  4'b0110   ;
    #200                          // grant_vector = 0100 , index should be 10 (same)
    incoming_requests =  4'b0101   ;
    #200                          // grant_vector = 0100 , index should be 10 (same)
    incoming_requests =  4'b0001   ;
    #200                          // grant_vector = 0001 , index = 00 
    incoming_requests =  4'b1000   ;
    #200                          // grant_vector = 1000 , index = 11
    incoming_requests =  4'b1110   ;
    #200                          // grant_vector = 1000 , index should be 11 (same)
    incoming_requests =  4'b0010   ;
    #200                          // grant_vector = 0010 , index = 01
    incoming_requests =  4'b0011   ;
    #200                          // grant_vector = 0010 , index should be 01 (same)
    incoming_requests =  4'b0101   ;
    #200                          // grant_vector = 0100 , index = 10
    incoming_requests =  4'b0011   ;
    #200                          // grant_vector = 0001 , index = 00
    incoming_requests =  4'b0010   ;
    #200                          // grant_vector = 0010 , index = 01

    enable = 0                  ; // grant_vector and index becomes "0"

    end
   

endmodule
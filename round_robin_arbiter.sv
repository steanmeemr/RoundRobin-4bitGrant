/* =======================================================================
==========================================================================
--------------- ROUND ROBIN ARBITER for 4 BIT REQUEST-------------------==
                                                                        ==
When incoming request changes, a new index is determined and the grant  ==
vector is pushed as output. For each state, the priority of the bits of == 
request changes, and it becomes important for the next state            ==
                                                                        ==
For example;                                                            ==
For state 2'b00, bit 0 is the most important bit that indicates the     ==
output. However, for the 2'b10 state, priority is indicated according   ==
to bit 2.                                                               ==
                                                                        ==
As a final step, the module was synthesized in Quartus Prime and tested ==
in Cyclone V (5) DE1-SoC FPGA                                           ==
                                                                        ==
==========================================================================
======================================================================= */

module round_robin_arbiter ( input            clk              ,
                             input            reset            ,
                             input      [3:0] incoming_requests, 
                             input            enable           ,
                             output reg [3:0] grant_vector     ,
                             output reg [1:0] index            
                           );

reg [1:0] state ;

//PRIORITY ENCODING
//=======================
 always @(posedge clk) begin
        
        if      (reset)  begin state <= 0 ; 
        end
        
        else if (enable) begin
            case (state)
            2'b00:  begin

                       if (incoming_requests[0] == 1) begin grant_vector = 4'b0001; index = 2'b00; end // Bit [0] has priority
                  else if (incoming_requests[1] == 1) begin grant_vector = 4'b0010; index = 2'b01; end
                  else if (incoming_requests[2] == 1) begin grant_vector = 4'b0100; index = 2'b10; end
                  else if (incoming_requests[3] == 1) begin grant_vector = 4'b1000; index = 2'b11; end
                  else                                begin grant_vector = 4'b0000; index = 2'b00; end // Prevents "latch" formation in Quartus during synthesis
                    end 
            2'b01:  begin

                       if (incoming_requests[1] == 1) begin grant_vector = 4'b0010; index = 2'b01; end // Bit [1] has priority
                  else if (incoming_requests[2] == 1) begin grant_vector = 4'b0100; index = 2'b10; end
                  else if (incoming_requests[3] == 1) begin grant_vector = 4'b1000; index = 2'b11; end
                  else if (incoming_requests[0] == 1) begin grant_vector = 4'b0001; index = 2'b00; end
                  else                                begin grant_vector = 4'b0000; index = 2'b00; end // Prevents "latch" formation in Quartus during synthesis
                    end 
            2'b10:  begin

                       if (incoming_requests[2] == 1) begin grant_vector = 4'b0100; index = 2'b10; end // Bit [2] has priority
                  else if (incoming_requests[3] == 1) begin grant_vector = 4'b1000; index = 2'b11; end
                  else if (incoming_requests[0] == 1) begin grant_vector = 4'b0001; index = 2'b00; end
                  else if (incoming_requests[1] == 1) begin grant_vector = 4'b0010; index = 2'b01; end
                  else                                begin grant_vector = 4'b0000; index = 2'b00; end // Prevents "latch" formation in Quartus during synthesis
                    end 
            2'b11:  begin

                       if (incoming_requests[3] == 1) begin grant_vector = 4'b1000; index = 2'b11; end // Bit [3] has priority
                  else if (incoming_requests[0] == 1) begin grant_vector = 4'b0001; index = 2'b00; end
                  else if (incoming_requests[1] == 1) begin grant_vector = 4'b0010; index = 2'b01; end
                  else if (incoming_requests[2] == 1) begin grant_vector = 4'b0100; index = 2'b10; end
                  else                                begin grant_vector = 4'b0000; index = 2'b00; end // Prevents "latch" formation in Quartus during synthesis
                    end 
            endcase
            state <= index ;

        end
        
        else begin grant_vector = 4'b0   ;
                   index        = 2'b0  ; 
        end

    end
 
endmodule

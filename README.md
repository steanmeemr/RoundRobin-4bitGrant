# RoundRobin-4bitGrant
System verilog code for Round-Robin arbiter 

In this project, 4 Bit requests were taken and according to their indexes, grant vector and grant index values were constructed.
For each index, priority of the Bits are modified and next state was determined with respect to this priorty.

==> Priority, grant vector and grant index changes at posedge of the clock.

==> Reset makes outputs "0", and overall priority mechanism starts from beginning

==> If enable becomes low, system makes outputs "0"

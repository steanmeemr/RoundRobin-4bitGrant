# RoundRobin-4bitGrant
System verilog code for Round-Robin arbiter 

In this project, 4 Bit requests were taken and according to their indexes, grant vector and grant index values were constructed.
For each index, priority of the Bits are modified and next state was determined with respect to this priority.

==> Priority, grant vector and grant index changes at posedge of the clock.

==> Reset makes outputs "0", and overall priority mechanism starts from beginning

==> If enable becomes low, system makes outputs "0"


MODELSIM RESULT

The results that are given below were taken from Modelsim by using tb_round_robin_arbiter.sv 
![modelsim_result](https://user-images.githubusercontent.com/98144138/150492867-82e96ea3-bd52-410e-a3ca-1203c009e5c9.png)

QURTUS PRIME SYNTHESIS

After testing, module was synthesized in Quartus prime, and tested with CycloneV-DE1-SoC device
![quartus_synthesis_result](https://user-images.githubusercontent.com/98144138/150492991-3a7a6eab-b0a3-44e2-a170-933592eb8376.png)


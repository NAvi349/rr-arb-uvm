# rr-arb-uvm
This repository contains the UVM architecture of a round robin arbiter


# DUT
https://github.com/alexforencich/verilog-axi/blob/master/rtl/arbiter.v

# SV Testbench

First I created a simple SV testbench to understand how the DUT behaves.

<img width="1905" height="277" alt="image" src="https://github.com/user-attachments/assets/347e8536-509f-4e1b-a7db-68bd92924ac9" />

I First asserted all the req and observed how the grant is given one by one.

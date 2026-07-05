# rr-arb-uvm
This repository contains the UVM architecture of a round robin arbiter


# DUT
This DUT is generated entirely from LLM.

# SV Testbench

First I created a simple SV testbench to understand how the DUT behaves.

<img width="1905" height="277" alt="image" src="https://github.com/user-attachments/assets/347e8536-509f-4e1b-a7db-68bd92924ac9" />

I First asserted all the req and observed how the grant is given one by one.

# Testplan
Right now from the top of my head planning to cover this scenarios:
* Assert request for master and observe if the grant is correctly done in round robin manner.
* Check if asserting req for a single master is eventually granted.

# UVM Testbench Architecture

From previous projects, I will take the UVM testbench and adopt it to this DUT.
There will be a agent for input and agent for output. Input agent will have driver, sequencer and monitor. Output agent will have output monitor only.

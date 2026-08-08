# rr-arb-uvm
This repository contains the UVM architecture of a AHB round robin arbiter


# DUT
This DUT is generated entirely from chatbot.

# SV Testbench

First I created a simple SV testbench to understand how the DUT behaves.

<img width="1905" height="277" alt="image" src="https://github.com/user-attachments/assets/347e8536-509f-4e1b-a7db-68bd92924ac9" />

This is just to check if the RTL simulates properly without any compilation issues.

# Testplan
Right now from the top of my head planning to cover this scenarios:
* Assert request for all masters and observe if the grant is correctly served in round robin manner.
* Check if asserting req for a single master is eventually granted.
* Check if grant is asserted for a full AHB transactions for each master.
* 

# UVM Testbench Architecture

There will be a seperate master agent for each bit of the bus request.
Each agent will have a monitor because the grant and request should be going to a single master.
An output global monitor for status signals which are not needed for the masters.

The scoreboard will get the signals and write to its internal memory during write transactions. During read transactions the information is read back.
The round robin arbitation will be checked in scoreboard

I created a parameterized agents for this design, since it is expected to have four master. Each agent represents one master.

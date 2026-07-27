/* Description: 
The scoreboard will have four ports.

It will receive the transactions from both master and slave side monitors.


*/

class ahb_rr_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(ahb_rr_scoreboard)
  
  uvm_tlm_analysis_fifo #(ahb_rr_item) tx_in_fifo0;
  uvm_tlm_analysis_fifo #(ahb_rr_item) tx_in_fifo1;
  uvm_tlm_analysis_fifo #(ahb_rr_item) tx_in_fifo2;
  uvm_tlm_analysis_fifo #(ahb_rr_item) tx_in_fifo3;
  uvm_tlm_analysis_fifo #(ahb_rr_item) tx_out_fifo;

  
  function new(string name = "ahb_rr_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx_in_fifo0 = new("tx_in_fifo0", this);
    tx_in_fifo1 = new("tx_in_fifo1", this);
    tx_in_fifo2 = new("tx_in_fifo2", this);
    tx_in_fifo3 = new("tx_in_fifo3", this);
    tx_out_fifo = new("tx_out_fifo", this);
  endfunction: build_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
  endtask: run_phase
  
  
  
endclass

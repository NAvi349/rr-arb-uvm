/*
Description: This monitor will have two ports each of them will monitor the input/output of the slave side of the DUT.


*/


class ahb_rr_output_monitor extends uvm_monitor;
  `uvm_component_utils(ahb_rr_output_monitor)
  
  virtual ahb_rr_if0 xif0;
  virtual ahb_rr_if1 xif1;
  virtual ahb_rr_if2 xif2;
  virtual ahb_rr_if3 xif3;
    
  uvm_analysis_port #(ahb_rr_item) dut_tx_out;
  
  function new(string name = "ahb_rr_output_monitor", uvm_component parent);
    super.new(name, parent);
   
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    dut_tx_out = new("dut_tx_out", this); 
    uvm_config_db#(virtual ahb_rr_if0)::get(this, "", "ahb_rr_if0", xif0);
    uvm_config_db#(virtual ahb_rr_if1)::get(this, "", "ahb_rr_if1", xif1);
    uvm_config_db#(virtual ahb_rr_if2)::get(this, "", "ahb_rr_if2", xif2);
    uvm_config_db#(virtual ahb_rr_if3)::get(this, "", "ahb_rr_if3", xif3);
  endfunction

  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
    fork
      
      // input ports
      begin
        
      end
      
      // output ports
      begin
        
      end
      
    join
  endtask
  
endclass

class ahb_rr_output_agent extends uvm_agent;
  `uvm_component_utils(ahb_rr_output_agent)

  ahb_rr_output_monitor ahb_rr_o_mon;
  
  function new(string name = "ahb_rr_output_agent", uvm_component parent);
    super.new(name, parent);

  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    ahb_rr_o_mon  = ahb_rr_output_monitor::type_id::create("ahb_rr_o_mon", this);
  endfunction
  
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
  
  endfunction
  
  
endclass

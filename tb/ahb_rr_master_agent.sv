class ahb_rr_master_agent extends uvm_agent;
  `uvm_component_utils(ahb_rr_master_agent)
  
  int id = 0;
  
  ahb_rr_master_driver ahb_rr_m_drvr;
  ahb_rr_master_monitor ahb_rr_m_mon;
  ahb_rr_master_sequencer ahb_rr_m_sqr;
  
  function new(string name = "ahb_rr_input_agent", uvm_component parent);
    super.new(name, parent);

  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    uvm_config_db#(int)::get(this, "", "agent_id", id);
    
    ahb_rr_m_drvr = ahb_rr_master_driver::type_id::create("ahb_rr_m_drvr", this);
    ahb_rr_m_mon  = ahb_rr_master_monitor::type_id::create("ahb_rr_m_mon", this);
    ahb_rr_m_sqr  = ahb_rr_master_sequencer::type_id::create("ahb_rr_m_sqr", this);
  endfunction
  
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    ahb_rr_m_drvr.seq_item_port.connect(ahb_rr_m_sqr.seq_item_export);
        
  endfunction
  
endclass

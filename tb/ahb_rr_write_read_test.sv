class ahb_rr_write_read_test extends ahb_rr_base_test;
  `uvm_component_utils(ahb_rr_write_read_test )

  ahb_rr_master_sequence ahb_rr_m_seq;
  
  
  function new(string name="ahb_rr_write_read_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    ahb_rr_m_seq = ahb_rr_master_sequence::type_id::create("ahb_rr_m_seq");
  endfunction
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
    phase.raise_objection(this);
    
    `uvm_info(get_full_name, "Starting seq", UVM_LOW)
    //fork
    ahb_rr_m_seq.start(ahb_rr_env0.ahb_m_agt[0].ahb_rr_m_sqr);
    ahb_rr_m_seq.start(ahb_rr_env0.ahb_m_agt[1].ahb_rr_m_sqr);
    ahb_rr_m_seq.start(ahb_rr_env0.ahb_m_agt[2].ahb_rr_m_sqr);
    ahb_rr_m_seq.start(ahb_rr_env0.ahb_m_agt[3].ahb_rr_m_sqr);
    //join
    
    
    //#400ns;
    `uvm_info(get_full_name, "Finished fork", UVM_INFO)
    phase.drop_objection(this);
    
  endtask


endclass

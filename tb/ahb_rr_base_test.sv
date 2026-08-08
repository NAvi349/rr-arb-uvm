class ahb_rr_base_test extends uvm_test;
  `uvm_component_utils(ahb_rr_base_test)
  
  ahb_rr_env ahb_rr_env0;
  
  
  function new(string name="ahb_rr_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    ahb_rr_env0 = ahb_rr_env::type_id::create("ahb_rr_env", this);

    
  endfunction
  

  function void end_of_elaboration ();
    uvm_top.print_topology();  
  endfunction

 

  
endclass

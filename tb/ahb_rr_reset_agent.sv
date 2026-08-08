class ahb_rr_reset_driver extends uvm_driver #(ahb_rr_item);
  `uvm_component_utils(ahb_rr_reset_driver)
  
  virtual ahb_rr_rst_if ahb_rst_if;
  
  function new (string name = "ahb_rr_reset_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual ahb_rr_rst_if)::get(this, "", "ahb_rr_rst_if", ahb_rst_if );
  endfunction
  
  task run_phase(uvm_phase phase);
    ahb_rst_if.rst_n <= 0;
    repeat (8) @(posedge ahb_rst_if.clock);
    ahb_rst_if.rst_n <= 1;
   `uvm_info("RST_DRV", "reset released from reset sequence", UVM_LOW)
  endtask
  
endclass

typedef uvm_sequencer #(ahb_rr_item) ahb_rr_reset_sequencer;


class ahb_rr_reset_agent extends uvm_agent;
  `uvm_component_utils(ahb_rr_reset_agent)
  
  ahb_rr_reset_driver ahb_rr_rst_drv;
  //ahb_rr_reset_sequencer ahb_rr_rst_sqr;
  //ahb_rr_reset_monitor ahb_rr_rst_mon;
  
  function new (string name = "ahb_rr_reset_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ahb_rr_rst_drv = ahb_rr_reset_driver::type_id::create("ahb_rr_rst_drv", this);
    //ahb_rr_rst_sqr = ahb_rr_reset_sequencer::type_id::create("ahb_rr_rst_sqr", this);
  endfunction
  
  //function void connect_phase(uvm_phase phase);
  //  super.connect_phase(phase);
  //  ahb_rr_rst_drv.seq_item_port.connect(ahb_rr_rst_sqr.seq_item_export);   
  //endfunction
  
endclass


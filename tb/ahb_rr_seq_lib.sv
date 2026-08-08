
typedef uvm_sequencer #(ahb_rr_item) ahb_rr_master_sequencer;


// Sequence used for master input/slave output
class ahb_rr_master_sequence extends uvm_sequence #(ahb_rr_item);
  
  ahb_rr_item ahb_m_tx;
  
  `uvm_object_utils(ahb_rr_master_sequence)
 
  function new(string name = "ahb_rr_master_sequence");

    super.new(name);
   `uvm_info(get_full_name(), "creating master sequence", UVM_LOW)
  endfunction: new
  
  
  task body();
    `uvm_info(get_full_name(), "ahb master sequence item creation", UVM_LOW)
    ahb_m_tx = ahb_rr_item::type_id::create("ahb_m_tx");
    
    // send addr + data in single sequence item
    `uvm_info(get_full_name(), "Masterside item", UVM_LOW)
    start_item(ahb_m_tx);  // request grant
    
    ahb_m_tx.randomize();
    $display("%h addr " , ahb_m_tx.haddr);
    
    //ahb_m_tx.convert2string_with_index();
    
    finish_item(ahb_m_tx);
    
  endtask
  
  
endclass: ahb_rr_master_sequence

// create reset sequence

class ahb_rr_reset_sequence extends ahb_rr_master_sequence #(ahb_rr_item);
  
 `uvm_object_utils(ahb_rr_reset_sequence)
  
  function new(string name = "ahb_rr_reset_sequence");
    super.new(name);
    
  endfunction: new
  
  task body();
    ahb_m_tx = ahb_rr_item::type_id::create("ahb_m_tx");
    
    start_item(ahb_m_tx);
    
    ahb_m_tx.randomize with { haddr == 0; hwdata == 0; hlock == 0; hbusreq == 0; };
    
    finish_item(ahb_m_tx);
   
  endtask
  
endclass: ahb_rr_reset_sequence

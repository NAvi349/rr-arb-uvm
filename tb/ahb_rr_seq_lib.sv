
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
    
    finish_item(ahb_m_tx);
    
  endtask
  
  
endclass: ahb_rr_master_sequence

/*
Description: This is the driver of input. The driver respects the AHB protocol.
*/

class ahb_rr_master_driver extends uvm_driver #(ahb_rr_item);

  `uvm_component_utils(ahb_rr_master_driver)
  virtual ahb_rr_if xif;
   
  //uvm_sequence_item tx;
  ahb_rr_item i_tx;
  
  function new(string name = "ahb_rr_master_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual ahb_rr_if)::get(this, "", "ahb_rr_if", xif);
  endfunction
  
  
  task run_phase (uvm_phase phase);
    
    `uvm_info("INPUT_DRV", "Waiting for reset release", UVM_LOW)
    
    reset_dut();

    forever begin
      `uvm_info("INPUT_DRV", "Getting next item from sequence in input driver", UVM_LOW)
      seq_item_port.get_next_item(i_tx);

      drive_address();
      drive_data();
      drive_request();
      while (xif.hgrant === 0) begin
        @(posedge xif.clock);
      end      
      seq_item_port.item_done();
    end
    
  endtask
  
  virtual task reset_dut();
    @(posedge xif.rst_n);
    
    `uvm_info("INPUT_DRV", "Reset released", UVM_LOW)
  endtask
  
  virtual task drive_request();
    xif.hbusreq <= 'h1;
    @(xif.clock);
    `uvm_info("MST_DRV", "Drove bus request", UVM_LOW)
  endtask
  
  virtual task drive_address();
    xif.haddr  <= 'h0000_0004;
    xif.htrans <= 'h10;
    xif.hwrite <= 'h1;
    xif.hsize  <= 'b001;
    @(xif.clock);
    `uvm_info("MST_DRV", "Drove bus driver", UVM_LOW)
  endtask
  
  virtual task drive_data();
    xif.hwdata <= 'h0010_2234;    
    @(xif.clock);
    `uvm_info("MST_DRV", "Drove drive data", UVM_LOW)
  endtask
 
  endclass: ahb_rr_master_driver
